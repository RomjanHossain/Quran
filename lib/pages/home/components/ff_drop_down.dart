import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "package:quran/services/provider/font/font_size_provider.dart";

/// A drop down menu to change the font size.
class FontFamilyDropDown extends StatefulWidget {
  /// constractor
  const FontFamilyDropDown({
    super.key,
  });

  @override
  State<FontFamilyDropDown> createState() => _FontFamilyDropDownState();
}

class _FontFamilyDropDownState extends State<FontFamilyDropDown> {
  // ignore: diagnostic_describe_all_properties
  final List<String> fontFamiles = <String>["uthmani", "imlaei"];

  @override
  Widget build(BuildContext context) => Consumer<FontSizeProvider>(
        builder: (
          BuildContext context,
          FontSizeProvider fontSizeProvider,
          Widget? child,
        ) =>
            DropdownButton<String>(
          value: fontSizeProvider.arabicFontFamily,
          // value: fontFamily,
          alignment: Alignment.centerRight,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          // isExpanded: true,
          underline: Container(
            // height: 2,
            color: Colors.transparent,
          ),
          // style: const TextStyle(color: Colors.black),
          items: fontFamiles
              .map<DropdownMenuItem<String>>(
                (String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ),
              )
              .toList(),
          onChanged: (String? value) {
            // setState(() {
            fontSizeProvider.arabicFontFamily = value!;
            // });
          },
        ),
      );
}
