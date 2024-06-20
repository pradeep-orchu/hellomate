import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hellomate/room/room_database.dart';
import 'package:hellomate/room/rooms.dart';
import 'package:hellomate/user/users.dart';
import 'package:hellomate/user/users_database.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  final List<TextEditingController> _pinControllers = List.generate(4, (_) => TextEditingController());
  final RoomDatabase roomDatabase = RoomDatabase();
  final Rooms rooms = Rooms();
    final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _pinControllers.map((controller) =>
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextField(
                        controller: controller,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: '0',
                          counterText: "", // Hide the default counter
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onChanged: (pin) {
                          if (pin.length == 1) {
                            // Move focus to the next field if entered a digit
                            FocusScope.of(context).nextFocus();
                          } else if (pin.isEmpty) {
                            // Move focus to the previous field if backspaced
                            FocusScope.of(context).previousFocus();
                          }
                        },
                      ),
                    ),
                  ),
                ).toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton(
                  onPressed: (){
                    roomDatabase.createDocument(_pinControllers.toString(),Rooms(mates: [(user!.uid)]).toFirestore()).then( (value)=>
                      UsersDatabase().createDocument(Users(inRoom: true).toFirestore(), user!.uid)
                    );
                  }, 
                  child: const Text('Join')
                  )
              ],
            )
              ],
            ),
          ),
        ),
      ),
    );
  }
}