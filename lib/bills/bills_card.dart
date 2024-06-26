import 'package:flutter/material.dart';

class BillsCard extends StatefulWidget {
  const BillsCard({super.key});

  @override
  State<BillsCard> createState() => _BillsCardState();
}

class _BillsCardState extends State<BillsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
                            width: double.maxFinite,
                            height: 124,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Theme.of(context).hoverColor
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Coming soon...',
                                        style: Theme.of(context).textTheme.titleLarge,
                                        ),
                                      
                                    ],
                                  ),
                                ),
                                
                              ],
                            ),
                                                  );
  }
}