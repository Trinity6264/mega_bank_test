# Flutter Bank App

Welcome to the Flutter Bank App! This simple yet powerful banking application is built using Flutter and comes pre-loaded with static data for demonstration purposes.

## Screens

* **Login:** User will provide their email and password for authentication.
* **Reset Password:** Takes a new password and confirm password.  
* **Login:** User will provide their email and password for authentication.  
* **Dashboard:** It has two tabs the _Home_ and the _Transaction_ which each renders different components.
* **Profile:** It renders user details and also provide a listTile to change password or logout

## How to run the app

1. Download the app dependencies by running this prompt in cmd

```shell
flutter pub get
```

2. After that run the app with this prompt

```shell
Flutter run
```

**NB:** Make sure you have flutter sdk install on your machine and a stable network connected to your machine

## Tools and Plugins

* **Auto Route:** It’s a Flutter navigation package, it allows for strongly-typed arguments passing, effortless deep-linking and it uses code generation to simplify routes setup, with that being said it requires a minimal amount of code to generate everything needed for navigation inside of your App.  [Link](https://pub.dev/packages/auto_route)

* **Auto_Size_Text:** Flutter widget that automatically resizes text to fit perfectly within its bounds.  [Link](https://pub.dev/packages/auto_size_text)

* **Bloc & Flutter_Bloc:** This design pattern helps to separate presentation from business logic. Following the BLoC pattern facilitates testability and reusability. This package abstracts reactive aspects of the pattern allowing developers to focus on writing the business logic.
[Link](https://pub.dev/packages/bloc)

* **Flutter_Hooks:** Hooks are a new kind of object that manage the life-cycle of a Widget. They exist for one reason: increase the code-sharing between widgets by removing duplicates.
[Link](https://pub.dev/packages/flutter_hooks)

* **Flutter_Svg:** Renders an svg file either from network,asset or file
[Link](https://pub.dev/packages/flutter_svg)

* **Formz:** Validation of form fields
[Link](https://pub.dev/packages/formz)

* **Multiple_Result:** Returns multiple results from a function or a method
[Link](https://pub.dev/packages/multiple_result)

### Code example

```dart
//Creating a method that return a string or exception  
Result<String, Exception> getSomethingPretty(bool isOk) {
    if(isOk) {
        return Success('OK!');
    } else {
        return Error(Exception('Not Ok!'));
    }
}

// Invoking or calling the method/Function
void main() {
  final result = getSomethingPretty();
 
  switch(result) {
    case Success():
      print("${result.success}");
      break;
    case Error():
      print("${result.error}");
      break;
  }
}

```

### Video of Animated dialog

![Dialog Video](https://github.com/Sibyl-Systems-GH/amoah_mega_bank/assets/56246225/4ecdc6b5-22ff-4bc7-b3d2-480e76305e01)

* [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
