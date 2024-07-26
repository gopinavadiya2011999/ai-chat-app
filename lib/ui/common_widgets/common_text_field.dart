import 'package:aichat/inftrastructure/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({super.key, this.maxLines, this.prefixIcon, this.hintText, this.onTap, this.controller});

  final int? maxLines;
  final IconData? prefixIcon;
  final String? hintText;
  final GestureTapCallback? onTap;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      keyboardType: TextInputType.multiline,
      textAlignVertical: TextAlignVertical.center,
      maxLines: maxLines ?? 1,
      minLines: 1,
      controller: controller,
      cursorColor: ThemeColors.primary(context),
      style: GoogleFonts.sahitya(
        color: ThemeColors.primary(context),
        fontSize: 16,
      ),
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                size: 24,
                color: Colors.transparent,
              )
            : null,
        border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent, width: 3), borderRadius: BorderRadius.all(Radius.circular(37))),
        focusedBorder:
            const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(37)), borderSide: BorderSide(color: Colors.transparent, width: 3)),
        enabledBorder:
            const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(37)), borderSide: BorderSide(color: Colors.transparent, width: 3)),
        disabledBorder:
            const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(37)), borderSide: BorderSide(color: Colors.transparent, width: 3)),
        isDense: true,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical:5,horizontal: 12),
        hintStyle: GoogleFonts.sahitya(
          color: ThemeColors.primary(context).withOpacity(0.5),
          fontSize: 16,
        ),
        hintText: hintText ?? "",
        fillColor: ThemeColors.primary(context).withOpacity(0.15),
      ),
    );
  }
}
