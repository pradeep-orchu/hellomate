import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hellomate/demo.dart';
import 'package:hellomate/firebase_options.dart';
import 'package:hellomate/home/start_screen.dart';
import 'package:hellomate/theme.dart';

Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();

await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'Hellomate',
       darkTheme: ThemeData.from(
        colorScheme: MaterialTheme.darkScheme(),
        useMaterial3: true, 
      ),
      theme: ThemeData.from(
        colorScheme: MaterialTheme.lightScheme(),
        useMaterial3: true,
      ),
      home: Demo(),
    );
  }
}