import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chat_firebase/chat/send_message.dart';
class BuildInput extends StatefulWidget {
  String groupChatId ;
  String listMessage ;
  File imageFile ;
  bool isLoading ;
  String imageUrl ;
  String id ;
  String peerId ;
  FocusNode focusNode = new FocusNode();
  bool isShowSticker ;
  BuildInput({Key key,@required this.groupChatId,@required this.listMessage,@required this.imageFile,@required this.focusNode,@required this.isShowSticker,
                      @required this.isLoading,@required this.imageUrl,@required this.id ,@required this. peerId})
  : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _BuildInputState();
  }
}

class _BuildInputState extends State<BuildInput> {
  SendMessage sendMess = SendMessage();
  final TextEditingController textEditingController =
      new TextEditingController();
  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        widget.imageFile = image;
        widget.isLoading = true;
      });
    }
    uploadFile();
  }
    Future uploadFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    reference.putFile(widget.imageFile);
    reference.getDownloadURL().then((dynamic value) {
      widget.imageUrl = value.toString();
      setState(() {
        widget.isLoading = false;
      });

    sendMess.onSendMessage(widget.imageUrl, 1 ,widget.id,widget.peerId,widget.groupChatId);
    });
  }
  void getSticker() {
    // Hide keyboard when sticker appear
    widget.focusNode.unfocus();
    setState(() {
      widget.isShowSticker = !widget.isShowSticker;
    });
  }
  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 1.0),
              child: new IconButton(
                icon: new Icon(Icons.image),
                onPressed: getImage,
              ),
            ),
          ),
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 1.0),
              child: new IconButton(
                icon: new Icon(Icons.face),
                onPressed: getSticker,
              ),
            ),
          ),
          Flexible(
            child: Container(
              child: TextField(
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                ),
                focusNode: widget.focusNode,
              ),
            ),
          ),
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 8.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () {
                  sendMess.onSendMessage(textEditingController.text, 0,widget.id,widget.peerId,widget.groupChatId);
                } 
              ),
            ),
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: new BoxDecoration(
          border: new Border(top: new BorderSide(width: 0.5))),
    );
  }


  @override
  Widget build(BuildContext context) {
    return buildInput () ;
  }
}