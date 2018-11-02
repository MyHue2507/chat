import 'package:flutter/material.dart';

class BuildLoading extends StatefulWidget {
  bool isLoading;
  BuildLoading({Key key, @required this.isLoading}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _BuildLoadingeState();
  }
}

class _BuildLoadingeState extends State<BuildLoading> {
  Widget buildLoading() {
    return Positioned(
      child: widget.isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
              color: Colors.grey,
            )
          : Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildLoading();
  }
}
