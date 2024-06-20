import 'package:flutter/material.dart';
import 'package:hellomate/notes/notes_database.dart';
import 'package:hellomate/room/rooms.dart';

class GetNotes extends StatefulWidget {
  final Rooms? rooms;
  const GetNotes({super.key, required this.rooms});

  @override
  State<GetNotes> createState() => _GetNotesState();
}

class _GetNotesState extends State<GetNotes> {
  final NotesDatabase notesDatabase = NotesDatabase();
  
  @override
  Widget build(BuildContext context) {
        return StreamBuilder(
          stream: notesDatabase.getNotes(widget.rooms!.roomId.toString()),
          builder: ( context,  snapshot) {
            
            
            
         
          if (snapshot.data != null) {
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index]!.context.toString()),
                subtitle: Text( snapshot.data![index]!.noteId.toString()),
               
              );
            }
              );
          }else{
            return Text('no data');
          }
          
          
        

        
              });
              
       
          }
       
  }
