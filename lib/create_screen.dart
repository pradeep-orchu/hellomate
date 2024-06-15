import 'dart:io';

import 'package:flutter/material.dart';

class CreateScreen extends StatefulWidget {
  final String imagePath;

  const CreateScreen({super.key, required this.imagePath});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final TextEditingController rent = TextEditingController();
  final TextEditingController food = TextEditingController();
  final TextEditingController discreption = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController country = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController pincode = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController rules = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create'),
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.done_rounded))
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
                            File(widget.imagePath)
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
                      controller: location,
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