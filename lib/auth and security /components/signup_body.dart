import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_app_flashmonk/MainScreen/home_screen.dart';
import 'package:weather_app_flashmonk/auth%20and%20security%20/pages/login.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({Key? key}) : super(key: key);

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  late String _password;

  final _formKey = GlobalKey<FormState>();

  late String _username;

  late String _email;

  validate() {
    var validateForm = _formKey.currentState!.validate();

    if (validateForm) {
      _formKey.currentState!.save();
      startAuthentication();
    }
  }

  startAuthentication() async {
    final auth = FirebaseAuth.instance;

    try {
      await auth
          .createUserWithEmailAndPassword(email: _email, password: _password);
      User? user = auth.currentUser;

      user = auth.currentUser;
      String? uid = user?.uid;

      await FirebaseFirestore.instance.collection("users").doc(uid).set({
        "username": _username,
        "email": _email,
      });
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomeScreen()), (route) => false);
    } catch (err) {
      print(err);
      if (err.toString() ==
          "[firebase_auth/email-already-in-use] The email address is already in use by another account.") {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Email address already registered")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Form(
          key: _formKey,
          child: Column(
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
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  key: const ValueKey('username'),
                  style: const TextStyle(color: Colors.grey),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 17),
                    hintText: "username",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return "enter username";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _username = value!;
                  },
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  key: const ValueKey('email'),
                  style: const TextStyle(color: Colors.grey),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 17),
                    hintText: "Email address",
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                  onSaved: (value) {
                    _email = value.toString().trim();
                  },
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return "enter email";
                    } else if (value?.contains('@') == false) {
                      return "enter valid email";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  key: const ValueKey('password'),
                  style: const TextStyle(color: Colors.grey),
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 17, horizontal: 20),
                    hintText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                  ),
                  validator: (value) {
                    if (value?.isEmpty == true || value!.length < 6) {
                      return "generate strong password";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.only(top: 80, bottom: 20),
                width: MediaQuery.of(context).size.width / 2,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey[600],
                ),
                child: TextButton(
                  onPressed: () {
                    validate();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Submit",
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
                height: MediaQuery.of(context).size.height / 8,
              ),
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()));
                        },
                        child: const Text("Log In"))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
