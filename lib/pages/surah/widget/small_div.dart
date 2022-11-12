import 'package:flutter/material.dart';

class SmallDivider extends StatelessWidget {
  const SmallDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Colors.black,
      height: 2,
      indent: 60,
      endIndent: 60,
    );
  }
}
