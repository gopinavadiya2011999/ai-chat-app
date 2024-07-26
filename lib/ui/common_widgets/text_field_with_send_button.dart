import 'dart:io';
import 'dart:typed_data';
import 'package:aichat/inftrastructure/constant/color_constant.dart';
import 'package:aichat/inftrastructure/constant/image_constant.dart';
import 'package:aichat/inftrastructure/model/photo_model.dart';
import 'package:aichat/inftrastructure/routes/route_constants.dart';
import 'package:aichat/ui/common_widgets/common_inkwell.dart';
import 'package:aichat/ui/common_widgets/common_text_field.dart';
import 'package:aichat/ui/common_widgets/mic_button.dart';
import 'package:aichat/ui/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'send_button.dart';

class TextFieldWithSendButton extends StatelessWidget {
  const TextFieldWithSendButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      builder: (controller) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          color: ThemeColors.background(context),
          child: Column(
            children: [
              if (controller.selectedPhoto != null)
                SizedBox(
                  width: 80,
                  height: 80,
                  child: Stack(
                    children: [
                      Positioned.fill(child: Image.file(File(controller.selectedPhoto!.image), fit: BoxFit.fill)),
                      Positioned(
                        top: 3,
                        right: 3,
                        child: CommonInkwell(
                          onTap: () {
                            controller.selectedPhoto = null;
                            controller.update();
                          },
                          child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(color: ColorConstants.grey8B, shape: BoxShape.circle),
                              child: Icon(
                                Icons.close,
                                size: 10,
                                color: ThemeColors.primary(context),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              if (controller.selectedPhoto != null)
                Container(
                  width: double.infinity,
                  height: 1,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  color: ThemeColors.primary(context),
                ),
              Row(
                children: [
                  CommonInkwell(
                      onTap: () {
                        Get.toNamed(RouteConstants.openGalleryView)!.then(
                              (value) async {
                            if (value != null) {
                              List<PhotoModel> val = value as List<PhotoModel>;
                              controller.selectedPhoto = val.first;
                              controller.update();
                              final imagesBytes = <Uint8List>[];
                              for (final file in val) {
                                imagesBytes.add(await File(file.image).readAsBytes());
                              }
                              if (imagesBytes.isNotEmpty) {
                                controller.imageList = imagesBytes;
                                controller.update();
                              }
                            }
                          },
                        );
                      },
                      child: SvgPicture.asset(
                          controller.themeController.isDarkMode.value
                              ? ImageConstant.galleryDark
                              :ImageConstant.gallery)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CommonTextField(
                      maxLines: 4,
                      onTap: () {},
                      controller: controller.messageController,
                      hintText: "Ask me something...",
                    ),
                  ),
                  const SizedBox(width: 16),
                  const MicButton(),
                  const SizedBox(width: 16),
                  const SendButton(),
                ],
              ),
            ],
          ),
        );
      }
    );
  }
}
