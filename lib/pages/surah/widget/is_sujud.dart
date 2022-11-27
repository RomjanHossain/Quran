import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";

/// sujud number widget
class SujudNumberWidget extends StatelessWidget {
  /// constractor
  const SujudNumberWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Positioned(
        top: 18,
        right: 20,
        child: Tooltip(
          message: "Sujud Aya",
          child: CircleAvatar(
            // height: 60,
            // width: 60,
            // minRadius: 60,
            radius: 30,
            backgroundColor: Colors.transparent,
            // alignment: Alignment.center,
            // decoration: BoxDecoration(
            //   color: Theme.of(context).primaryColor,
            //   borderRadius: BorderRadius.circular(50),
            // ),
            child: SvgPicture.asset("assets/svgs/sujud.svg"),
          ),
        ),
      );
}
