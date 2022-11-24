import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/json/quar_recitation.dart';
import '../../../services/provider/play/play_provider.dart';
import '../../../widgets/const.dart';

/// recitaion popup
class RecitationPopupBtn extends StatefulWidget {
  const RecitationPopupBtn({
    super.key,
  });

  @override
  State<RecitationPopupBtn> createState() => _RecitationPopupBtnState();
}

class _RecitationPopupBtnState extends State<RecitationPopupBtn> {
  String defaultName =
      quarnRecitation.entries.first.value['sheikh_name_en'].toString();

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
      child: Consumer<PlayProvider>(builder:
          (BuildContext context, PlayProvider playProvider, Widget? child) {
        return PopupMenuButton<dynamic>(
          icon: playProvider.playName.isEmpty
              ? Image.asset(
                  'assets/images/$defaultName.jpg',
                  // alignment: Alignment.center,
                  fit: BoxFit.fitHeight,
                )
              : Image.asset(
                  'assets/images/${playProvider.playName}.jpg',
                  // alignment: Alignment.center,
                  fit: BoxFit.fitHeight,
                ),
          itemBuilder: (BuildContext context) {
            return sheikhNameList
                .map((String e) => PopupMenuItem<dynamic>(
                      child: listTileSheikhItems(e, 'assets/images/$e.jpg',
                          playProvider.playName == e),
                      onTap: () {
                        playProvider.addPlayer(e);
                        playProvider.setPlayerUrl();
                        setState(() {
                          defaultName = e;
                        });
                      },
                    ))
                .toList();
          },
        );
      }),
    );
  }
}

// enum RecitationAuthorName {

// }
/// list tile for sheikh
Widget listTileSheikhItems(
    String sheikhName, String sheikhImage, bool isSelect) {
  return ListTile(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    contentPadding: const EdgeInsets.all(5),
    selected: isSelect,
    leading: CircleAvatar(
      backgroundImage: AssetImage(sheikhImage),
    ),
    title: Text(sheikhName),
  );
}
