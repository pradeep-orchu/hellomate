


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hellomate/database.dart';
import 'package:hellomate/user.dart';
class AddDetails extends StatefulWidget {
  const AddDetails({super.key});

  @override
  State<AddDetails> createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
   final TextEditingController name = TextEditingController();
   final TextEditingController gander = TextEditingController();
   final TextEditingController city = TextEditingController();
   final TextEditingController state = TextEditingController();
   final TextEditingController ageController = TextEditingController();
   final TextEditingController about = TextEditingController();
   final TextEditingController status = TextEditingController();
   final TextEditingController pincode = TextEditingController();

   final User? user = FirebaseAuth.instance.currentUser;
   final Database database = Database();

 

   void change () async{
     showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try{
   await FirebaseAuth.instance.currentUser!.updateDisplayName(name.text);
    
    Navigator.pop(context);
    Navigator.of(context).pop();

   }on FirebaseAuthException catch (e){
    print(e);
    Navigator.pop(context);
    
   }
   }

   void popff(){
    Navigator.of(context).pop();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(
            onPressed: (){
              change();
              
              database.createDocument(
                'users', 
                Users(
                  name: name.text,
                  age: ageController.text,
                  about: about.text,
                  pincode: pincode.text,
                  city: city.text,
                  status: status.text,

                  ).toFirestore(), 
                "${user!.uid}");
            }, 
            icon: Icon(Icons.done_rounded)
            )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 4,),
                TextField(
                  controller: name,
                  decoration: InputDecoration(
                    hintText: 'name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)
                    )
                  ),
                ),
                SizedBox(height: 8,),
               
                 
                 Row(
                   children: [
                     Expanded(
                       child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(
                      'Age',
                      style: Theme.of(context).textTheme.titleLarge,
                                       ),
                                       SizedBox(height: 4,),
                           TextField(
                            controller: ageController,
                            decoration: InputDecoration(
                              hintText: 'Age',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)
                              )
                            ),
                                    ),
                         ],
                       ),
                     ),
                     SizedBox(width: 4,),
                       Expanded(
                         child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(
                      'Gander',
                      style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(height: 4,),
                             TextField(
                                                     controller: gander,
                                                     decoration: InputDecoration(
                              hintText: 'Gander',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)
                              )
                                                     ),
                                             ),
                           ],
                         ),
                       ),
                   ],
                 ),
                 SizedBox(height: 8,),
                  Text(
                  'About',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 4,),
                TextField(
                  controller: about,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'About',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)
                    )
                  ),
                ),Text(
                  'Status',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 4,),
                 Row(
                   children: [
                     Expanded(
                       child: TextField(
                        controller: status,
                        decoration: InputDecoration(
                          hintText: 'name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)
                          )
                        ),
                                       ),
                     ),
                     SizedBox(width: 4,),
                     Expanded(
                       child: TextField(
                        controller: status,
                        decoration: InputDecoration(
                          hintText: 'name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)
                          )
                        ),
                                       ),
                     ),
                   ],
                 ),
                SizedBox(height: 8,),
                 Text(
                  'Addresss',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 4,),
                 TextField(
                  controller: state,
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: 'D.no/ Landmark',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)
                    )
                  ),
                ),
                SizedBox(height: 4,),
                Row(
                   children: [
                     Expanded(
                       child: TextField(
                        controller: city,
                        decoration: InputDecoration(
                          hintText: 'city',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)
                          )
                        ),
                                       ),
                     ),
                     SizedBox(width: 4,),
                     Expanded(
                       child: TextField(
                        controller: pincode,
                        decoration: InputDecoration(
                          hintText: 'pincode',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)
                          )
                        ),
                                       ),
                     ),
                   ],
                 ),
                SizedBox(height: 8,),
                 
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}