import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int temperature = 0;
  String location = "Dehradun";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset("assets/clear.png", fit: BoxFit.fill),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("$temperature C", style: const TextStyle(color: Colors.white, fontSize: 60),),
                Text(location, style: const TextStyle(color: Colors.white, fontSize: 40),),
                TextField(
                  style: TextStyle(color: Colors.white, fontSize: 25),
                  decoration: InputDecoration(
                    hintText: "Search another location",
                    hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                    prefixIcon: Icon(Icons.search, color: Colors.white,)
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
