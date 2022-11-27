import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:quran/model/surah_model/surah_model.dart";
import "package:quran/pages/surah/surah.dart";
import "package:quran/services/provider/play/play_provider.dart";
import "package:quran/widgets/const.dart";

/// The surah card.
class SurahCard extends StatelessWidget {
  /// constractor
  const SurahCard({
    required this.index,
    required this.surah,
    super.key,
  });

  /// surah index
  // ignore: diagnostic_describe_all_properties
  final int index;

  /// surah model
  // ignore: diagnostic_describe_all_properties
  final SurahModel surah;
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () async {
          Provider.of<PlayProvider>(context, listen: false).setPlayIndex(index);
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
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            // color: kcolor2,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                // color: Colors.black,
                color: Color(0xff9059ff),
                offset: Offset(6, 6), // changes position of shadow
              )
            ],
            border: Border.all(
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              //? Surah Number
              Text(
                "${index + 1}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: fontColor(context),
                ),
              ),

              Column(
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
                        getType(surah.revelationType.replaceAll(" ", "")),
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
      );
}
