import 'package:flutter/material.dart';
import 'package:hellomate/home/inroom_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
     future: roomDatabase.getDocument('docId'),
     builder: (context,snapshot){
      if (snapshot.connectionState == ConnectionState.done) {
        if (widget.users!.inRoom == true) {
        return  InroomScreen(users: widget.users,rooms:snapshot.data,);
        }else if ( widget.users!.inRoom == false){
          return const NotInroom();
        }
        else{
          return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
        }
      }else{
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
     }
     );
  }
}