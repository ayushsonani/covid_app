import 'package:covid_app_lern/Models/allapidata.dart';
import 'package:covid_app_lern/country_data_coronas.dart';
import 'package:covid_app_lern/server/api_data.dart';
import 'package:covid_app_lern/server/get_data_to_model.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ResponssGetApi responssGetApi = ResponssGetApi();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    responssGetApi.get_all(url: ApiData.all_country_data_api);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.94),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            PieChart(
              dataMap: {"vayaj": 350000, "bank": 1000000, "rokada": 1600000},
              chartRadius: MediaQuery.of(context).size.width / 3.2,
              legendOptions: LegendOptions(legendPosition: LegendPosition.left),
              chartType: ChartType.ring,
              chartValuesOptions:
                  ChartValuesOptions(showChartValuesInPercentage: true),
              animationDuration: Duration(seconds: 2),
              colorList: [
                Colors.red,
                Colors.yellow,
                Colors.green,
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            FutureBuilder(
              future: responssGetApi.get_all(url: ApiData.all_country_data_api),
              builder: (context, AsyncSnapshot<Allapidata> snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Card(
                        elevation: 0,
                        color: Colors.white,
                        margin: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text("Action",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.red)),
                              trailing: Text("${snapshot.data!.active}",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.red)),
                            ),
                            ListTile(
                              title: Text("cases",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.red)),
                              trailing: Text("${snapshot.data!.cases}",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.red)),
                            ),
                            ListTile(
                              title: Text("tests",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.red)),
                              trailing: Text("${snapshot.data!.tests}",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.red)),
                            ),
                            ListTile(
                              title: Text("deaths",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.red)),
                              trailing: Text("${snapshot.data!.deaths}",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.red)),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return CountryCoronaPage();
                    },
                  ));
                },
                child: Text("Country Page"))
          ],
        ),
      ),
    );
  }
}
