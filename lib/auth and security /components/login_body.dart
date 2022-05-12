import 'package:flutter/material.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  late String _email;

  late String _password;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Form(
      key: _formKey,
        child: Column(
      children: [
        SizedBox(
          width: width / 1.3,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            key: const ValueKey('email'),
            style: const TextStyle(color: Colors.grey),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 17),
              hintText: "Email address",
              prefixIcon: const Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            onSaved: (value) {
              _email = value.toString().trim();
            },
          ),
        )
      ],
    ));
  }
}
