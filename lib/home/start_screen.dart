
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hellomate/auth/auth_screen.dart';
import 'package:hellomate/home/home_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key,});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
       builder: (context,snapshot){
        if(snapshot.hasData){
        return const HomeScreen();
        }else if (snapshot.hasError){
          return Scaffold(
            body: Center(
              child: Text(
                '${snapshot.error}'
              ),
            ),
          );
        }
        else{
         return const AuthScreen();
        }
      }),
    );
  }
}