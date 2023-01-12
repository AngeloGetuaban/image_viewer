import 'dart:async';
import 'package:flutter/material.dart';
import 'main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const PermissionHandlerScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300.0,
              width: 300.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('asset/splash.jpg'),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(
                height: 260,
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'Image Viewer',
                    style: TextStyle(fontSize: 30.0),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
