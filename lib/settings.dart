import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_details.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final user = FirebaseAuth.instance.currentUser!;

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(onPressed: (){
            
                },child: Text('Exit'),),
                TextButton(onPressed: signUserOut,child: Text('Signout'),),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AddDetails()));
                },child: Text('Change name'),),
                TextButton(onPressed: (){},child: Text('Delete account'),),
                TextButton(onPressed: (){},child: Text('Delete Room'),),
                TextButton(onPressed: (){},child: Text('Add Note'),),
                TextButton(onPressed: (){},child: Text('Profile'),),
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}

