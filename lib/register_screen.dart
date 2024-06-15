import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback toggle;
  const RegisterScreen({super.key, required this.toggle});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirm = TextEditingController();

   // sign user in method
  void create() async {
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
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
        wrongEmailMessage();
      }

      // WRONG PASSWORD
      else if (e.code == 'wrong-password') {
        // show error to user
        wrongPasswordMessage();
      }
    }
  }

  // wrong email message popup
  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
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
          backgroundColor: Colors.deepPurple,
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

  void help(){
    showAdaptiveDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          actions: [
            BackButton(
              onPressed:(){ Navigator.pop(context);},
            )
          ],
          title: Center(
            child: Text('sknnsfksdfjkjdsfkj'),
          ),
        );
      }
      );
  }
 
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Register",
                style: Theme.of(context).textTheme.displayMedium,
                ),
                Text('with your email and password',style: Theme.of(context).textTheme.headlineSmall,),
                SizedBox(height: 16,),
                TextField(
                  obscureText: false,
                  controller:email,
                  decoration: InputDecoration(
                    hintText: 'Email', 
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),),
                SizedBox(height: 4,),
                TextField(
                  obscureText: true,
                  controller:password, 
                  decoration: InputDecoration(
                    hintText: 'Password', 
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),),
                SizedBox(height: 4,),
                TextField(
                  obscureText: true,
                  controller:confirm, 
                  decoration: InputDecoration(
                    hintText: 'Confirm Password', 
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),),
                SizedBox(height: 4,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed:help,
                      child: Text(
                        'Need help?'
                        )
                        ),
                        FilledButton(onPressed:(){
                          if(password.text== confirm.text){
                            create();
                          }else{
                          }
                        }, child: Text('Register'))
                        ],
                        ),
                        SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already had an account",style: Theme.of(context).textTheme.labelLarge,),
                            OutlinedButton(onPressed: widget.toggle, child: Text('Login')),
                          ],
                        )
                        ],
                        ),
        ),
      ),
    )),);
  }
}