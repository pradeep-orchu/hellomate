import 'package:flutter/material.dart';
import 'package:hellomate/request/request_card.dart';
import 'package:hellomate/request/request_database.dart';
import 'package:hellomate/room/room_database.dart';
import 'package:hellomate/room/rooms.dart';

class GetRequest extends StatefulWidget {
  final Rooms? rooms;
  const GetRequest({super.key, this.rooms});

  @override
  State<GetRequest> createState() => _GetRequestState();
}

class _GetRequestState extends State<GetRequest> {
  final RequestDatabase requestDatabase = RequestDatabase();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
          stream: requestDatabase.getRequest(widget.rooms!.roomId!.toString()),
          builder: ( context,  snapshot) {
            print(snapshot.data);
            
          if (snapshot.data != null) {
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return 
              RequestCard(requests: snapshot.data![index]);
             
            }
              );
          }else{
            return Text('no data');
          }
          
          
        

        
              });
  }
}