import 'package:flutter/material.dart';
import 'package:weather_app_flashmonk/auth%20and%20security%20/components/login_body.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: const LoginBody(),
    );
  }
}
