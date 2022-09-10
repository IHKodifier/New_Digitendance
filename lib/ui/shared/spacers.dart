import 'package:flutter/material.dart';

class SpacerVertical extends StatelessWidget {
  const SpacerVertical( this.value, {Key? key,}) : super(key: key);
  final double value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: value,width: 150,);
  }
}


class SpacerHorizontal extends StatelessWidget {
  const SpacerHorizontal(
    this.value, {
    Key? key,
  }) : super(key: key);
  final double value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: value,
      width: 150,
    );
  }
}
