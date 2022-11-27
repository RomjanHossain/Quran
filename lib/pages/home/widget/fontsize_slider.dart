import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:quran/services/provider/font/font_size_provider.dart";

/// A drop down menu to change the font size.
class FontSizeSlider extends StatefulWidget {
  /// constractor
  const FontSizeSlider({
    super.key,
  });

  @override
  State<FontSizeSlider> createState() => _FontSizeSliderState();
}

class _FontSizeSliderState extends State<FontSizeSlider> {
  @override
  Widget build(BuildContext context) => Slider(
        value: Provider.of<FontSizeProvider>(context, listen: false).fontSize,
        min: 10,
        max: 100,
        divisions: 50,
        label: Provider.of<FontSizeProvider>(context, listen: false)
            .fontSize
            .round()
            .toString(),
        onChanged: (double value) {
          setState(() {
            Provider.of<FontSizeProvider>(context, listen: false).fontSize =
                value;
          });
          // });
        },
      );
}
