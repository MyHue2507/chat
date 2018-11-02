import 'package:chat_firebase/chat/build_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class ListMessage extends StatefulWidget {
  String groupChatId;
  var listMessage;
  String id;
  String peerAvatar;
  ListMessage(
      {Key key,
      @required this.groupChatId,
      @required this.listMessage,
      this.id,
      this.peerAvatar})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ListMessageState();
  }
}

class _ListMessageState extends State<ListMessage> {
  final ScrollController listScrollController = new ScrollController();
  Widget buildListMessage() {
    return Flexible(
      child: widget.groupChatId == ''
          ? Center(child: CircularProgressIndicator())
          : StreamBuilder(
              stream: Firestore.instance
                  .collection('messages')
                  .document(widget.groupChatId)
                  .collection(widget.groupChatId)
                  .orderBy('timestamp', descending: true)
                  .limit(20)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  widget.listMessage = snapshot.data.documents;
                  return ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (context, index) => BuildMessItem(
                        id: widget.id,
                        peerAvatar: widget.peerAvatar,
                        index: index,
                        document: snapshot.data.documents[index]),
                    itemCount: snapshot.data.documents.length,
                    reverse: true,
                    controller: listScrollController,
                  );
                }
              },
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildListMessage();
  }
}
