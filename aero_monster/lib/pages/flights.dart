import 'dart:convert';

import 'package:aero_monster/models/country.dart';
import 'package:flutter/material.dart';
import '../models/flight.dart';
import 'package:http/http.dart' as http;

List<Flight> flights = [];
String s_from = "";
String s_to = "";
Future<void> getFlights() async {
  final response =
      await http.get(Uri.parse('http://192.168.100.77:8081/flights'));
  flights.clear();
  List responseJson = json.decode(response.body);
  responseJson.map((e) => flights.add(Flight.fromJson(e))).toList();
}

class Flights extends StatefulWidget {
  const Flights({Key? key}) : super(key: key);

  @override
  State<Flights> createState() => _FlightsState();
}

class _FlightsState extends State<Flights> {
  late Future<List<Flight>> futureFlights;
  @override
  void initState() {
    super.initState();
    getFlights();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vuelos"),
      ),
      body: ListView.builder(
        itemCount: flights.length,
        itemBuilder: (BuildContext context, int index) {
          var from = flights[index].from;
          var to = flights[index].to;
          print(index);
          print(from);
          print(to.toString());

          getCountries(from, to);

          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(s_from),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(s_to),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(flights[index].date),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(flights[index].price.toString()),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Future<void> getCountries(int from, int to) async {
  final response =
      await http.get(Uri.parse('http://192.168.100.77:8081/country/$to'));
  List responseJson = jsonDecode(response.body);

  Country c = Country.fromJson(responseJson[0]);
  s_to = c.name;

  final response2 =
      await http.get(Uri.parse('http://192.168.100.77:8081/country/$from'));

  List responseJson2 = jsonDecode(response2.body);
  Country c2 = Country.fromJson(responseJson2[0]);
  s_from = c2.name;
}
