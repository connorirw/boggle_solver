# Boggle Solver
A mobile application for android/ios that automatically logs Boggle scores.

## General Information

This project aims to develop a mobile application for iOS and Android that is capable of taking/uploading a picture of a Boggle game board and solving it for its possible words. In order for this app to be interactive with the user, we've included functionality for a player to upload their found words and score themselves against the Boggle solver. This score can be used to track player skill through the built in leaderboard.

## Tools Used

This application was built in Flutter (by Google) and uses the Open Character Recognition API (OCR) to extract characters from the imported images. The recozied characters are used to generate the Boggle board in the application which is then solved for all possible words.   


## Developers

Connor Irwin - connor.irw@gmail.com\
Bennett Bartel - bbartel@carthage.edu\
Erik Carlson - ecarlson1@carthage.edu\
Michael Idzik - michael.idzik01@gmail.com

## Installing The Application
1. Install flutter if it is not already on your machine (see Getting Started with Flutter for more information)
2. Close the repository to your desired folder and open it in your desired code editor/ide
3. Run 'flutter pub run' through the terminal to install dependencies
4. Connect an android/ios device or open an emulator to your machine
5. Run 'flutter run' to run the app on your device/emulator

## Using the App
1. To begin select “Take Picture” or “Select From Camera Roll”
2. Confirm the app correctly recognized game board (checking for mistakes in the character arrangement)
3. Report the words that were found on the game board and check score score using in-app icon
4. Enter player name and submit your score the the leaderboard


## Getting Started with Flutter

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
