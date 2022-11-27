// ignore_for_file: lines_longer_than_80_chars

import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "package:quran/model/translations/lan_and_code.dart";
import "package:quran/model/translations/translations.dart";
import "package:quran/services/provider/translate/trans_provider.dart";

/// The language drawer list view.
class TransListInDrawer extends StatelessWidget {
  /// constractor
  const TransListInDrawer({
    required this.key2,
    super.key,
  });

  /// key
  // ignore: diagnostic_describe_all_properties
  final String key2;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            key2,
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.left,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 80,
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) =>
                  Consumer<TransValProvider>(
                builder: (
                  BuildContext context,
                  TransValProvider value,
                  Widget? child,
                ) =>
                    Padding(
                  padding: const EdgeInsets.all(8),
                  child: ChoiceChip(
                    label: Text(
                      "${transShit.where((Map<String, Object> element) => element['languageId'] == languageAndCode[key2]).elementAt(index)['resourceName']}",
                    ),
                    selected: value.transList.contains(
                      transShit
                          .where(
                            (Map<String, Object> element) =>
                                element["languageId"] == languageAndCode[key2],
                          )
                          .elementAt(index)["resourceId"]
                          .toString(),
                    ),
                    onSelected: (bool selected) async {
                      if (value.transList.contains(
                        transShit
                            .where(
                              (Map<String, Object> element) =>
                                  element["languageId"] ==
                                  languageAndCode[key2],
                            )
                            .elementAt(index)["resourceId"]
                            .toString(),
                      )) {
                        await value.removeTransList(
                          transShit
                              .where(
                                (Map<String, Object> element) =>
                                    element["languageId"] ==
                                    languageAndCode[key2],
                              )
                              .elementAt(index)["resourceId"]
                              .toString(),
                        );
                      } else {
                        await value.addTransList(
                          transShit
                              .where(
                                (Map<String, Object> element) =>
                                    element["languageId"] ==
                                    languageAndCode[key2],
                              )
                              .elementAt(index)["resourceId"]
                              .toString(),
                        );
                      }
                    },
                  ),
                ),
              ),
              itemCount: transShit
                  .where(
                    (Map<String, Object> element) =>
                        element["languageId"] == languageAndCode[key2],
                  )
                  .length,
              // shrinkWrap: true,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      );
}
