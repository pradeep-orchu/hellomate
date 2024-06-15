import 'package:flutter/material.dart';
import 'package:hellomate/login_screen.dart';
import 'package:hellomate/register_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
bool showLogin = true;

void toggle(){
  setState(() {
    showLogin = !showLogin;
  });
}

  @override
  Widget build(BuildContext context) {
    if (showLogin){
      return LoginScreen(toggle: toggle,);
    } else{
      return RegisterScreen(toggle: toggle,);
    }
  }
}