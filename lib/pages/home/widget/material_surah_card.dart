// ignore_for_file: lines_longer_than_80_chars

import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:quran/model/surah_model/surah_model.dart";
import "package:quran/pages/surah/surah.dart";
import "package:quran/services/provider/play/play_provider.dart";
import "package:quran/widgets/const.dart";

/// A card to show the surah name and the number of ayahs.
class MaterialSurahCard extends StatelessWidget {
  /// constractor
  const MaterialSurahCard({
    required this.index,
    required this.surah,
    super.key,
  });

  /// the index of the surah
  // ignore: diagnostic_describe_all_properties
  final int index;

  /// the surah
  // ignore: diagnostic_describe_all_properties
  final SurahModel surah;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () async {
          Provider.of<PlayProvider>(context, listen: false).setPlayIndex(index);
          // Navigator.push(context, MaterialPageRoute<dynamic>(
          //   builder: (BuildContext context) {
          //     return SurahRead(
          //       surah: surah,
          //       ind: index,
          //     );
          //   },
          // ));
          await Navigator.of(context).push<dynamic>(
            PageRouteBuilder<dynamic>(
              pageBuilder: (
                BuildContext context,
                Animation<double> animation,
                _,
              ) =>
                  SurahRead(
                surah: surah,
                ind: index,
              ),
              transitionsBuilder: (
                BuildContext context,
                Animation<double> animation,
                _,
                Widget child,
              ) =>
                  FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          );
        },
        child: Card(
          // color: Theme.of(context).colorScheme.surfaceVariant,
          margin: const EdgeInsets.all(10),
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(5),
          // ),
          child: Container(
            padding: const EdgeInsets.all(10),
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                //? Surah Number
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "${index + 1}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: fontColor(context),
                      ),
                    ),
                  ),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Hero(
                      tag: surah.nameEn,
                      child: Text(
                        surah.nameEn,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '${getType(surah.revelationType.replaceAll(' ', ''))}\t\t-\t\t',
                          style: const TextStyle(
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          surah.ayahs,
                          style: const TextStyle(
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                //? Surah Name ar
                Text(
                  surah.nameAr,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
