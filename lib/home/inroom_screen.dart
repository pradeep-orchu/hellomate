import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hellomate/bills/bills_card.dart';
import 'package:hellomate/home/home_screen.dart';
import 'package:hellomate/home/inout_room.dart';
import 'package:hellomate/home/not_inroom.dart';
import 'package:hellomate/home/settings.dart';
import 'package:hellomate/home/start_screen.dart';
import 'package:hellomate/join/join_room_Screen.dart';
import 'package:hellomate/join/join_screen.dart';
import 'package:hellomate/notes/get_notes.dart';
import 'package:hellomate/notes/notes.dart';
import 'package:hellomate/notes/notes_database.dart';
import 'package:hellomate/notification/notification_screen.dart';
import 'package:hellomate/room/food_card.dart';
import 'package:hellomate/room/rent_card.dart';
import 'package:hellomate/room/room_database.dart';
import 'package:hellomate/room/rooms.dart';
import 'package:hellomate/user/add_details.dart';
import 'package:hellomate/user/users.dart';
import 'package:hellomate/user/users_database.dart';
import 'package:hellomate/user/users_screen.dart';

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
    final noteId ='${DateTime.now().millisecond}' ;


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
                    user: widget.users!.name,
                    time: ' ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}: ${DateTime.now().minute}',
                    noteId: noteId,
                    roomId: widget.rooms!.roomId,
                    likes: []
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
 
  void exitRoom( List<String> mate){
    showAdaptiveDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          title: const Text('Exit room'),
          content: const Text("Do you want to exit from this room"),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(onPressed: (){
                 Navigator.pop(context);
                }, child: const Text('no')),
                 OutlinedButton(onPressed: (){
                   roomDatabase.updateDocument('${widget.rooms!.roomId}', Rooms(mates: mate).toFirestore()).then(
                    (e)=>usersDatabase.updateDocument('${user.uid}', Users(inRoom: '').toFirestore()).then((e)=> Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomeScreen())))
                  );
                  Navigator.pop(context);
                 
                 }, child: const Text('yes')),
              ],
            ),
           
          ],
        );
      }
      );
  }
  

  @override
  Widget build(BuildContext context) {
    final nmate = widget.rooms!.mates!;
    if(widget.users!.inRoom != null){

      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
          actions: [
            IconButton(onPressed: (){
              nmate.remove(user.uid);
              exitRoom(nmate);
              }, icon: const Icon(Icons.exit_to_app_rounded,),)
          ],
        ),
        body:  SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Stack(
              children: [SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    
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
                        RentCard(rooms: widget.rooms, users: widget.users, ),
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
                              GestureDetector(onTap: addNote, child: const Icon(Icons.add_rounded,size: 32,))
                            ],
                          ),
                          const SizedBox(height: 4,),
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
                    width: 240,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                     // color: Theme.of(context).hoverColor
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=> UsersScreen(users: widget.users,)));
                          }, 
                          icon: const Icon(Icons.account_circle_rounded,size: 40,)
                          ),
                           IconButton(
                          onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> NotificationScreen(rooms: widget.rooms,)));
                  
                          }, 
                          icon: const Icon(Icons.notifications_rounded,size: 40,),
                          ),
                          IconButton(
                          onPressed: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>  const JoinScreen()));
                          }, 
                          icon: const Icon(Icons.search_rounded,size: 40,)
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