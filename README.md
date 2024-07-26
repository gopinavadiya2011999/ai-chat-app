# Introducing AI-Chat App

Welcome to  AI-Chat App, a cutting-edge application designed to bring advanced AI capabilities to both iOS and Android platforms.
With a focus on enhancing user interaction and accessibility, AI-Chat App is packed with powerful features.

![gemini_github_cover](https://github.com/user-attachments/assets/8ebebfbf-17e3-4862-ba00-68c09a0c08a7)

## Features

- **Set up your API key** [scroll](#getting-started)
- **Initialize Gemini** [scroll](#initialize-gemini)
- **Content-based APIs** [scroll](#content-based-apis)
  - **Text-only input** [scroll](#text-only-input)
  - **Text-and-image input** [scroll](#text-and-image-input)
- **Advanced Usage** [scroll](#advanced-usage)
  - **Text-to-speech** [scroll](#text-to-speech)
  - **Speech-to-text with video** [scroll](#speech-to-text)
  - **Dark-light theme** [scroll](#dark-light-theme)
  - **Custom gallery** [scroll](#custom-gallery)
- **Gemini Widget** [scroll](#gemini-widget)

## Getting Started

To use the Gemini API, you'll need an API key. If you don't have, create a key in Google AI Studio. [Get an API key](https://ai.google.dev/).


## Initialize Gemini

For initialization, you must call the init constructor for Flutter Gemini in the main function.

```dart
void main() {

  /// Add this line
  Gemini.init(apiKey: '--- Your Gemini Api Key ---');

  runApp(const MyApp());
}
```

## Content-based APIs


https://github.com/user-attachments/assets/f8aefb5e-5ab0-4dae-b9af-14838e77f75f


#### Text-only input


Using Gemini's streamGenerateContent method for text-only input allows you to receive partial results in real-time, enhancing interaction speed and user experience.
This ensures that users get immediate feedback from their AI queries without waiting for the entire response.

```dart
final gemini = Gemini.instance;

gemini.streamGenerateContent('Type content that you want to ask to the AI')
  .listen((value) {
    log(value.output);
  }).onError((e) {
    log('streamGenerateContent exception', error: e);
  });
```


#### Text-and-image input

With Gemini's streamGenerateContent method, you can seamlessly combine image selection and text input to receive dynamic, AI-generated content in real-time.
This integration ensures that your application can process and respond to complex inputs efficiently, providing users with accurate and contextual responses based on both text and image data.


```dart
final gemini = Gemini.instance;

gemini.streamGenerateContent('Select image of your chioce and type something')
  .listen((value) {
    log(value.output);
  }).onError((e) {
    log('streamGenerateContent exception', error: e);
  });
```

## Advanced Usage

#### Text-to-speech

Using the flutter_tts package, you can easily start and stop text-to-speech functionality in your Flutter app.
Here's how you can use the provided functions to speak and stop speech.

```dart
import 'package:flutter_tts/flutter_tts.dart';

FlutterTts flutterTts = FlutterTts();

  Future speak(String data) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(data);
 }

Future stop() async {
    await flutterTts.stop();
  }
```

#### Speech-to-text with video

Using the speech_to_text package, the provided code demonstrates how to start and stop speech recognition in a Flutter app.
The listen function initializes the speech recognizer, starts listening for speech input, and prints the recognized words or any errors to the console.

```dart
import 'package:speech_to_text/speech_to_text.dart' as stt;

 stt.SpeechToText? speech = stt.SpeechToText();
 void listen() async {
    speech = stt.SpeechToText();
    update();
    if (!isListening) {
      await speech!.initialize(
        onStatus: (val) {
          print('onStatus: $val');
        },
        onError: (val) {
          print('onError: $val');
        },
      );
        speech!.listen(
          onResult: (val) {
            print("Recognized words: ${val.recognizedWords}"); },
        );
     
    } else {
      showTopToast(context: Get.context!, msg: "Stop listening...");
      speech?.stop();
    }
  }
```

#### Dark-light theme

ThemeController in Flutter using GetX for state management, which allows toggling between dark and light themes.
The current theme is determined by the isDarkMode observable variable, and toggleTheme switches the theme mode accordingly.

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;


  ThemeMode get theme => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(theme);
  }
}
```

#### Custom gallery

Fetch a list of image assets from the device's photo gallery using the photo_manager package for it.
It retrieves a list of asset paths and then fetches the images from the first path in a paginated manner.

```dart
import 'package:photo_manager/photo_manager.dart';

  final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
        onlyAll: true,
        filterOption: _filterOptionGroup,
        type: RequestType.image,
      );
 final List<AssetEntity> entities = await paths.first.getAssetListPaged(
        page: pageNo,
        size: sizePerPage,
      );    
```

## gemini-widget

The GeminiResponseTypeView widget is designed to handle and display different states of a response (e.g., loading or loaded) from the Gemini API.
When the loading state is true, it returns a loading widget, and when the response is available, it displays the desired widget based on the response content.

```dart
 GeminiResponseTypeView(
    builder: (context, child, response, loading) {
          if (loading) {
                return widget; }
            if (response != null) {
                return widget;
         }}),
```

![download-compresskaru com (1)](https://github.com/user-attachments/assets/9fc7913b-b8a7-4ab4-bb0f-80b8ac36c7bc)  ![download-compresskaru com (2)](https://github.com/user-attachments/assets/7504d794-fcf4-444d-b0b4-f16b9c0d54b4) ![download-compresskaru com](https://github.com/user-attachments/assets/bd689b0b-07ca-4462-bb8b-3a997c577914)

![download-compresskaru com (1)](https://github.com/user-attachments/assets/4551ecf7-ab7a-4b0b-abf9-f3383a83c456) ![download-compresskaru com](https://github.com/user-attachments/assets/63670481-a421-4d4a-bef0-3605176bdfd3)  ![download-compresskaru com](https://github.com/user-attachments/assets/4c0728f4-c59c-4c37-9cf8-16665722dcfb)




This version includes all necessary information and code snippets for your AI-Chat app, presented in a clear and organized manner.