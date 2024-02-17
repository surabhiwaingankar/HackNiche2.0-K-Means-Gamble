import 'package:flutter/material.dart';
import 'package:hackniche/global/globalvariables.dart';
import 'package:hackniche/utils/gradient_button.dart';
import 'package:hackniche/utils/onhover.dart';

class NavButton extends StatelessWidget {
  final String child;
  final double height;
  final double width;
  final VoidCallback onPressed;
  const NavButton({
    super.key,
    required this.child,
    required this.height,
    required this.width,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OnHover(
      builder: (isHovered) {
        return SizedBox(
          height: height,
          width: width,
          child: RaisedGradientButton(
              gradient: isHovered
                  ? GlobalVariables.colorEnabled
                  : GlobalVariables.colorDisabled,
              onPressed: onPressed,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  child,
                  style: TextStyle(
                      color: isHovered ? Colors.black : Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              )),
        );
      },
    );
  }
}

class NavButtonInverted extends StatelessWidget {
  final String child;
  final double height;
  final double width;
  final VoidCallback onPressed;
  const NavButtonInverted({
    super.key,
    required this.child,
    required this.height,
    required this.width, required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OnHover(
      builder: (isHovered) {
        return SizedBox(
          height: height,
          width: width,
          child: RaisedGradientButton(
              borderColor: Color.fromRGBO(84, 255, 101, 1),
              gradient: isHovered
                  ? GlobalVariables.colorDisabled
                  : GlobalVariables.colorEnabled,
              onPressed: onPressed,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  child,
                  style: TextStyle(
                      color: isHovered ? Colors.white : Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              )),
        );
      },
    );
  }
}
