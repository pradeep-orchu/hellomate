import 'package:flutter/material.dart';

class GetNotification extends StatefulWidget {
  const GetNotification({super.key});

  @override
  State<GetNotification> createState() => _GetNotificationState();
}

class _GetNotificationState extends State<GetNotification> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'You got no notifications',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}