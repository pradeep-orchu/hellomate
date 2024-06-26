import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hellomate/home/inout_room.dart';
import 'package:hellomate/home/loading_screen.dart';
import 'package:hellomate/location/location_service.dart';
import 'package:hellomate/user/add_details.dart';
import 'package:hellomate/user/users.dart';
import 'package:hellomate/user/users_database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key,});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocationService locationService = LocationService();
  final UsersDatabase usersDatabase = UsersDatabase();
   final user = FirebaseAuth.instance.currentUser!;
   late CameraDescription cameraDescription;
 
   late Users users;

   

   Future<CameraDescription> camera()async {
     final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;
  return firstCamera;
   }

   


  @override
  Widget build(BuildContext context) {
  return FutureBuilder<Users?>(
    future: usersDatabase.getDocument(user.uid), 
    builder: (context,snapshot){
      
      if(snapshot.connectionState == ConnectionState.waiting){
        return LoadingScreen();
      } else if (snapshot.connectionState == ConnectionState.done){
        if (snapshot.data != null){
      
       return  InoutRoom(users: snapshot.data,);
      }else{
         return AddDetails(inRoom: false,);
         
      }
      }else{
        return LoadingScreen();
      }
    }
    );
  }
}