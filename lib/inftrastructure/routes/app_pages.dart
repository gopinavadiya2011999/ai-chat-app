import 'package:aichat/inftrastructure/routes/route_constants.dart';
import 'package:aichat/ui/main_binding.dart';
import 'package:aichat/ui/main_screen.dart';
import 'package:aichat/ui/shared/image_picker/open_gallery_binding.dart';
import 'package:aichat/ui/shared/image_picker/open_gallery_view.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: RouteConstants.mainScreen,
      page: () => const MainScreen(),
      binding: MainBinding(),
    ),
    GetPage(
      name: RouteConstants.openGalleryView,
      page: () => const OpenGalleryView(),
      binding: OpenGalleryBinding(),
    ),
  ];
}
