import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/provider/font/font_size_provider.dart';

class FontFamilyDropDown extends StatefulWidget {
  const FontFamilyDropDown({
    super.key,
  });

  @override
  State<FontFamilyDropDown> createState() => _FontFamilyDropDownState();
}

class _FontFamilyDropDownState extends State<FontFamilyDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: Provider.of<FontSizeProvider>(context, listen: false)
          .arabicFontFamily,
      items: const <String>['uthmani', 'imlaei']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? value) {
        setState(() {
          Provider.of<FontSizeProvider>(context, listen: false)
              .arabicFontFamily = value!;
        });
      },
    );
  }
}
