import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/json/quar_recitation.dart';
import '../../../services/provider/play/play_provider.dart';

/// recitaion popup
class RecitationPopupBtn extends StatefulWidget {
  const RecitationPopupBtn({
    super.key,
  });

  @override
  State<RecitationPopupBtn> createState() => _RecitationPopupBtnState();
}

class _RecitationPopupBtnState extends State<RecitationPopupBtn> {
  List<String> sheikhNameList = quarnRecitation.entries
      .map((MapEntry<String, Map<String, Object>> e) =>
          e.value['sheikh_name_en'].toString())
      .toList();
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
      child: PopupMenuButton<dynamic>(
        icon: Provider.of<PlayProvider>(context, listen: false).playName.isEmpty
            ? Image.asset(
                'assets/images/$defaultName.jpg',
                // alignment: Alignment.center,
                fit: BoxFit.fitHeight,
              )
            : Image.asset(
                'assets/images/${Provider.of<PlayProvider>(context, listen: false).playName}.jpg',
                // alignment: Alignment.center,
                fit: BoxFit.fitHeight,
              ),
        itemBuilder: (BuildContext context) {
          return sheikhNameList
              .map((String e) => PopupMenuItem<dynamic>(
                    child: listTileSheikhItems(e, 'assets/images/$e.jpg'),
                    onTap: () {
                      Provider.of<PlayProvider>(context, listen: false)
                          .addPlayer(e);
                      Provider.of<PlayProvider>(context, listen: false)
                          .setPlayerUrl();

                      setState(() {
                        defaultName = e;
                      });
                    },
                  ))
              .toList();
        },
      ),
    );
  }
}

// enum RecitationAuthorName {

// }
/// list tile for sheikh
Widget listTileSheikhItems(String sheikhName, String sheikhImage) {
  return ListTile(
    leading: CircleAvatar(
      backgroundImage: AssetImage(sheikhImage),
    ),
    title: Text(sheikhName),
  );
}
