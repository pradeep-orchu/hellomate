import 'package:flutter/material.dart';
import 'package:hellomate/room/rooms.dart';

class FoodCard extends StatefulWidget {
  final Rooms? rooms;
 final Color? color;
  const FoodCard({super.key, this.rooms, this.color});

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  @override
  Widget build(BuildContext context) {
     
    return  Expanded(
                          child: Container(
                            width: double.maxFinite,
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
                                        "Food",
                                        style: Theme.of(context).textTheme.titleLarge,
                                      ),
                                       Row(
                                         children: [
                                           Text('Total:',style: Theme.of(context).textTheme.labelLarge,),
                                       SizedBox(width: 4,),
                                        Text(
                                                                            "${widget.rooms!.food}",
                                                                            style: Theme.of(context).textTheme.headlineSmall,
                                                                          ),
                                                                            ],
                                       ),
                                        Row(
                                          children: [
                                            Text('Share:',style: Theme.of(context).textTheme.labelLarge,),
                                            SizedBox(width: 4,),
                                             Text(
                                                                            "${widget.rooms!.food!/ (widget.rooms!.mates!.length)}",
                                                                            style: Theme.of(context).textTheme.headlineSmall,
                                                                          ),
                                          ],
                                        ),
                                       
                                    ],
                                  ),
                                //  Text(
                                //   'let your room mates Know your paying',
                                //   maxLines: 4,
                                //   style: Theme.of(context).textTheme.labelSmall,
                                //     ),
                                  
                                ],
                              ),
                            ),
                          ),
                                                  );
  }
}