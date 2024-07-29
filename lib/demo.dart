import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hellomate/location/location_service.dart';
import 'package:hellomate/user/users_database.dart';
import 'package:hellomate/user/users.dart';

class Demo extends StatefulWidget {
  
   const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> with SingleTickerProviderStateMixin{
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:  const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello \nPradeep Krishna',
                  style: Theme.of(context).textTheme.displayMedium,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                 SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: 200,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Theme.of(context).colorScheme.primaryContainer
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Rent',
                              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                color: Theme.of(context).hintColor
                              ),
                              ),
                              Text('1000',
                                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                  
                                ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                 SizedBox(width: 8,),
                
                    Expanded(
                      child:Column(
                  children: [ Container(
                        height: 100,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Theme.of(context).colorScheme.secondaryContainer
                        ),
                        child:  Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Food',
                                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: Theme.of(context).hintColor
                                  ),
                                  ),
                                  Text('1000',
                                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                      
                                    ),
                                    ),
                                ],
                              ),
                            ),
                        ),
                      
                    
                  
                 SizedBox(height: 8,),
                Container(
                  height: 100,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context).colorScheme.tertiaryContainer
                  ),
                  child:   Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Bills',
                              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                color: Theme.of(context).hintColor
                              ),
                              ),
                              Text('1000',
                                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                  
                                ),
                                ),
                            ],
                          ),
                        ),
                ),
                ],
                ),
                    )
                 ],
                ),
            
                Text(
                  'Notes',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 8,
                  itemBuilder: (context,index)=>
                
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Theme.of(context).colorScheme.surfaceContainer
                    ),
                    child:  Center(
                      child: Text('Pradeep Krishna',
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      ),
                      ),
                    ),
                  ),
                ),
                ),
                ],
            ),
          ),
        ),
      ),
      endDrawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Center(
                child: Text(
                  'PRadeep'
                ),
              ),
            ),
            Row(
              children: [
                Icon(Icons.settings,),
                Text(
                  'Settings',
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
            Row(
              children: [
                Icon(Icons.settings,),
                Text(
                  'Settings',
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
            Row(
              children: [
                Icon(Icons.settings,),
                Text(
                  'Settings',
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
            Row(
              children: [
                Icon(Icons.settings,),
                Text(
                  'Settings',
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        child: Icon(Icons.add),
        ),
    );
  }
}
