import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hellomate/user/users_database.dart';
import 'package:hellomate/user/users.dart';

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  final TextEditingController editingController = TextEditingController();
  final UsersDatabase databaseService = UsersDatabase();
  final Users user = Users(name: 'Fuck');
  

  void demo(){
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: editingController,
            ),
            OutlinedButton(
              onPressed:(){ databaseService.addDocument(
              user.toFirestore(),
              '0022');}, 
              child: const Text('data')
             )
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final UsersDatabase usersDatabase = UsersDatabase();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int? randomNumber;
  final User? user = FirebaseAuth.instance.currentUser;

  void generateAndSaveRandomNumber() async {
    // Generate a random 4-digit number
    Random random = Random();
    int number = random.nextInt(9000) + 1000;

    // Save to Firestore
    await _firestore.collection('randomNumbers').add({
      'number': number,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Update the state to show the generated number
    setState(() {
      randomNumber = number;
    });
  }

void fuck (){
  usersDatabase.getDocument(user!.uid).then((value)=> print(value));
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Number Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (randomNumber != null)
              Text(
                'Generated Number: $randomNumber',
                style: const TextStyle(fontSize: 24),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: fuck,
              child: const Text('Generate Random Number'),
            ),
          ],
        ),
      ),
    );
  }
}