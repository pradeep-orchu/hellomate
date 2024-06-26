import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hellomate/home/inroom_screen.dart';
import 'package:hellomate/home/loading_screen.dart';
import 'package:hellomate/home/not_inroom.dart';
import 'package:hellomate/room/room_database.dart';
import 'package:hellomate/user/users.dart';

class InoutRoom extends StatefulWidget {
  final Users? users;
  const InoutRoom({super.key, this.users});

  @override
  State<InoutRoom> createState() => _InoutRoomState();
}

class _InoutRoomState extends State<InoutRoom> {
  final RoomDatabase roomDatabase = RoomDatabase();
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final String? roomId = widget.users!.inRoom;
    return FutureBuilder(
     future: roomDatabase.getDocument("$roomId"),
     builder: (context,snapshot){
      if(snapshot.connectionState == ConnectionState.done){
        if(snapshot.hasData){
          return InroomScreen(users: widget.users, rooms: snapshot.data);
        }else{
          return NotInroom();
        }
      }else{
       return LoadingScreen();
      }
     }
     
     );
  }
}