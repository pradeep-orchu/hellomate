import 'package:flutter/material.dart';
import 'package:hellomate/room/rooms.dart';

class RentCard extends StatefulWidget {
  final Rooms? rooms;
 final Color? color;
  const RentCard({super.key, required this.rooms, this.color});

  @override
  State<RentCard> createState() => _RentCardState();
}

class _RentCardState extends State<RentCard> {
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
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Rent",
                                        style: Theme.of(context).textTheme.titleSmall,
                                      ),
                                       Text(
                                    "₹${widget.rooms!.rent}(per head ${widget.rooms!.rent!/widget.rooms!.mates!.length})",
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
                                    child: const Text('Pay now')
                                    )
                                ],
                              ),
                            ),
                          ),
                        );
  }
}