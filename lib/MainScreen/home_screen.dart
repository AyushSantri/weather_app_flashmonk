import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var temperature = "";
  String location = "Dehradun";
  String icons = "";
  String images = "";

  // but before that you need to add this permission!
  void getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;

    fetchLocationData(lat, long);
  }

  @override
  void initState() {
    // fetchData(location);
    getCurrentLocation();
    super.initState();
  }

  fetchData(String input) async {
    String _api =
        "https://api.openweathermap.org/data/2.5/weather?q=$input&appid=17e6da7f2f9753dce8e85aa9a9973183";

    var searchResult = await http.get(Uri.parse(_api));
    var result = json.decode(searchResult.body);

    setState(() {
      temperature =
          (result["main"]["temp"] - 273.15).toString().substring(0, 5);
      location = input;
      icons = result["weather"][0]["icon"];

      identifyWeather(icons);
    });
  }

  fetchLocationData(double latitude, double longitude) async {
    String _locationApi = "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=17e6da7f2f9753dce8e85aa9a9973183";

    var fetching = await http.get(Uri.parse(_locationApi));
    var fetchedResult = json.decode(fetching.body);

    setState(() {
      temperature = (fetchedResult["main"]["temp"] - 273.15).toString().substring(0, 5);
      location = fetchedResult["name"];
      icons = fetchedResult["weather"][0]["icon"];

      identifyWeather(icons);
    });
  }

  identifyWeather(String weatherId) {
    switch(weatherId) {
      case "01d" : {
        images = "assets/clear.png";
      }
      break;

      case "02d" : {
        images = "assets/lightcloud.png";
      }
      break;

      case "03d" : {
        images = "assets/lightcloud.png";
      }
      break;

      case "04d" : {
        images = "assets/heavycloud.png";
      }
      break;

      case "09d" : {
        images = "assets/showers.png";
      }
      break;

      case "10d" : {
        images = "assets/heavyrain.png";
      }
      break;

      case "11d" : {
        images = "assets/thunderstorm.png";
      }
      break;

      case "13d" : {
        images = "assets/snow.png";
      }
      break;

      case "50d" : {
        images = "assets/sleet.png";
      }
      break;
    }
  }

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(icon: const Icon(Icons.logout, size: 35,), onPressed: (){
        FirebaseAuth.instance.signOut();
      },),
      body: images.isNotEmpty ? Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(images, fit: BoxFit.fill),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                temperature.isEmpty
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        "$temperature C",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 60),
                      ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  location,
                  style: const TextStyle(color: Colors.white, fontSize: 40),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 90),
                  width: MediaQuery.of(context).size.width / 1.4,
                  child: TextField(
                    controller: _textEditingController,
                    onSubmitted: (_location) {
                      if (_textEditingController.text.toString().isNotEmpty) {
                        setState(() {
                          fetchData(_textEditingController.text.toString());
                        });
                      }
                    },
                    style: const TextStyle(color: Colors.white, fontSize: 25),
                    decoration: const InputDecoration(
                        hintText: "Search another location",
                        hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.white,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ) : Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Fetching your location", style: TextStyle(color: Colors.black, fontSize: 25),),
          const SizedBox(
            height: 25,
          ),
          CircularProgressIndicator(color: Colors.grey[600],),
        ],
      )),
    );
  }
}
