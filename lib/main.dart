import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:weather_app_flashmonk/auth%20and%20security%20/pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(
        child: SplashScreen(
            seconds: 3,
            navigateAfterSeconds: const Login(),
            title: const Text(
              'Welcome to Weather App',
              style: TextStyle(fontSize: 18),
            ),
            image: Image.asset("assets/splashWeather.png"),
            backgroundColor: Colors.white,
            loadingText: const Text(
              "By Ayush Santri",
              style: TextStyle(fontSize: 10),
            ),
            photoSize: 100.0,
            loaderColor: Colors.black),
      ),
    );
  }
}
