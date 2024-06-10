// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';

import 'package:agarly/HomeScreen.dart';
import 'package:agarly/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
// ...
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
          apiKey: "AIzaSyD4JX1WWQ2ze0fd7kZI--dMnd3pdovzBjc",
          appId: "1:723789969350:android:8d909fd724fa06d38424c7",
          messagingSenderId: "723789969350",
          projectId: "agarly-a8560",
        ))
      : await Firebase.initializeApp();
  runApp(
    Builder(
      builder: (context) {
        return OrientationBuilder(
          builder: (context, orientation) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: MyHomePage(
                rentBuyOption: '',
                title: '',
              ),
            );
          },
        );
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(
            rentBuyOption: '',
            title: '',
          ),
        );
      },
    );
  }
}
