
import 'package:flutter/material.dart';
import 'package:chat_firebase/chat/send_message.dart';
class BuildSticker extends StatefulWidget {
  String id ;
  String peerId ;
  String groupChatId ;
  BuildSticker({Key key, @required this.id, @required this.peerId,@required this.groupChatId})
  : super(key: key);
  SendMessage sendMess = SendMessage();
  @override
  State<StatefulWidget> createState() {
    return _BuildStickerState();
  }
}

class _BuildStickerState extends State<BuildSticker> {
  Widget buildSticker() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: () => widget.sendMess.onSendMessage('mimi1', 2,widget.id,widget.peerId,widget.groupChatId),
                child: new Image.asset(
                  'images/mimi1.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () => widget.sendMess.onSendMessage('mimi2', 2,widget.id,widget.peerId,widget.groupChatId),
                child: new Image.asset(
                  'images/mimi2.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () => widget.sendMess.onSendMessage('mimi3', 2,widget.id,widget.peerId,widget.groupChatId,),
                child: new Image.asset(
                  'images/mimi3.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ]
      // decoration: new BoxDecoration(
      //     border:
      //         new Border(top: new BorderSide(color: Colors.grey , width: 0.5)),
      //     color: Colors.white),
      // padding: EdgeInsets.all(5.0),
      // height: 180.0,
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildSticker () ;
  }
}