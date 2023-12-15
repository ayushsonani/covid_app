import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'dart:math' as math;

import 'api_page.dart';
import 'country_data_coronas.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: SlashScreen(),
  ));
}

class SlashScreen extends StatefulWidget {
  const SlashScreen({super.key});

  @override
  State<SlashScreen> createState() => _SlashScreenState();
}

class _SlashScreenState extends State<SlashScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    animationController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1500))
          ..repeat();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return HomeScreen();
      },)) ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: animationController.value * 2 * math.pi,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.4,
                    height: MediaQuery.of(context).size.height / 5,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/virus.png"))),
                  ),
                );
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
            Text(
              "Corona App",
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
