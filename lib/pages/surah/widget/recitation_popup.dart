import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "package:quran/services/json/quar_recitation.dart";
import "package:quran/services/provider/play/play_provider.dart";
import "package:quran/widgets/const.dart";

/// recitaion popup
class RecitationPopupBtn extends StatefulWidget {
  /// constractor
  const RecitationPopupBtn({
    super.key,
  });

  @override
  State<RecitationPopupBtn> createState() => _RecitationPopupBtnState();
}

class _RecitationPopupBtnState extends State<RecitationPopupBtn> {
  /// default sheikh name
  // ignore: diagnostic_describe_all_properties
  String defaultName =
      quarnRecitation.entries.first.value["sheikh_name_en"].toString();

  @override
  Widget build(BuildContext context) => Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Consumer<PlayProvider>(
          builder: (
            BuildContext context,
            PlayProvider playProvider,
            Widget? child,
          ) =>
              PopupMenuButton<dynamic>(
            icon: playProvider.playName.isEmpty
                ? Image.asset(
                    "assets/images/$defaultName.jpg",
                    // alignment: Alignment.center,
                    fit: BoxFit.fitHeight,
                  )
                : Image.asset(
                    "assets/images/${playProvider.playName}.jpg",
                    // alignment: Alignment.center,
                    fit: BoxFit.fitHeight,
                  ),
            itemBuilder: (BuildContext context) => sheikhNameList
                .map(
                  (String e) => PopupMenuItem<dynamic>(
                    child: listTileSheikhItems(
                      e,
                      "assets/images/$e.jpg",
                      playProvider.playName == e,
                    ),
                    onTap: () async {
                      playProvider
                        // ignore: unawaited_futures
                        ..addPlayer(e)
                        // ignore: unawaited_futures
                        ..setPlayerUrl();
                      setState(() {
                        defaultName = e;
                      });
                    },
                  ),
                )
                .toList(),
          ),
        ),
      );
}

// enum RecitationAuthorName {

// }
/// list tile for sheikh
Widget listTileSheikhItems(
  String sheikhName,
  String sheikhImage,
  // ignore: avoid_positional_boolean_parameters
  bool isSelect,
) =>
    ListTile(
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
