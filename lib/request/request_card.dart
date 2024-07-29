import 'package:flutter/material.dart';
import 'package:hellomate/request/request.dart';
import 'package:hellomate/room/room_database.dart';

class RequestCard extends StatefulWidget {
  final Requests? requests;
  const RequestCard({super.key, required this.requests});

  @override
  State<RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  final RoomDatabase roomDatabase = RoomDatabase();
 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Theme.of(context).hoverColor,
          borderRadius: BorderRadius.circular(25)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Text(
              '${widget.requests!.time}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
                
            //     GestureDetector(child: Icon(Icons.thumb_up_outlined,size: 16,))
               
            //   ],
            // )
            OutlinedButton(onPressed: (){
               // roomDatabase.updateDocument(, newData)
            }, child: Text(
              'agree'
            ))
          ],
        ),
      ),
    );
  }
}