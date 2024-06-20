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
     
    return Expanded(
                          child: Container(
                            width: double.maxFinite,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Theme.of(context).colorScheme.primaryContainer
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Food",
                                        style: Theme.of(context).textTheme.titleSmall,
                                      ),
                                       Text(
                                    "₹${widget.rooms!.food}(each 1000)",
                                    style: Theme.of(context).textTheme.labelLarge,
                                  ),
                                    ],
                                  ),
                                 Text(
                                  'let your room mates Know your paying',
                                  maxLines: 4,
                                  style: Theme.of(context).textTheme.labelSmall,
                                    ),
                                  FilledButton(
                                    onPressed: (){}, 
                                    child: Text('Pay now')
                                    )
                                ],
                              ),
                            ),
                          ),
                        );
  }
}