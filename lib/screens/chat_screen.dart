import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/components/messages_stream.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  static const String id = '/chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  FirebaseFirestore? _firestore;
  String text = '';
  var loggedInUser;

  void getCurrentUser() async {
    FirebaseApp _auth = await Firebase.initializeApp();
    try {
      final user = FirebaseAuth
          .instanceFor(app: _auth)
          .currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void sendMessage() async {
    await Firebase.initializeApp();
    _firestore = FirebaseFirestore.instance;
    await _firestore?.collection('messages').add({
      'text': text,
      'sender': loggedInUser.email
    });
  }

  void getMessages() async {
    await Firebase.initializeApp();
    _firestore = FirebaseFirestore.instance;
    //v1 to get data from db
    // var documents = await _firestore.collection('messages').get();
    // for(var document in documents.docs){
    //   print(document.data());
    // }

    //  v2
    var documents = _firestore?.collection('messages')
        .snapshots()
        .forEach((element) {
      element.docs.forEach((el) {
        print(el.data());
      });
    });
  }

  void initializeFirestore() async{
    await Firebase.initializeApp();
    _firestore = FirebaseFirestore.instance;
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
        actions: [
          IconButton(
            onPressed: () async {
              FirebaseApp _auth = await Firebase.initializeApp();
              final user = FirebaseAuth.instanceFor(app: _auth);
              user.signOut();
              Navigator.pop(context);
              // getMessages();
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        text = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      sendMessage();
                      messageTextController.clear();
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
