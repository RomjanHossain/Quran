import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/provider/font/font_size_provider.dart';

class FontSizeSlider extends StatefulWidget {
  const FontSizeSlider({
    super.key,
  });

  @override
  State<FontSizeSlider> createState() => _FontSizeSliderState();
}

class _FontSizeSliderState extends State<FontSizeSlider> {
  @override
  Widget build(BuildContext context) {
    return Slider(
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
        // Provider.of<FontSizeProvider>(context, listen: false).fontSize = value;
      },
    );
  }
}
