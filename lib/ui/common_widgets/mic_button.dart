import 'package:aichat/inftrastructure/constant/common_toast.dart';
import 'package:aichat/ui/common_widgets/common_inkwell.dart';
import 'package:aichat/ui/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MicButton extends StatelessWidget {
  const MicButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<MainController>(
      init: MainController(),
      builder: (controller) {
        return CommonInkwell(
          onLongPress: () {
            controller.listen();
          },
          onTap: () {
            controller.isListening = false;
            controller.update();
            showTopToast(msg: 'Long press the button and start speaking', context: context);
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                width: controller.isListening ? 32 : 20,
                height: controller.isListening ? 32 : 20,
                decoration: BoxDecoration(
                  color: controller.isListening ? Colors.blue.withOpacity(0.3) : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: AnimatedOpacity(
                  opacity: controller.isListening ? 1.0 : 0.0,
                  duration: const Duration(seconds: 1),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                        width: controller.isListening ? 2 : 0,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              Icon(controller.isListening ? Icons.mic : Icons.mic_none, size: 24),
            ],
          ),
        );
      }
    );
  }
}
