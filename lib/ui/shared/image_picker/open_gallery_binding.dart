import 'package:aichat/ui/shared/image_picker/open_gallery_controller.dart';
import 'package:get/get.dart';

class OpenGalleryBinding extends Bindings {


  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => OpenGalleryController());
  }

}