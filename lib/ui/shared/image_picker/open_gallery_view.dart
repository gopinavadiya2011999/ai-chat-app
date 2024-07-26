import 'package:aichat/inftrastructure/constant/color_constant.dart';
import 'package:aichat/inftrastructure/constant/image_constant.dart';
import 'package:aichat/inftrastructure/model/photo_model.dart';
import 'package:aichat/ui/common_widgets/common_inkwell.dart';
import 'package:aichat/ui/common_widgets/comon_shimmer_view.dart';
import 'package:aichat/ui/common_widgets/headline_body_text.dart';
import 'package:aichat/ui/shared/image_picker/open_gallery_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'image_item_widgets.dart';

class OpenGalleryView extends GetView<OpenGalleryController> {
  const OpenGalleryView({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OpenGalleryController>(
        init: OpenGalleryController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: ThemeColors.primary(context),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage(
                  controller.themeController.isDarkMode.value
                      ? ImageConstant.bgDark
                      : ImageConstant.bgLight), fit: BoxFit.fill)),
              child: SafeArea(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 24,
                      ).copyWith(top: 21),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          backButtonTitle(context),
                          const SizedBox(height: 28),
                          Expanded(child: buildBody(context)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0).copyWith(bottom: 15),
                      child: CommonInkwell(
                          onTap: () async {
                            if (controller.selectedValues.where((element) => element.selected).toList().isNotEmpty) {
                              controller.selectedPhotosList = controller.selectedValues.where((element) => element.selected).toList();
                              List<PhotoModel> photoList = controller.selectedPhotosList;
                              controller.update();
                              controller.selectedValues.map((element) {
                                element.selected = false;
                              }).toList();
                              controller.update();
                              Get.back(result: photoList);
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.zero,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(color: ThemeColors.secondary(context), offset: const Offset(0, 3), spreadRadius: 2, blurRadius: 20)
                            ], color: ThemeColors.secondary(context), shape: BoxShape.circle),
                            child: controller.selectedValues.where((element) => element.selected).isEmpty
                                ? const HeadlineBodyOneBaseWidget(
                                    title: "Select",
                                  )
                                : SvgPicture.asset(
                                    ImageConstant.tick,
                                    width: 18,
                                    height: 18,
                                    colorFilter: ColorFilter.mode(ThemeColors.primary(context), BlendMode.srcIn),
                                  ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  customCheckBoxView({required RxBool value, required String text, ValueChanged<bool?>? onChanged}) {
    return SizedBox(
      height: 28.0,
      width: 28.0,
      child: Checkbox(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
        fillColor: WidgetStateProperty.all(ColorConstants.grey8B),
        value: value.value,
        onChanged: onChanged,
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return GetBuilder<OpenGalleryController>(
        init: OpenGalleryController(),
        builder: (controller) {
          if (controller.isLoading.value) {
            return _shimmerImageLoading(context: context);
          }
          if (controller.selectedValues.isEmpty) {
            return const Center(
                child: Text(
              "No assets found.",
              style: TextStyle(color: ColorConstants.grey8B, fontSize: 16, fontWeight: FontWeight.w500),
            ));
          }
          return ScrollConfiguration(
            behavior: const ScrollBehavior(),
            child: GridView.custom(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              childrenDelegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return FutureBuilder<AssetEntity?>(
                      future: AssetEntity.fromId(controller.selectedValues.elementAt(index).id),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return ImageItemWidget(
                            selected: controller.selectedValues[index].selected,
                            key: ValueKey<int>(index),
                            entity: snapshot.data!,
                            onTap: () async {
                              for (var element in controller.selectedValues) {
                                if (element.selected) {
                                  element.selected = false;
                                }
                              }
                              controller.selectedValues[index].selected = !controller.selectedValues[index].selected;
                              controller.update();
                            },
                            option: const ThumbnailOption(size: ThumbnailSize.square(200)),
                          );
                        } else {
                          return Container();
                        }
                      });
                },
                childCount: controller.selectedValues.length,
                findChildIndexCallback: (Key key) {
                  // Re-use elements.
                  if (key is ValueKey<int>) {
                    return key.value;
                  }
                  return null;
                },
              ),
            ),
          );
        });
  }

  Widget _shimmerImageLoading({required BuildContext context}) {
    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 36),
      itemCount: 20,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: MediaQuery.of(context).size.height * 0.0012, crossAxisSpacing: 4, mainAxisSpacing: 4),
      itemBuilder: (context, index) {
        return CommonShimmer.customShimmerView(borderRadius: BorderRadius.circular(8));
      },
    );
  }

  backButtonTitle(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CommonInkwell(
          onTap: () {
            controller.selectedPhotosList.clear();
            for (var data in controller.selectedValues) {
              if (data.selected == true) {
                controller.selectedValues[controller.selectedValues.indexWhere((element) => element == data)].selected = false;
              }
            }
            ScaffoldMessenger.of(context).clearSnackBars();

            controller.update();
            Get.back();
          },
          child: Container(height: 25, width: 25, margin: const EdgeInsets.only(right: 15), child: const Icon(Icons.arrow_back_ios_new_outlined)),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child: HeadlineBodyOneBaseWidget(
            title: 'Select photos',
            fontSize: 24,
            fontWeight: FontWeight.w600,
            letterSpacing: -1,
            height: 0,
            titleColor: ThemeColors.primary(context),
          ),
        ),
      ],
    );
  }
}
