import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingBuilder extends StatefulWidget {
  final Widget? child;
  LoadingBuilder({this.child});

  @override
  State<StatefulWidget> createState() => _LoadingBuilderState();
}

class _LoadingBuilderState extends State<LoadingBuilder> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: widget.child ?? CircularProgressIndicator(),
    );
  }
}