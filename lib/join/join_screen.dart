import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hellomate/join/room_card.dart';
import 'package:hellomate/location/location_service.dart';
import 'package:hellomate/room/room_database.dart';
import 'package:hellomate/room/rooms.dart';
import 'package:hellomate/user/users.dart';
import 'package:hellomate/user/users_database.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
 final TextEditingController city = TextEditingController();
  final RoomDatabase roomDatabase = RoomDatabase();
  final Rooms rooms = Rooms();
    final User? user = FirebaseAuth.instance.currentUser;
  List<Rooms?>? data;

  bool _isLoading = false;
    @override
  void initState() {
    super.initState();
    _getloc();
  }


  void getRooms() async{
    setState(() {
      _isLoading = true;
    });
     List<Rooms?>? doc = await roomDatabase.getCollection(city.text);
    setState(() {
      data = doc;
      _isLoading = false;
    });
  }

    Future<void> _getloc() async {
    Placemark? loc = await LocationService.getCityName(0);
    setState(() {
      city.text = loc!.locality!;
    });
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
          
          
            children: [
             
                   TextField(
                    controller: city,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)
                      ),
                      suffixIcon: IconButton(onPressed: getRooms, icon: const Icon(Icons.search))
                    ),
                    onSubmitted: (value)=> value ,
                   ),
                   SizedBox(height: 8,),
                  data == null?
                  Text('Not Data'):
                   _isLoading?
                   const CircularProgressIndicator():
                   Expanded(
                     child: ListView.builder(
          itemCount: data!.length,
          itemBuilder: (context, index) {
            return RoomCard(rooms: data![index]);
          },
                     ),
                   ),
          
            ],
          ),
        ),
      ),
    );
  }
}