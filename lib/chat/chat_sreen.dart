import 'package:flutter/material.dart';
import 'package:chat_firebase/chat/chat.dart';
class Chat extends StatefulWidget{
  String peerId;
  String peerAvatar;
  Chat({Key key, @required this.peerId, @required this.peerAvatar})
      : super(key : key);
  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return ChatState();
    }
}
class ChatState extends State<Chat>{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'CHAT',
        ),
        centerTitle: true,
      ),
      body: new ChatScreen(
        peerId: widget.peerId,
        peerAvatar: widget.peerAvatar,
      ),
    );
  }
}

