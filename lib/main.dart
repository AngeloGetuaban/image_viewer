import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_viewer/HomeScreen.dart';
import 'package:image_viewer/splash_screen.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Uploader',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 12, 243, 166),
        textTheme: const TextTheme(
          bodyText1: TextStyle(
              fontSize: 18.0,
              fontFamily: 'Barlow-Medium',
              color: Color(0xff464255)),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class PermissionHandlerScreen extends StatefulWidget {
  const PermissionHandlerScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PermissionHandlerScreenState createState() =>
      _PermissionHandlerScreenState();
}

class _PermissionHandlerScreenState extends State<PermissionHandlerScreen> {
  @override
  void initState() {
    super.initState();
    permissionServiceCall();
  }

  permissionServiceCall() async {
    await permissionServices().then(
      (value) {
        if (value[Permission.storage]!.isGranted &&
            value[Permission.camera]!.isGranted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      },
    );
  }

  Future<Map<Permission, PermissionStatus>> permissionServices() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.camera,
    ].request();

    if (statuses[Permission.storage]!.isPermanentlyDenied) {
      await openAppSettings().then(
        (value) async {
          if (value) {
            if (await Permission.storage.status.isPermanentlyDenied == true &&
                await Permission.storage.status.isGranted == false) {
              openAppSettings();
              // permissionServiceCall(); /* opens app settings until permission is granted */
            }
          }
        },
      );
    } else {
      if (statuses[Permission.storage]!.isDenied) {
        permissionServiceCall();
      }
    }
    if (statuses[Permission.camera]!.isPermanentlyDenied) {
      await openAppSettings().then(
        (value) async {
          if (value) {
            if (await Permission.camera.status.isPermanentlyDenied == true &&
                await Permission.camera.status.isGranted == false) {
              openAppSettings();
            }
          }
        },
      );
    } else {
      if (statuses[Permission.camera]!.isDenied) {
        permissionServiceCall();
      }
    }
    return statuses;
  }

  @override
  Widget build(BuildContext context) {
    permissionServiceCall();
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        body: Center(
          child: InkWell(
              onTap: () {
                permissionServiceCall();
              },
              child: const Text("Enable Storage and Camera Permission")),
        ),
      ),
    );
  }
}
