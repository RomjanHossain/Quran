import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran/services/json/quar_recitation.dart';

import '../services/theme/theme_.dart';

///
Color kcolor2 = const Color(0xffe3fff3);

///
Color kshadowColor = const Color(0xffff8ac5);
String getType(String type) {
  if (type == '\u09ae\u09be\u0995\u09cd\u0995\u09c0\r\n') {
    // return 'مكية';
    return 'Makkah';
  } else {
    // return 'مدنية';
    return 'Medina';
  }
}

/// remove html tags from string
String removeAllHtmlTags(String htmlText) {
  final RegExp exp = RegExp(r'<[^>]*>', multiLine: true);

  return htmlText.replaceAll(exp, '');
}

Color fontColor(BuildContext context) {
  return Provider.of<ModelTheme>(context, listen: false).isDark
      ? Colors.white
      : Colors.black;
}

List<String> sheikhNameList = quarnRecitation.entries
    .map((MapEntry<String, Map<String, Object>> e) =>
        e.value['sheikh_name_en'].toString())
    .toList();
