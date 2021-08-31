# tb_e_health

A new Flutter project.

## Getting Started
###Setup Guide
### Installation
- install flutter-sdk (https://flutter.dev/docs/get-started/install)
- install dart-sdk (https://dart.dev/get-dart)
- install android-studio (https://developer.android.com/studio)

### Run project
- update dependencies
```yaml
flutter pub get
```
- add a virtual device in Android Studio > Settings > ADV Manager, start the virtual device
- IntelliJ: choose 'sdk gphone x86(mobile)' and run 
- VS Code: search for "Flutter run additional args" in user settings
```yaml
flutter run --no-sound-null-safety
```

### Generate Dummy User
- go to 'first_time_login.dart', find the "// DUMMY USER BUTTON", uncomment it, enter user name followed the structure 'RNxxxx', and click 'Create User'.

### Generate APK
- https://crello.com/ to generate icon
- place the new icon as assets/icon/icon.png
- run below command to update icon file
```yaml
flutter pub run flutter_launcher_icons:main
```
- build apk, run
```yaml
flutter build apk
```

## Layout

Login page
- username : lydia@test.com
- password : lydiaTest

toi@gmail.com
toitoi

Device Preview
- when creating the UI, please use device preview to check on each phone size to make sure the designs work well
- by using device preview, change kReleaseMode from false to true in the main.dart and restart the emulator

Chatbot
- clone this repository into your local devices: https://github.com/lydia0423/TB_e_health_chatbot
- install python
- install some python packages to make sure you able to run the app: pip install flask gunicorn / pip3 install flask gunicorn
- create an account in Heroku and share the account to me in order to run the services
