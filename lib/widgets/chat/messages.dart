import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  //const Messages({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocuments = chatSnapshot.data.docs;
        return ListView.builder(
          itemCount: chatDocuments.length,
          itemBuilder: (context, index) => Text(
            chatDocuments[index]['text'],
          ),
        );
      },
    );
  }
}
