import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final TextEditingController email = TextEditingController();

  // sign user in method
  void send() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try sign in
   
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email.text,
      );
      // pop the loading circle
      Navigator.pop(context);
    
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                      controller: email,
                      decoration: InputDecoration(
                        hintText: 'Password', 
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)
                          )),),
                          SizedBox(height: 4,),
                          ElevatedButton(onPressed: send, child: Text('Send email'))
            ],
          ),
        ),
      ),
    );
  }
}