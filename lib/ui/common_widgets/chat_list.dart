import 'dart:io';

import 'package:aichat/inftrastructure/constant/color_constant.dart';
import 'package:aichat/inftrastructure/constant/image_constant.dart';
import 'package:aichat/ui/common_widgets/headline_body_text.dart';
import 'package:aichat/ui/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'animated_loadingbar.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
        init: MainController(),
        builder: (controller) {
          return Expanded(
              child: controller.finishReason != null
                  ? Center(child: Text(controller.finishReason!))
                  : SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (controller.selectedPhoto2 != null)
                              Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  height: 80,
                                  width: 80,
                                  child: Image.file(File(controller.selectedPhoto2!.image), fit: BoxFit.fill)),
                            if (controller.searchedText != null)
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(color: ThemeColors.blueDd, borderRadius: BorderRadius.circular(10)),
                                child: HeadlineBodyOneBaseWidget(
                                  title: controller.searchedText?.trimRight(),
                                  titleColor: ColorConstants.white,
                                ),
                              ),
                            if (controller.isSpeaking) const SizedBox(height: 10),
                            if (controller.isSpeaking)
                              SizedBox(
                                width: double.infinity,
                                height: 150,
                                child: Image.asset('assets/animated_girl.gif'),
                              ),
                            const SizedBox(height: 10),
                            GeminiResponseTypeView(
                              builder: (context, child, response, loading) {
                                if (loading) {
                                  return RotatingSVG();
                                }

                                if (response != null) {
                                  return Container(
                                    decoration: BoxDecoration(color: ThemeColors.secondary(context), borderRadius: BorderRadius.circular(10)),
                                    child: Markdown(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      data: response,
                                      selectable: true,
                                    ),
                                  );
                                } else {
                                  return Center(
                                      child: Container(
                                          margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / 4.2),
                                          child: Column(
                                            children: [
                                              Lottie.asset(ImageConstant.aiRobotFinding, height: 150, width: 150, fit: BoxFit.fill),
                                              const HeadlineBodyOneBaseWidget(title: "Search something ..."),
                                            ],
                                          )));
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ));
        });
  }
}
