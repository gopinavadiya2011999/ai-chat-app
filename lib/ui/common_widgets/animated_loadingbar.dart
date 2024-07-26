import 'package:aichat/inftrastructure/constant/image_constant.dart';
import 'package:aichat/ui/common_widgets/headline_body_text.dart';
import 'package:flutter/material.dart';

class RotatingSVG extends StatefulWidget {
  @override
  _RotatingSVGState createState() => _RotatingSVGState();
}

class _RotatingSVGState extends State<RotatingSVG> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            child: Image.asset(
              ImageConstant.searchAi,
              width: 100,
              height: 100,
              fit: BoxFit.fill,
            ),
            builder: (context, child) {
              return Transform.rotate(
                angle: _controller.value * 2.0 * 3.141592653589793,
                child: child,
              );
            },
          ),
          const HeadlineBodyOneBaseWidget(title: "Searching...")
        ],
      ),
    );
  }
}
