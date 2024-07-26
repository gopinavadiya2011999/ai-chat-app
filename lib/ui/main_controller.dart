import 'dart:typed_data';
import 'package:aichat/inftrastructure/constant/common_toast.dart';
import 'package:aichat/inftrastructure/model/photo_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart' as ss;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'shared/theme_controller.dart';

class MainController extends GetxController {
  PhotoModel? selectedPhoto;
  PhotoModel? selectedPhoto2;
  final ThemeController themeController = Get.put(ThemeController());

  stt.SpeechToText? speech;
  List<Uint8List>? imageList;
  var errorMessage = ''.obs;
  final gemini = ss.Gemini.instance;
  String? searchedText, finishReason;
  TextEditingController messageController = TextEditingController();
    bool isListening = false;
  bool isSpeaking = false;
  bool noData = false;
  bool playing = false;
  List<String> allText = [];
  RxBool permissionAccess = false.obs;
  late FlutterTts flutterTts;
   String data ='';
  RxInt currentPage = 0.obs;
  final PageController pageController = PageController(initialPage: 0);

  animateToPage(int page, {withAnimation = false}) {
    pageController.animateToPage(
      page,
      duration: Duration(milliseconds: withAnimation ? 250 : 1),
      curve: Curves.easeIn,
    );
  }

  Future speak(String data) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(data);

  }

  Future stop() async {
    await flutterTts.stop();
  }
  @override
  Future<void> onInit() async {
    flutterTts = FlutterTts();

    flutterTts.setStartHandler(() {

        isSpeaking = true;
      update();
      print("Speech started");
    });

    flutterTts.setCompletionHandler(() {

        isSpeaking = false;
        update();
      print("Speech completed");
      stop();
    });

    flutterTts.setErrorHandler((msg) {

        isSpeaking = false;
        update();
      print("Error: $msg");
    });
    if (permissionAccess.value == false) {
      await getStoragePermission();
      speech = stt.SpeechToText();
      update();
    } else {
      speech = stt.SpeechToText();
      update();
    }

    super.onInit();
  }

  getStoragePermission() async {
    permissionAccess = false.obs;
    update();
    await Permission.microphone.request();
    SharedPreferences preferences = await SharedPreferences.getInstance();

    PermissionStatus status = await Permission.microphone.status;
    if (status.isGranted) {
      (await preferences.setBool('microphone', true));
      speech = stt.SpeechToText();
      permissionAccess = true.obs;
      update();
    } else if (status.isDenied) {
      await openAppSettings().then((value) async {
        (await preferences.setBool('microphone', value));
        permissionAccess = value.obs;
        update();
      });
    } else if (status.isPermanentlyDenied) {
      await openAppSettings().then((value) async {
        (await preferences.setBool('microphone', value));
        permissionAccess = value.obs;
        update();
      });
    }
  }

  void listen() async {
    speech = stt.SpeechToText();
    update();
    if (!isListening) {
      print("Initializing speech recognition...");
      bool available = await speech!.initialize(
        onStatus: (val) {
          if (val == 'notListening') {
            isListening = false;
            update();
          }
          print('onStatus: $val');
        },
        onError: (val) {
          print('onError: $val');
          errorMessage.value = 'Error: ${val.errorMsg}';
          update();
        },
      );
      update();
      if (available) {
        showTopToast(context: Get.context!, msg: "Listening...");
        isListening = true;
        errorMessage.value = '';
        update();
        speech!.listen(
          onResult: (val) {
            print("Recognized words: ${val.recognizedWords}");
            messageController.text = val.recognizedWords;
            update();
          },
        );
      } else {
        isListening = false;
        update();
        showTopToast(context: Get.context!, msg: "Speech recognition not available.");
      }
    } else {
      showTopToast(context: Get.context!, msg: "Stop listening...");
      isListening = false;
      update();
      speech?.stop();
    }
  }
}
