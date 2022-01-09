import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'messages_bubbles.dart';

class MessagesStream extends StatelessWidget {
  FirebaseFirestore? _firestore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore?.collection('messages')
            .snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            print('aaaaa');
            return CircularProgressIndicator(color: Colors.lightBlueAccent,);
          }
          print('bbbbbb');
          var messages = snapshot.data?.docs;
          List<MessageBubble> messagesList = [];
          for(var message in messages!){
            final messageText = message.get('text');
            final messageSender = message.get('sender');
            final messageWidget = MessageBubble(messageText, messageSender);
            messagesList.add(messageWidget);
          }
          print(messages);
          return Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              children: messagesList,
            ),
          );
        });

  }
}
