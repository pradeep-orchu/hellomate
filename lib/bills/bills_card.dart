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
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Theme.of(context).colorScheme.secondaryContainer
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Bills',
                                          style: Theme.of(context).textTheme.titleLarge,
                                          ),
                                        Text(
                                          'Here you can add bills of your Room other expenses,also split bills.',
                                          style: Theme.of(context).textTheme.bodyLarge,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          )
                                      ],
                                    ),
                                  ),
                                  IconButton(onPressed: (){}, icon: Icon(Icons.add_circle_outline_rounded,size: 60,))
                                ],
                              ),
                            ),
                                                  );
  }
}