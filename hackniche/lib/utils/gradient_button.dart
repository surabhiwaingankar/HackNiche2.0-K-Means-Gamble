import 'package:flutter/material.dart';
import 'package:hackniche/global/globalvariables.dart';

class RaisedGradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final VoidCallback onPressed;
  final Color borderColor;

  const RaisedGradientButton(
      {Key? key,
      required this.child,
      required this.gradient,
      this.width = double.infinity,
      this.height = 50.0,
      required this.onPressed,
      this.borderColor = Colors.transparent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(15),
          gradient: gradient,
          boxShadow: const [
            BoxShadow(
              color: Colors.transparent,
              offset: Offset(0.0, 1.5),
              blurRadius: 1.5,
            ),
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}
