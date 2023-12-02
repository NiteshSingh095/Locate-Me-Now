import 'dart:async';

import 'package:flutter/material.dart';
import 'package:locate_me_now/Screen/HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MoveToMainScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset("image/earth.png"),
          ),
          const SizedBox(height: 20,),
          Container(
              child: const Text(
                "Locate Me Now",
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w500
                ),
              )
          )
        ],
      ),
    );
  }

  void MoveToMainScreen()
  {
    Timer(
        const Duration(seconds: 4),
            () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()))
    );
  }
}
