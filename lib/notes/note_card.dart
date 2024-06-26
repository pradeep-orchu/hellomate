import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hellomate/notes/notes.dart';
import 'package:hellomate/notes/notes_database.dart';

class NoteCard extends StatefulWidget {
  final Notes? notes;
  const NoteCard({super.key, required this.notes});

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  final NotesDatabase notesDatabase = NotesDatabase();

  final User? user = FirebaseAuth.instance.currentUser;
  late List<String> likes;
  @override
  Widget build(BuildContext context) {
    final like = widget.notes!.likes;
    return Padding(
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
                  "${widget.notes!.user}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '${widget.notes!.time}',
                  style: Theme.of(context).textTheme.titleSmall,
                )
              ],
            ),
            Text(
              '${widget.notes!.context}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
                
            //     GestureDetector(child: Icon(Icons.thumb_up_outlined,size: 16,))
               
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}