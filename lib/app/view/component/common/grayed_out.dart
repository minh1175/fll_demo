import 'package:flutter/material.dart';

class GrayedOut extends StatelessWidget {
  final Widget? child;
  final bool? grayedOut;
  final double opacity;

  GrayedOut({Key? key, required this.child, required this.grayedOut, this.opacity=0.1});

  @override
  Widget build(BuildContext context) {
    return this.grayedOut!
        ? new Opacity(opacity: opacity, child: this.child!)
        : this.child!;
  }
}