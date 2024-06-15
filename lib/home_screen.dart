import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hellomate/add_details.dart';
import 'package:hellomate/camera.dart';
import 'package:hellomate/create_screen.dart';
import 'package:hellomate/demo.dart';
import 'package:hellomate/join_screen.dart';
import 'package:hellomate/settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key,});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   final user = FirebaseAuth.instance.currentUser!;
   late CameraDescription cameraDescription;

   Future<CameraDescription> camera()async {
     final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;
  return firstCamera;
   }

  @override
  Widget build(BuildContext context) {
    if(user.displayName == null){
   return const AddDetails();
    }else{
       return Scaffold(
        appBar: AppBar(
         
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          actions: [
            IconButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const Settings()));
                },
                icon: const Icon(Icons.settings)
            )
          ],
        ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Text(
                  "You did not join any room, so you can",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                   
                   Row(
                    
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                     Expanded(
                       child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const JoinScreen()));
                        },
                         child: Container(
                          height: 78,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.tertiaryContainer,
                            borderRadius: BorderRadius.circular(25)
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Join',
                                    style: Theme.of(context).textTheme.labelLarge,
                                    ),
                                    const Icon(Icons.join_inner_outlined)
                                ],
                              ),
                            )
                          ),
                         ),
                       ),
                     ),
                     const SizedBox(width: 8,),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            camera().then((value)=>  Navigator.push(context, MaterialPageRoute(builder: (context)=> TakePictureScreen(camera: value,))));
                           
                          },
                          child: Container(
                          height: 78,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(25)
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Create',
                                    style: Theme.of(context).textTheme.labelLarge,
                                    ),
                                    const Icon(Icons.add_circle_outline)
                                ],
                              ),
                            )
                            ),
                                               ),
                        ),
                      ),
                     ],
                   ),
                          
                   
              ],
                            ),
            ),
          ),
        )
      ),
      floatingActionButton: Visibility(
        visible: user.displayName == null,
        child: FloatingActionButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>  Demo()));
            },
          child: const Icon(Icons.add),
        ),
      ),
    );
    }
  }
}