import 'dart:convert';

import 'package:covid_app_lern/server/api_data.dart';
import 'package:covid_app_lern/server/get_data_to_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CountryCoronaPage extends StatefulWidget {
  const CountryCoronaPage({super.key});

  @override
  State<CountryCoronaPage> createState() => _CountryCoronaPageState();
}

class _CountryCoronaPageState extends State<CountryCoronaPage> {
  ResponssGetApi responssGetApi = ResponssGetApi();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cuntry_http_data();
  }

  List data = [];

  cuntry_http_data() async {
    var response = await http.get(Uri.parse(ApiData.country_data));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      print(data);
      return data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.green),
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(8),
              child: TextField(
                decoration: InputDecoration(
                    // disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 5)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(25)),
                    // border:
                    //     OutlineInputBorder(borderSide: BorderSide(width: 5,color: Colors.black),borderRadius: BorderRadius.circular(25)),
                    hintText: "Search Countryes",
                    hintStyle: TextStyle(color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.green),
                        borderRadius: BorderRadius.circular(25))),
              )),
          Expanded(
              child: FutureBuilder(
            future: cuntry_http_data(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(8),
                  // itemExtent: 10,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      child: ListTile(
                        tileColor: Colors.black.withAlpha(1000),
                        leading: Container(
                          height: 100,
                          width: 70,
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      data[index]['countryInfo']['flag']))),
                        ),
                        title: Text(data[index]['country'],
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18)),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ))
        ],
      ),
    );
  }
}
