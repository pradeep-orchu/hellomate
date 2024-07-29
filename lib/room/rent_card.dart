import 'package:flutter/material.dart';
import 'package:hellomate/request/request.dart';
import 'package:hellomate/request/request_database.dart';
import 'package:hellomate/room/room_database.dart';
import 'package:hellomate/room/rooms.dart';
import 'package:hellomate/user/users.dart';

class RentCard extends StatefulWidget {
  final Rooms? rooms;
  final Users? users;
  const RentCard({super.key, required this.rooms, required this.users});

  @override
  State<RentCard> createState() => _RentCardState();
}

class _RentCardState extends State<RentCard> {
  final RequestDatabase requestDatabase = RequestDatabase();
 
  final requestId = DateTime.now();
  @override
  Widget build(BuildContext context) {
    
    return  Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Theme.of(context).hoverColor
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Rent",
                                        style: Theme.of(context).textTheme.titleLarge,
                                      ),
                                       Row(
                                         children: [
                                           Text('Total:',style: Theme.of(context).textTheme.labelLarge,),
                                           SizedBox(width: 4,),
                                           Text(
                                                                            "${widget.rooms!.rent}",
                                                                            style: Theme.of(context).textTheme.headlineSmall,
                                                                          ),
                                         ],
                                       ),
                                        
                                        Row(
                                          children: [
                                            Text("Share:",style: Theme.of(context).textTheme.labelLarge,),
                                            SizedBox(width: 4,),
                                             Text(
                                                                            "${widget.rooms!.rent!/ (widget.rooms!.mates!.length)}",
                                                                            style: Theme.of(context).textTheme.headlineSmall,
                                                                          ),
                                          ],
                                        ),
                                       
                                    ],
                                  ),
                                
                                  
                                ],
                              ),
                            ),
                          ),
                                                  );
  }
}