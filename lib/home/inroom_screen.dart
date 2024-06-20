import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hellomate/bills/bills_card.dart';
import 'package:hellomate/home/not_inroom.dart';
import 'package:hellomate/home/settings.dart';
import 'package:hellomate/notes/get_notes.dart';
import 'package:hellomate/notes/notes.dart';
import 'package:hellomate/notes/notes_database.dart';
import 'package:hellomate/room/food_card.dart';
import 'package:hellomate/room/rent_card.dart';
import 'package:hellomate/room/room_database.dart';
import 'package:hellomate/room/rooms.dart';
import 'package:hellomate/user/add_details.dart';
import 'package:hellomate/user/users.dart';
import 'package:hellomate/user/users_database.dart';

class InroomScreen extends StatefulWidget {
  final Rooms? rooms;
  final Users? users;
  const InroomScreen({super.key, required this.users, required this.rooms});

  @override
  State<InroomScreen> createState() => _InroomScreenState();
}

class _InroomScreenState extends State<InroomScreen> {
  final TextEditingController note = TextEditingController();
   final UsersDatabase usersDatabase = UsersDatabase();
   final user = FirebaseAuth.instance.currentUser!;
   late CameraDescription cameraDescription;
   final RoomDatabase roomDatabase = RoomDatabase();
   final NotesDatabase notesDatabase = NotesDatabase();
    final noteId ='${DateTime.now().hour}: ${DateTime.now().minute}: ${DateTime.now().second}' ;


   Future<CameraDescription> camera()async {
     final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;
  return firstCamera;
   }

  
  void addNote(){
    showAdaptiveDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          actions: [
            IconButton(
              onPressed:(){ 
                notesDatabase.createDocument(
                  widget.rooms!.roomId.toString(),
                  Notes(
                    context: note.text,
                    user: user.uid,
                    time: DateTime.now().minute.toString(),
                    noteId: noteId,
                    roomId: widget.rooms!.roomId
                  ).toFirestore(),
                  noteId.toString()
                );
                Navigator.pop(context);
                note.clear();
                },
                icon:const Icon( Icons.done),
            )
          ],
          title: Center(
            child: TextField(
              controller: note,
            ),
          ),
        );
      }
      );
  }
 
  
  

  @override
  Widget build(BuildContext context) {
    if(widget.users!.inRoom == true){

      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body:  SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Stack(
              children: [SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        PopupMenuButton(
                        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
               PopupMenuItem(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const Settings()));
                },
                
                child: const Text('Settings'),
              ),
              const PopupMenuItem(
                
                child: Text('Search'),
              ),
              const PopupMenuItem(
                
                child: Text('Exit Room'),
              ),
                        ],
                      ),
                      ],
                    ),
                    Text(
                      'Hello,',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      '${widget.users!.name}',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(height: 8,),
                    Row(
                      children: [
                        RentCard(rooms: widget.rooms, ),
                        const SizedBox(width: 8,),
                         FoodCard(rooms: widget.rooms, )
                      ],
                    ),
                    const SizedBox(height: 8,),
                     const BillsCard(),
                          const SizedBox(height: 8,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Notes',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const Icon(Icons.add_rounded,size: 32,)
                            ],
                          ),
                          GetNotes(rooms: widget.rooms)
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    height: 60,
                    width: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Theme.of(context).colorScheme.primaryContainer
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=> AddDetails(users: widget.users,inRoom: widget.users!.inRoom,)));
                          }, 
                          icon: const Icon(Icons.account_circle_rounded,size: 40,)
                          ),
                           IconButton(
                          onPressed: (){


                          }, 
                          icon: const Icon(Icons.notifications_rounded,size: 40,),
                          ), 
                          IconButton(
                          onPressed: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=> const Settings()));
                          }, 
                          icon: const Icon(Icons.settings,size: 40,)
                          ),
                      ],
                    ),
                  ),
                ),
              )
              ]
            ),
          )
        ),
        
      );
    }else{
     return const NotInroom();
    }
  }
}