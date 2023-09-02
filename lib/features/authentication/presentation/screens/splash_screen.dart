import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:land_survey/core/router/router_names.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void navigate() async {

    await Future.delayed(const Duration(seconds: 3)).then(
      (value) => context.goNamed(RouterNames.login.name),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child:
                  Lottie.asset("assets/images/animation'.json", fit: BoxFit.cover),
            ),
          ),
          const Text("Fetching your location....")
        ],
      ),
    );
  }
}
