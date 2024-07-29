import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hellomate/bills/bills_card.dart';
import 'package:hellomate/demo.dart';
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

class _InroomScreenState extends State<InroomScreen> with SingleTickerProviderStateMixin{

 late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
        ),
        body:  SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hello,\n${widget.users!.name}',
                       style: Theme.of(context).textTheme.displayMedium,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8,),
                     Row(
                      children: [
                        const BillsCard(),
                        Column(
                          children: [
                            RentCard(rooms: widget.rooms, users: widget.users, ),
                            const SizedBox(width: 4,),
                         FoodCard(rooms: widget.rooms, )
                          ],
                        ),
                        
                      ],
                    ),
                    const SizedBox(height: 4,),
                     
                          const SizedBox(height: 8,),
                           Text(
                                'Notes',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              GetNotes(rooms: widget.rooms),
                          const SizedBox(height: 4,),
                          
                  ],
                ),)
                ,
              ),),
        
       endDrawer: Drawer(
        child: Column(
          children: [
             IconButton(onPressed: (){
              nmate.remove(user.uid);
              exitRoom(nmate);
              }, icon: const Icon(Icons.exit_to_app_rounded,),),
          ],
        ),
       ),
          
      );
    }else{
     return const NotInroom();
    }
  }
}