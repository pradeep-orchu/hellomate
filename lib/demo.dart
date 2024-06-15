import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hellomate/database.dart';
import 'package:hellomate/user.dart';

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  final TextEditingController editingController = TextEditingController();
  final Database databaseService = Database();
  final Users user = Users(name: 'Fuck');
  

  void demo(){
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: editingController,
            ),
            OutlinedButton(
              onPressed:(){ databaseService.createDocument(
              'users', 
              user.toFirestore(),
              '0022');}, 
              child: Text('data')
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int? randomNumber;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Number Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (randomNumber != null)
              Text(
                'Generated Number: $randomNumber',
                style: TextStyle(fontSize: 24),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: generateAndSaveRandomNumber,
              child: Text('Generate Random Number'),
            ),
          ],
        ),
      ),
    );
  }
}