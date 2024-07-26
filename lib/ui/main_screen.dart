import 'package:aichat/inftrastructure/constant/image_constant.dart';
import 'package:aichat/ui/common_widgets/chat_appbar.dart';
import 'package:aichat/ui/common_widgets/chat_list.dart';
import 'package:aichat/ui/common_widgets/text_field_with_send_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'main_controller.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      builder: (controller) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(controller.themeController.isDarkMode.value
                        ? ImageConstant.bgDark
                        : ImageConstant.bgLight),
                    fit: BoxFit.fill)),
            child: const SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [ChatAppbar(), ChatList(), TextFieldWithSendButton()],
              ),
            ),
          ),
        );
      },
    );
  }
}
