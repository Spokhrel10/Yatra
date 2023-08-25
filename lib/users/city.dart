// ignore_for_file: unnecessary_new

import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:intl/intl.dart';
import 'package:sajilo_yatra/users/ride.dart';

import 'package:sajilo_yatra/users/tickets.dart';
import 'package:sajilo_yatra/helpers/ui_helper.dart';

class City extends StatefulWidget {
  const City({Key? key}) : super(key: key);

  @override
  State<City> createState() => _CityState();
}

class _CityState extends State<City> {
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _textEditingController1 = TextEditingController();
  List<String> _places = [];

  Future<void> searchPlacesInNepal() async {
    final query = _textEditingController.text;
    final url =
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$query.json?country=np&access_token=pk.eyJ1IjoiZGdkb24tMTIzIiwiYSI6ImNsZjF2NG5lbTBjYXEzem52aGo0ZTF6aHUifQ.DEvWGUYA_ELjd4mZV8MbcA';

    try {
      final response = await http.get(Uri.parse(url));
      final data = jsonDecode(response.body);

      final features = data['features'] as List<dynamic>;
      final places = <String>[];
      for (final feature in features) {
        final placeName = feature['place_name'] as String;
        places.add(placeName);
      }

      setState(() => _places = places);
    } catch (e) {
      print('Failed to get search results from Mapbox: $e');
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color(0xFFFFFFFF),
                size: 25,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        backgroundColor: Color(0xFF0062DE),
        title: const Text('Search',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontFamily: 'Roboto Bold',
              fontSize: 22,
              height: 1.19,
              fontWeight: FontWeight.w500,
            )),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 140.4,
              width: 399,
              color: Color(0xFF0062DE),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    widthFactor: 5.9,
                    child: Text(
                      "City",
                      style: TextStyle(
                        height: 1.5,
                        fontFamily: "Mulish",
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFFFFFFF),
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 17,
                          right: 10,
                          left: 16,
                        ),
                        width: 260,
                        child: TextFormField(
                          controller: _textEditingController,
                          maxLines: 1,
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (value) => searchPlacesInNepal(),
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFFFFFFF),
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              size: 28,
                              color: Color(0xFF222222),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFFFFFFF),
                                width: 2,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(9),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFFFFFFF),
                                width: 2,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(9),
                              ),
                            ),
                            hintText: 'Search City',
                            hintStyle: TextStyle(
                              height: 0.9,
                              fontFamily: "Mulish",
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF222222),
                              fontSize: 16,
                            ),
                            suffixIconColor: Color.fromARGB(255, 255, 0, 0),
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: "Mulish",
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Leaving field cannot be empty';
                            } else if (_places.isEmpty) {
                              return 'No matching places found';
                            }
                            return null;
                          },
                          onEditingComplete: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Ride(
                                          city: _textEditingController.text,
                                          initialIndex: 1,
                                        )));
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 0),
                        child: TextButton(
                          onPressed: () {
                            _textEditingController.text = '';
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              height: 2.96,
                              fontFamily: "Mulish",
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFFFFFF),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _places.length,
                itemBuilder: (BuildContext context, int index) {
                  final place = _places[index];
                  return ListTile(
                    title: Text(place),
                    onTap: () {
                      _textEditingController.text = place;
                      setState(() => _places.clear());
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
