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
  void signUserIn() async {
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
        password: password.text,
      );
      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // WRONG EMAIL
      if (e.code == 'user-not-found') {
        // show error to user
        print(e.message);
        wrongEmailMessage();
        
      }

      // WRONG PASSWORD
      else if (e.message == 'wrong-password') {
        // show error to user
        wrongPasswordMessage();
         print(e.message);
      }else{
        print(e.code);
      }
    }
  }

  // wrong email message popup
  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Center(
            child: Text(
              'Incorrect Email',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  // wrong password message popup
  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Center(
            child: Text(
              'Incorrect Password',
              style: TextStyle(color: Colors.white),
            ),
          ),
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
                        FilledButton(onPressed:signUserIn, child: Text('Login'))
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