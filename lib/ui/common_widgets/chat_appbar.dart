import 'package:aichat/inftrastructure/constant/color_constant.dart';
import 'package:aichat/inftrastructure/constant/image_constant.dart';
import 'package:aichat/ui/common_widgets/common_inkwell.dart';
import 'package:aichat/ui/common_widgets/headline_body_text.dart';
import 'package:aichat/ui/main_controller.dart';
import 'package:aichat/ui/shared/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatAppbar extends StatelessWidget {
  const ChatAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    return GetBuilder<MainController>(
        init: MainController(),
        builder: (controller) {
          return Column(
            children: [
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HeadlineBodyOneBaseWidget(
                      title: "AI Chat",
                      titleColor:   controller.themeController.isDarkMode.value  ? ColorConstants.white : ColorConstants.black
                  ,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                    const Spacer(),

                    if (controller.allText.isNotEmpty)
                      CommonInkwell(
                          onTap: () {
                            controller.playing = true;
                            controller.data = controller.allText
                                .toList()
                                .toString()
                                .replaceAll('\n', ' ')
                                .replaceAll(RegExp(r'[*]+.*?[*]+'), '')
                                .replaceAll(',', '')
                                .replaceAll(']', '')
                                .replaceAll('[', '');
                            controller.update();
                            controller.speak(controller.data);
                          },
                          child:  Icon(Icons.video_chat, color: controller.themeController.isDarkMode.value ? ColorConstants.white : ColorConstants.black,
                          )),
                    if (controller.isSpeaking)
                      const SizedBox(width: 10),
                     if (controller.isSpeaking)
                      CommonInkwell(
                          onTap: () {
                            controller.isSpeaking = false;
                            controller.update();
                            controller.stop();
                          },
                          child:  Icon(Icons.stop_circle, color: controller.themeController.isDarkMode.value  ? ColorConstants.white : ColorConstants.black)),
                    const SizedBox(width: 10),
                    CommonInkwell(
                        onTap: () {

                          themeController.toggleTheme();
                          controller.update();
                        },
                        child: Image.asset(ImageConstant.moon,
                            color: controller.themeController.isDarkMode.value?  ColorConstants.white : ColorConstants.black,
                            height: 24,
                            width: 24)),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Container(
                color:   controller.themeController.isDarkMode.value  ?  ColorConstants.white : ColorConstants.black,

                height: 1,
                width: double.infinity,
              ),


            ],
          );
        });
  }
}
