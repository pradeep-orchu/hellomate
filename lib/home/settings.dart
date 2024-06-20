import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hellomate/user/users_database.dart';

import '../user/add_details.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final user = FirebaseAuth.instance.currentUser!;
  final UsersDatabase database = UsersDatabase();

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
            
                },child: const Text('Exit'),),
                TextButton(onPressed: signUserOut,child: const Text('Signout'),),
                TextButton(onPressed: (){
                  database.getDocument( user.uid).then((value)=>Navigator.push(context, MaterialPageRoute(builder: (context)=> AddDetails(users: value,inRoom: true,))));
                  
                },child: const Text('Change name'),),
                TextButton(onPressed: (){},child: const Text('Delete account'),),
                TextButton(onPressed: (){},child: const Text('Delete Room'),),
                TextButton(onPressed: (){},child: const Text('Add Note'),),
                TextButton(onPressed: (){},child: const Text('Profile'),),
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}

