import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hellomate/location/location_service.dart';
import 'package:hellomate/room/room_database.dart';
import 'package:hellomate/room/rooms.dart';
import 'package:hellomate/room/storage.dart';
import 'package:hellomate/user/users.dart';
import 'package:hellomate/user/users_database.dart';

class CreateScreen extends StatefulWidget {
  final File image;

  const CreateScreen({super.key, required this.image});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final TextEditingController rent = TextEditingController();
  final TextEditingController food = TextEditingController();
  final TextEditingController discreption = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController country = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController pincode = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController rules = TextEditingController();

  final User? user = FirebaseAuth.instance.currentUser;

  final Storage storage = Storage();
  final RoomDatabase roomDatabase = RoomDatabase();
  List<String>? nearby;

  int? randomNumber;

   @override
  void initState() {
    super.initState();
    _getloc();
  }

  Future<void> _getloc() async {
    Placemark? loc = await LocationService.getCityName(0);
    Placemark? near1 = await LocationService.getCityName(1);
    Placemark? near2 = await LocationService.getCityName(2);
    Placemark? near3 = await LocationService.getCityName(3);
    //cityName = loc!.locality;
    setState(() {
      city.text = loc!.locality!;
      country.text = loc.country!;
      pincode.text = loc.postalCode!;
      state.text = loc.administrativeArea!;
      address.text = '${loc.name!} ${loc.thoroughfare}';
      nearby = ['${near1!.locality}','${near2!.locality}''${near3!.locality}'];
    });
  }
  void create (){
    showDialog(
      context: context, 
    builder: (context)=> AlertDialog(
      content: DropdownMenu(
        dropdownMenuEntries: 
      [
        
      ]
      ),
      actions: [
        OutlinedButton(onPressed: (){
            Random random = Random();
    int number = random.nextInt(9000) + 1000;
            storage.uploadImage('room/$number', widget.image).then((value) => 
            roomDatabase.createDocument('$number',Rooms(
              image: value,
              roomId: number,
              rent: int.tryParse(rent.text),
              food: int.tryParse(food.text),
              pincode: int.tryParse(pincode.text),
              rules: rules.text,
              address: address.text,
              country: country.text,
              city: city.text,
              nearby: nearby,
              state: state.text,
              description: discreption.text,
              mates:[user!.uid] ,

            ).toFirestore() )
            ,).then((value)=> 
              UsersDatabase().updateDocument( user!.uid, Users(inRoom: number.toString()).toFirestore())
            );
             setState(() {
      randomNumber = number;
    });
        }, child: Text('Create')
        )
      ],
    )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create'),
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(onPressed: create, icon: const Icon(Icons.done_rounded))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  AspectRatio(
                    aspectRatio: 16/9,
                    child: Container(

                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(25)
                      ),

                      child: Transform.rotate(
                        angle: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.file(
                            fit: BoxFit.cover,
                            widget.image
                            ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Expenses',
                    style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4,),
                    Row(

                      children: [
                        Expanded(
                          child: TextField(
                            controller: rent,
                            decoration: InputDecoration(
                              hintText: 'Rent',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)
                              )
                            ),
                          ),
                        ),
                        const SizedBox(width: 4,),
                        Expanded(
                          child: TextField(
                            controller: food,
                            decoration: InputDecoration(
                              hintText: 'Food',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)
                              )
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                  'Description',
                  style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4,),
                  TextField(
                    controller: discreption,
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)
                      )
                    ),
                  ),
                  
                    const SizedBox(height: 8,),
                    Text(
                    'Location Details',
                    style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4,),
                    TextField(
                      controller: address,
                      decoration: InputDecoration(
                        hintText: 'D-No/ Landmark.',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)
                        )
                      ),
                    ),
                    const SizedBox(height: 4,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: city,
                            decoration: InputDecoration(
                        hintText: 'City',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)
                        )
                      ),
                          ),
                        ),
                        const SizedBox(width: 4,),
                        Expanded(
                          child: TextField(
                            controller: state,
                            decoration: InputDecoration(
                        hintText: 'State',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)
                        )
                      ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 4,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: country,
                            decoration: InputDecoration(
                        hintText: 'Country',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)
                        )
                      ),
                          ),
                        ),
                        const SizedBox(width: 4,),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: pincode,
                            decoration: InputDecoration(
                        hintText: 'Pincode',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)
                        )
                      ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 8,),
                    Text(
                      'Rules and Regulations',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4,),
                     TextField(
                      maxLines: 3,
                      controller: rules,
                      decoration: InputDecoration(
                        hintText: 'Rules',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)
                        )
                      ),
                    ),
                    
                    const SizedBox(height: 8,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}