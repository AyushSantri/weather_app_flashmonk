import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var temperature = "";
  String location = "Dehradun";

  @override
  void initState() {
    fetchData(location);
    super.initState();
  }

  fetchData(String input) async {
    String _api = "https://api.openweathermap.org/data/2.5/weather?q=$input&appid=17e6da7f2f9753dce8e85aa9a9973183";

    var searchResult = await http.get(Uri.parse(_api));
    var result = json.decode(searchResult.body);

    setState(() {
      temperature = (result["main"]["temp"] - 273.15).toString().substring(0, 5);
    });

    print(searchResult);
    print(result);
    print(result["weather"][0]["description"]);
    print(result["main"]["temp"]);
  }

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
                temperature.isEmpty ? const CircularProgressIndicator(color: Colors.white,) :Text("$temperature C", style: const TextStyle(color: Colors.white, fontSize: 60),),
                const SizedBox(
                  height: 25,
                ),
                Text(location, style: const TextStyle(color: Colors.white, fontSize: 40),),
                Container(
                  margin: const EdgeInsets.only(top: 90),
                  width: MediaQuery.of(context).size.width / 1.4,
                  child: const TextField(
                    style: TextStyle(color: Colors.white, fontSize: 25),
                    decoration: InputDecoration(
                      hintText: "Search another location",
                      hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                      prefixIcon: Icon(Icons.search, color: Colors.white,)
                    ),
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
