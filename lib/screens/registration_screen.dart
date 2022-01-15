import 'package:flash_chat/components/reusable_button.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = '/registration';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late FirebaseAuth _auth;
  late String email;
  late String password;
  bool show = false;

  void register() async {
    await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;
    setState(() {
      show = true;
    });
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if (newUser != null) {
        Navigator.pushNamed(context, ChatScreen.id);
      }

      setState(() {
        show = false;
      });
      print(newUser);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: show,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 200,
                  ),
                ),
              ),
              SizedBox(height: 48),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(height: 8),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                ),
              ),
              SizedBox(height: 24),
              ReusableButton(
                Colors.lightBlue,
                'Register',
                () {
                  register();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
