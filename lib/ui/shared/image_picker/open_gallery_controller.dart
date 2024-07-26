import 'dart:io';

import 'package:aichat/inftrastructure/constant/common_toast.dart';
import 'package:aichat/inftrastructure/model/photo_model.dart';
import 'package:aichat/inftrastructure/model/video_model.dart';
import 'package:aichat/ui/shared/theme_controller.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OpenGalleryController extends GetxController {
  List<PhotoModel> photoList = <PhotoModel>[];
  List<PhotoVideoModel> photoVideoList = <PhotoVideoModel>[];
  List<PhotoModel> selectedValues = [];
  final ThemeController themeController = Get.put(ThemeController());

  List<PhotoModel> selectedPhotosList = <PhotoModel>[];
  RxBool isLoading = false.obs;
  RxBool editView = false.obs;
  RxInt maxImage = 1.obs;
  RxBool forEdit = false.obs;

  int sizePerPage = 24;
  int pageNo = 0;

  RxBool permissionAccess = false.obs;
  final FilterOptionGroup _filterOptionGroup = FilterOptionGroup(
    imageOption: const FilterOption(
      sizeConstraint: SizeConstraint(ignoreSize: true),
    ),
  );

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments is List) {
        if (Get.arguments[0] is List<PhotoModel>) {
          selectedPhotosList = Get.arguments[0];
          selectedPhotosList.where((element) => element.image.startsWith("http")).toList();
        }

        if (Get.arguments[1] is bool) {
          editView.value = Get.arguments[1];

          if (editView.value) {
            maxImage.value = 6 - (selectedPhotosList.where((element) => element.image.startsWith("http")).toList().length);
          }
        }

        if (Get.arguments.length == 5) {
          maxImage.value = Get.arguments[4];
        }
        if (Get.arguments[2] is bool) {
          forEdit.value = Get.arguments[2];

          if (forEdit.value) {
            maxImage.value = 1;
          }
        }
      }
      update();
    }
    if (photoList.isEmpty) {
      requestAssets();
    } else {
      selectedValues = photoList;

      if (selectedPhotosList.isNotEmpty) {
        if (forEdit.value) {
          selectedValues.map((e) => e.selected = false).toList();
        } else {
          getReSelectList();
        }
      }

      update();
      pageNo = (photoList.length / 24).ceil();
      requestAssets();
    }
  }

  requestAssets() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    permissionAccess.value = preferences.getBool('photoAccess') ?? false;
    update();

    if (permissionAccess.value == false) {
      await getStoragePermission();
    }
    if (permissionAccess.value) {
      if (pageNo == 0) {
        isLoading = true.obs;
      }

      update();
      // Request permissions.
      final PermissionState ps = await PhotoManager.requestPermissionExtend();

      if (!ps.hasAccess) {
        await getStoragePermission();
        isLoading = false.obs;
        update();
        showTopToast(msg: 'Permission is not accessible.', context: Get.context!);
        return;
      }
      // Obtain assets using the path entity.
      final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
        onlyAll: true,
        filterOption: _filterOptionGroup,
        type: RequestType.image,
      );

      if (paths.isEmpty) {
        isLoading = false.obs;
        update();
        showTopToast(msg: 'No paths found.', context: Get.context!);
        return;
      }

      update();
      final List<AssetEntity> entities = await paths.first.getAssetListPaged(
        page: pageNo,
        size: sizePerPage,
      );

      entities.sort(
        (a, b) => a.id.compareTo(b.id),
      );
      entities.toSet();

      entities.where((element) => element.mimeType != null && element.mimeType!.contains('image')).toList();

      // print("entities length : ${entities.length.toString()}");

      // for(int i = 0; i < entities.length; i++) {
      //   print("path $i : ${(await entities.elementAt(i).file)!.path}");
      // }

      getPhotoModelList(entities: entities).then((value) {
        if (value.isNotEmpty) {
          isLoading = false.obs;
          //hasMoreToLoad.value = this.entities!.length < totalEntitiesCount;

          //   print("getPhotosList : ${value.length.toString()}");

          //selectedValues = value;

          selectedValues.addAll(value);
          photoList = selectedValues;

          update();
          if (value.length == sizePerPage) {
            Future.delayed(const Duration(seconds: 2)).then((value) {
              pageNo = pageNo + 1;
              requestAssets();
            });
          }

          //  print("selectedValues length : ${selectedValues.length}");
        }
      });
    }
  }

  getStoragePermission() async {

    permissionAccess = false.obs;
    update();
     Platform.isAndroid ?await Permission.storage.request() :await Permission.photos.request();
    SharedPreferences preferences = await SharedPreferences.getInstance();

    PermissionStatus status = await (Platform.isAndroid ? Permission.storage.request() : Permission.photos.request());
    if (status.isGranted) {
      // print("here 2");
      (await preferences.setBool('photoAccess', true));
      permissionAccess = true.obs;
      update();
    } else if (status.isDenied) {
      // print("here 3");
      await openAppSettings().then((value) async {
        (await preferences.setBool('photoAccess', value));
        permissionAccess = value.obs;
        update();
      });
    } else if (status.isPermanentlyDenied) {
      // print("here 4");
      await openAppSettings().then((value) async {
        (await preferences.setBool('photoAccess', value));
        permissionAccess = value.obs;
        update();
      });
    }
  }

  Future<List<PhotoModel>> getPhotoModelList({required List<AssetEntity> entities}) async {
    List<PhotoModel> photoList = [];

    List<String> filePathList = await getPathList(entities: entities);

    // print("filepath list : ${filePathList.length.toString()}");
    // print("entities list : ${entities.length.toString()}");

    if (entities.length == filePathList.length) {
      for (int i = 0; i < entities.length; i++) {
        photoList.add(PhotoModel(image: filePathList.elementAt(i), id: entities.elementAt(i).id));
      }
    }

    //print("photoList list : ${photoList.length.toString()}");

    return photoList;
  }

  Future<List<String>> getPathList({required List<AssetEntity> entities}) async {
    List<String> pathList = <String>[];

    for (int i = 0; i < entities.length; i++) {
      String paths = (await entities.elementAt(i).file)!.path;

      pathList.add(paths);
    }

    // print("pathList list : ${pathList.length.toString()}");

    return pathList;
  }

  void getReSelectList() {
    List<String> pathList = selectedPhotosList.map((e) => e.image).toList();

    for (int i = 0; i < selectedValues.length; i++) {
      if (pathList.contains(selectedValues.elementAt(i).image)) {
        selectedValues.elementAt(i).selected = true;
      }
    }
  }
}
