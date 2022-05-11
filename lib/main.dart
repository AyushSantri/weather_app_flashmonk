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
              'Welcome to Weather App\'22',
              style: TextStyle(fontSize: 18),
            ),
            image: Image.network(
                "https://imgs.search.brave.com/Ky5JFqywmwanEBTNhg0SsOn6Kutz7hIICSmzNLdxVj0/rs:fit:1200:1200:1/g:ce/aHR0cHM6Ly9zdGF0/aWMuZHJpYmJibGUu/Y29tL3VzZXJzLzQz/MTEyMDIvc2NyZWVu/c2hvdHMvMTA3MTMx/NTAvbWVkaWEvODMw/NGIyNjRhOWJlMjMx/NjZmYjUwZjk0YTE0/Nzc3YzAuanBn"),
            backgroundColor: Colors.white,
            loadingText: const Text(
              "By Ayush Santri",
              style: TextStyle(fontSize: 10),
            ),
            styleTextUnderTheLoader: const TextStyle(),
            photoSize: 100.0,
            loaderColor: Colors.black),
      ),
    );
  }
}
