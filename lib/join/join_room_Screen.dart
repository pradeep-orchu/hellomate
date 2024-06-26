import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hellomate/request/request.dart';
import 'package:hellomate/request/request_database.dart';
import 'package:hellomate/room/rooms.dart';

class JoinRoomScreen extends StatefulWidget {
  final Rooms? rooms;
  const JoinRoomScreen({super.key, required this.rooms});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final RequestDatabase requestDatabase = RequestDatabase();
  final requestId ='${DateTime.now().millisecondsSinceEpoch}' ;

  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              widget.rooms!.image == null?
            Text('data'):
            //  Image.network('https://firebasestorage.googleapis.com/v0/b/hello-mate-7.appspot.com/o/room?alt=media&token=07ed94f3-f1b1-402a-9cb1-96c44fe1c2a5'):
              Container(
                //height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25)
                ),
                child: AspectRatio(
                  aspectRatio: 16/9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network('${widget.rooms!.image.toString()}',fit: BoxFit.cover,),
                  ),
                ),
              ),
              

              OutlinedButton(onPressed: (){

                requestDatabase.createDocument(
                  "${widget.rooms!.roomId}", 
                Requests(
                  mates: widget.rooms!.mates,
                  type: 1,
                  agree: false,
                  isSeen: [],
                  agreed: [],
                    time: ' ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}: ${DateTime.now().minute}',
                  user: user!.uid
                ).toFirestore()
                , requestId
                );
              }, child: Text('Join request'))
          
            ],
          ),
        ),
    );
  }
}