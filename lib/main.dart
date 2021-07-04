import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

void main() => runApp(WeatherApp());

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  //const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  Future getWeather() async {
    http.Response response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=Uyo&appid=48edf19737db33e34a9e1ed87447a78b"));
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed '];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFEF2E4),
      appBar: AppBar(
        backgroundColor: Color(0xff46211A),
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Weather App'), Text('Task 2')]),
      ),
      body:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Color(0xffFD974F),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'City: Uyo',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0,
                      color: Colors.white),
                ),
              ),
              Text(
                temp != null ? temp.toString() + '\u00B0' : 'Loading...',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 40.0,
                    color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  currently != null ? currently.toString() : 'Loading...',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            itemExtent: 70.0,
            shrinkWrap: true,
            children: <Widget>[
              Card(
                child: ListTile(
                  tileColor: Color(0xff805A3B),
                  dense: true,
                  leading: FaIcon(FontAwesomeIcons.thermometer),
                  title: Text('Temperature'),
                  trailing: Text(
                    temp != null ? temp.toString() + '\u00B0' : 'Loading ...',
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  tileColor: Color(0xff805A3B),
                  dense: true,
                  leading: FaIcon(FontAwesomeIcons.cloud),
                  title: Text('Weather'),
                  trailing: Text(description != null
                      ? description.toString()
                      : 'Loading...'),
                ),
              ),
              Card(
                child: ListTile(
                  tileColor: Color(0xff805A3B),
                  dense: true,
                  leading: FaIcon(FontAwesomeIcons.sun),
                  title: Text('Humidity'),
                  trailing: Text(
                      humidity != null ? humidity.toString() : 'Loading...'),
                ),
              ),
              Card(
                child: ListTile(
                  tileColor: Color(0xff805A3B),
                  dense: true,
                  leading: FaIcon(FontAwesomeIcons.wind),
                  title: Text('Wind Speed'),
                  trailing: Text(
                      windSpeed != null ? humidity.toString() : 'Loading...'),
                ),
              )
            ],
          ),
        ))
      ]),
    );
  }
}
