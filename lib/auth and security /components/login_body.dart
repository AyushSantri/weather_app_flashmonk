import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/signup.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  late String _email;

  late String _password;

  final _formKey = GlobalKey<FormState>();

  validate() {
    var validateForm = _formKey.currentState!.validate();

    if (validateForm) {
      _formKey.currentState!.save();
      startAuthentication();
    }
  }

  startAuthentication() async {
    final user = FirebaseAuth.instance;
    try {
      await user.signInWithEmailAndPassword(email: _email, password: _password);
    } catch (err) {
      print(err);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err.toString())));
    }
  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Center(
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 30, top: 50, bottom: 100),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                        text: const TextSpan(
                      text: "Welcome to",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: '\nWeather App!',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 50)),
                      ],
                    )),
                  ),
                ),
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
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return "Please enter email";
                      } else if (value?.contains('@') == false) {
                        return "Enter a valid E-mail";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: width / 1.3,
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    key: const ValueKey('password'),
                    obscureText: true,
                    style: const TextStyle(color: Colors.grey),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 17, horizontal: 20),
                      hintText: "password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onSaved: (value) {
                      _password = value!;
                    },
                    validator: (value) {
                      if (value!.length < 6) {
                        return "min length 6";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 80),
                  width: MediaQuery.of(context).size.width / 2,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey[600],
                  ),
                  child: TextButton(
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      validate();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.arrow_forward_outlined,
                          color: Colors.white,
                          size: 29,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 5.6,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                (context),
                                MaterialPageRoute(
                                    builder: (context) => const SignUp()));
                          },
                          child: const Text("Sign up"))
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
