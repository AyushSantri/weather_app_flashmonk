import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:weather_app_flashmonk/auth%20and%20security%20/pages/login.dart';
import 'package:weather_app_flashmonk/auth%20and%20security%20/pages/signup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
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
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: SplashScreen(
            seconds: 3,
            navigateAfterSeconds: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return SignUp();
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const Login();
                }
              },
            ),
            title: const Text(
              'Welcome to Weather App',
              style: TextStyle(fontSize: 18),
            ),
            image: Image.asset("assets/splashWeather.png"),
            backgroundColor: Colors.white,
            loadingText: const Text(
              "By Ayush Santri",
              style: TextStyle(fontSize: 15),
            ),
            photoSize: 100.0,
            loaderColor: Colors.black),
      ),
    );
  }
}
