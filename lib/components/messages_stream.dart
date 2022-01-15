import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';

import 'messages_bubbles.dart';

class MessagesStream extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').orderBy('messageTime')
            .snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return CircularProgressIndicator(color: Colors.lightBlueAccent,);
          }
          var messages = snapshot.data?.docs.reversed;
          List<MessageBubble> messagesList = [];
          for(var message in messages!){
            final messageText = message.get('text');
            final messageSender = message.get('sender');
            final messageBubble = MessageBubble(messageText, messageSender, loggedInUser.email == messageSender);
            messagesList.add(messageBubble);
          }
          print(messages);
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              children: messagesList,
            ),
          );
        });

  }
}
