import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hellomate/auth/forget_screen.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback toggle;
  const LoginScreen({super.key, required this.toggle});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  // sign user in method
  Future<void> signUserIn() async {
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
   try {
   await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email.text,
    password: password.text
  ).then((e)=> Navigator.pop(context));
} on FirebaseAuthException catch (e) {
  Navigator.pop(context);
  _showErrorDialog(e.message);
}
  }

   void _showErrorDialog(String? message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Login Error'),
        content: Text(message ?? 'An unknown error occurred.'),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  // wrong email message popup
  void wrongEmtyTExt() {
    showDialog(
      context: context,
      builder: (context) {
        return  AlertDialog(
          title: Text('Login Error'),
          content: Text(
            'Enter both email and password',
           
            
          ),
          actions: [
            TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            }
          )
          ],
        );
      },
    );
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Login",
                style: Theme.of(context).textTheme.displayMedium,
                ),
                Text('with your email and password',style: Theme.of(context).textTheme.headlineSmall,),
                SizedBox(height: 16,),
                TextField(
                  obscureText: false,
                  controller: email,
                  decoration: InputDecoration(
                    hintText: 'Email', 
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),),
                SizedBox(height: 4,),
                TextField(
                  obscureText: true,
                  controller: password,
                  decoration: InputDecoration(
                    hintText: 'Password', 
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)
                      )),),
                SizedBox(height: 4,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgetScreen()));
                      },
                      child: Text(
                        'Forget Password'
                        )
                        ),
                        FilledButton(
                          onPressed:(){
                            if (email.text != "" || password.text != ""){
                        signUserIn();}else{
                          wrongEmtyTExt();
                        }
                        }, 
                        child: Text('Login'))
                        ],
                        ),
                        SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account",style: Theme.of(context).textTheme.labelLarge,),
                            OutlinedButton(onPressed: widget.toggle, child: Text('Register')),
                          ],
                        )
                        ],
                        ),
        ),
      ),
    )),);
  }
}