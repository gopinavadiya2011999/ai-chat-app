import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {


  var isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadThemeFromPreferences();
  }

  ThemeMode get theme => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    saveThemeToPreferences(isDarkMode.value);
    Get.changeThemeMode(theme);
  }

  void loadThemeFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkMode.value = prefs.getBool('isDarkMode') ?? false;
    Get.changeThemeMode(theme);
  }

  void saveThemeToPreferences(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }
}
