import 'package:aichat/inftrastructure/constant/image_constant.dart';
import 'package:aichat/ui/common_widgets/common_inkwell.dart';
import 'package:aichat/ui/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SendButton extends StatelessWidget {
  const SendButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (controller) {
      return CommonInkwell(
          onTap: () {
            FocusScope.of(context).unfocus();
            if (controller.messageController.text.isNotEmpty) {
              controller.noData = true;
              controller.isListening = false;
              controller.playing = false;
              controller.allText.clear();
              controller.searchedText = controller.messageController.text;
              controller.selectedPhoto2 = controller.selectedPhoto;
              controller.selectedPhoto = null;
              controller.update();
              controller.messageController.clear();
              controller.gemini
                  .streamGenerateContent(controller.searchedText!, images: controller.imageList, modelName: 'models/gemini-1.5-flash-latest')
                  .handleError((e) {
                if (e is GeminiException) {
                  print(e);
                }
              }).listen((value) {
                controller.imageList = null;
                controller.selectedPhoto = null;
                controller.update();
                if (value.finishReason != 'STOP') {
                  controller.finishReason = 'Finish reason is `${value.finishReason}`';
                } else {
                  value.content?.parts?.forEach(
                    (element) {
                      controller.allText.add(element.text ?? "");
                    },
                  );
                  controller.update();
                }
              });
            }
          },
          child: SvgPicture.asset(controller.themeController.isDarkMode.value ? ImageConstant.send : ImageConstant.sendDark));
    });
  }
}
