import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get();

    FirebaseFirestore.instance.collection("chat").add({
      "text": _controller.text,
      "createdAt": Timestamp.now(),
      'userId': user.uid,
      'username': userData['username'],
    });
    setState(() {
      _controller.clear();
    });
  }

  /*
  final picker = ImagePicker();
final pickedImage = await picker.getImage(...);
final pickedImageFile = File(pickedImage.path); // requires import 'dart:io';
  */

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: "Send a message..."),
              onChanged: (value) {
                setState(() {
                  _controller.text = value;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: const Icon(Icons.send),
            onPressed: _controller.text.trim().isEmpty ? null : _sendMessage,
          )
        ],
      ),
    );
  }
}
