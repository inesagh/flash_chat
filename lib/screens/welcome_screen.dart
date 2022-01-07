import 'package:flash_chat/components/reusable_button.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = '/';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  late Animation borderAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    borderAnimation = BorderRadiusTween(
            begin: BorderRadius.zero, end: BorderRadius.circular(40))
        .animate(controller);

    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60,
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText(
                      'Flash Chat',
                      textStyle: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                  isRepeatingAnimation: true,
                ),
              ],
            ),
            SizedBox(height: 48),
            ReusableButton(
              Colors.lightBlueAccent,
              'Log In',
              () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            ReusableButton(
              Colors.lightBlue,
              'Register',
              () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
