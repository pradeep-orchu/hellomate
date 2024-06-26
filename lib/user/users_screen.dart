import 'package:flutter/material.dart';
import 'package:hellomate/user/users.dart';

class UsersScreen extends StatefulWidget {
  final Users? users;
  const UsersScreen({super.key,required this.users});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.users!.name}'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name'
              ),
              Text(
                '${widget.users!.name}'
              ),
              Text(
                'Age',
              ),
              Text(
                '${widget.users!.age}'
              ),
              Text(
                'Gander'
              ),
              Text(
                '${widget.users!.gander}'
              ),
              Text(
                'About'
              ),
              Text(
                '${widget.users!.about}'
              ),
              Text(
                'Status'
              ),
              Text(
                '${widget.users!.status}'
              ),
              Text(
                'City'
              ),
              Text(
                '${widget.users!.city}'
              ),
              Text(
                'State'
              ),
              Text(
                '${widget.users!.state}'
              ),
              Text(
                'Country',

              ),
              Text(
                '${widget.users!.country}'
              ),
              Text(
                'Pincode'
              ),
              Text(
                '${widget.users!.pincode}'
              ),
            ],
          ),
        ),
      ),
    );
  }
}