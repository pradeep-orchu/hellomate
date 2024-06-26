// import 'package:flutter/material.dart';
// import 'package:hellomate/room/room_database.dart';

// class GetRooms extends StatefulWidget {
  
//   const GetRooms({super.key});

//   @override
//   State<GetRooms> createState() => _GetRoomsState();
// }

// class _GetRoomsState extends State<GetRooms> {
//   final RoomDatabase roomDatabase = RoomDatabase();
//   @override
//   Widget build(BuildContext context) {
//     return  StreamBuilder(
//           stream: roomDatabase.getCollection(city.text),
//           builder: ( context,  snapshot) {
            
            
            
         
//           if (snapshot.data != null) {
//             return ListView.builder(
//               physics: NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: snapshot.data!.length,
//             itemBuilder: (context, index) {
//               if (snapshot.data != null) {
//                 return 
//               RoomCard(rooms: snapshot.data![index]);
//               } else{
//                 Text('Enter and Search by City');
//               }
              
             
//             }
//               );
//           }else{
//             return Text('no data');
//           }
          
          
        

        
//               });
//   }
// }