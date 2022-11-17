import 'package:flutter/material.dart';
import 'package:quran/services/json/quar_recitation.dart';

class RecitationPopupBtn extends StatelessWidget {
  RecitationPopupBtn({
    super.key,
  });
  List<String> sheikh_name_list = quarn_recitation.entries
      .map((e) => e.value['sheikh_name_en'].toString())
      .toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: PopupMenuButton(
        icon: Icon(
          Icons.abc_rounded,
          color: Colors.black,
        ),
        itemBuilder: (context) {
          return sheikh_name_list
              .map((e) => PopupMenuItem(
                    child: Text(e),
                  ))
              .toList();
        },
      ),
    );
  }
}

// enum RecitationAuthorName {

// }
