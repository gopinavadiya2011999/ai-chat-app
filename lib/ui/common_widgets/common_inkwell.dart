import 'package:flutter/material.dart';

class CommonInkwell extends StatelessWidget {
  const CommonInkwell({super.key, required this.child, required this.onTap, this.onLongPress});
  final Widget child;
  final GestureTapCallback onTap;
  final GestureTapCallback ?onLongPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress:onLongPress ,
      hoverColor: Colors.transparent,focusColor: Colors.transparent,
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: child,
    );
  }
}
