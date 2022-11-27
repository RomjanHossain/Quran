import "package:flutter/material.dart";

/// small divider
class SmallDivider extends StatelessWidget {
  /// constractor
  const SmallDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) => const Divider(
        color: Colors.black,
        height: 2,
        indent: 60,
        endIndent: 60,
      );
}
