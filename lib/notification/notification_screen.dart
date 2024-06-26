import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hellomate/notification/get_notification.dart';
import 'package:hellomate/request/get_request.dart';
import 'package:hellomate/room/rooms.dart';

class NotificationScreen extends StatefulWidget {
  final Rooms? rooms;
  const NotificationScreen({super.key,required this.rooms});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
            appBar: AppBar(
              bottom:  const TabBar(
                tabs: [
                  Tab(text: 'Messages',),
                  Tab(text: 'Request',),
                  
                ],
              ),
              title: const Text('Notifications'),
            ),
            body:  TabBarView(
              children: [
                GetNotification(),
                GetRequest(rooms: widget.rooms,),
              ],
            ),
      ),
    );
  }
}