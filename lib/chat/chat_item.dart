import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chat_firebase/chat/buid_input.dart';
import 'package:chat_firebase/chat/chat.dart';
import 'package:chat_firebase/chat/list_Message.dart';

class ChatScreen extends StatefulWidget {
  final String peerId;
  final String peerAvatar;
  SendMessage sendMess = SendMessage();
  ChatScreen({Key key, @required this.peerId, @required this.peerAvatar})
      : super(key: key);

  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {

  String id;

  var listMessage;
  String groupChatId;
  SharedPreferences prefs;

  File imageFile;
  bool isLoading;
  bool isShowSticker;
  String imageUrl;

  final FocusNode focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(onFocusChange);
    groupChatId = '';
    isLoading = false;
    isShowSticker = false;
    imageUrl = '';
    readLocal();
  }
  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        isShowSticker = false;
      });
    }
  }
  readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';
    if (id.hashCode <= widget.peerId.hashCode) {
      groupChatId = '$id-$widget.peerId';
    } else {
      groupChatId = '$widget.peerId-$id';
    }

    setState(() {});
  }

  Future<bool> onBackPress() {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
      Navigator.pop(context);
    }

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              // List of messages
              ListMessage(
                groupChatId: groupChatId,
                listMessage: listMessage,
                id: id,
                peerAvatar: widget.peerAvatar,
              ),
              // Sticker
              // (isShowSticker
              //     ? BuildSticker(
              //         id: id, peerId: widget.peerId, groupChatId: groupChatId)
              //     : Container()),

              // Input content
              BuildInput(
                groupChatId: groupChatId,
                listMessage: listMessage,
                imageFile: imageFile,
                focusNode: focusNode,
                id: id,
                imageUrl: imageUrl,
                isLoading: isLoading,
                isShowSticker: isShowSticker,
                peerId: widget.peerId,
              ),
            ],
          ),

          // Loading
          BuildLoading(isLoading: isLoading)
        ],
      ),
      onWillPop: onBackPress,
    );
  }
}
