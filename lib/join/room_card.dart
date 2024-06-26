import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hellomate/join/join_room_Screen.dart';
import 'package:hellomate/room/room_database.dart';
import 'package:hellomate/room/rooms.dart';

class RoomCard extends StatefulWidget {
  final Rooms? rooms;
  const RoomCard({super.key, required this.rooms});

  @override
  State<RoomCard> createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
  final RoomDatabase roomDatabase = RoomDatabase();

  final User? user = FirebaseAuth.instance.currentUser;
  late List<String> likes;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> JoinRoomScreen(rooms: widget.rooms,))
        );
        
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: Container(
          decoration: BoxDecoration(
            //color: Theme.of(context).hoverColor,
            borderRadius: BorderRadius.circular(25)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.rooms!.city}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '${widget.rooms!.country}',
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),
               
              Text(
                    '${widget.rooms!.description}',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rent: ${widget.rooms!.rent}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    'Food: ${widget.rooms!.food}',
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}