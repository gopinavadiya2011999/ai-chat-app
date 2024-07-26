import 'package:aichat/inftrastructure/constant/color_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

showTopToast({required String msg,required BuildContext context}){
  Fluttertoast.showToast(
    msg:msg,
    fontSize: 16,
    backgroundColor: ThemeColors.primary(context),
    textColor: ThemeColors.secondary(context),
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
  );
}