# Introducing AI-Chat App

Welcome to  AI-Chat App, a cutting-edge application designed to bring advanced AI capabilities to both iOS and Android platforms.
With a focus on enhancing user interaction and accessibility, AI-Chat App is packed with powerful features.

![ai_banner1](https://github.com/user-attachments/assets/bee3a03d-6600-476a-8ca5-df44990b8496)

## Features

- **Set up your API key** [scroll](#getting-started)
- **Initialize Gemini** [scroll](#initialize-gemini)
- **Content-based APIs** [scroll](#content-based-apis)
  - **Text-only input** [scroll](#text-only-input)
  - **Text-and-image input** [scroll](#text-and-image-input)
- **Advanced Usage** [scroll](#advanced-usage)
  - **Text-to-speech** [scroll](#text-to-speech)
  - **Speech-to-text** [scroll](#speech-to-text)
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

https://github.com/user-attachments/assets/1189f3d9-60b8-413b-b335-075c649d4731

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

#### Speech-to-text

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

![download-compresskaru com](https://github.com/user-attachments/assets/ebe1fdc2-5586-45ea-a5fd-87581335892a) ![download-compresskaru com 6 39 34 PM](https://github.com/user-attachments/assets/e9481985-ae00-4725-99fd-ff13b611322b) ![download-compresskaru com 6 07 50 PM](https://github.com/user-attachments/assets/ff3d5240-3263-4ed7-813c-6f91002ef356)

![download-compresskaru com 6 07 38 PM](https://github.com/user-attachments/assets/d078ef61-2830-4860-b1c1-27ac496e9a45) ![download-compresskaru com (2)](https://github.com/user-attachments/assets/34603635-c87d-4e98-a70f-710749eb66f7) ![download-compresskaru com (1) 6 04 56 PM](https://github.com/user-attachments/assets/27f6540c-b2fd-4918-9c44-6918c5cf4831)


This version includes all necessary information and code snippets for your AI-Chat app, presented in a clear and organized manner.