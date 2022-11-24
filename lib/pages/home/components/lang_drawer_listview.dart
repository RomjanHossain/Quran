import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/translations/lan_and_code.dart';
import '../../../model/translations/translations.dart';
import '../../../services/provider/translate/trans_provider.dart';

class TransListInDrawer extends StatelessWidget {
  const TransListInDrawer({
    super.key,
    required this.key2,
  });

  final String key2;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            itemBuilder: (BuildContext context, int index) {
              return Consumer<TransValProvider>(builder: (BuildContext context,
                  TransValProvider value, Widget? child) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ChoiceChip(
                    label: Text(
                      "${transShit.where((Map<String, Object> element) => element['languageId'] == languageAndCode[key2]).elementAt(index)['resourceName']}",
                    ),
                    selected: value.transList.contains(transShit
                        .where((Map<String, Object> element) =>
                            element['languageId'] == languageAndCode[key2])
                        .elementAt(index)['resourceId']
                        .toString()),
                    onSelected: (bool selected) async {
                      if (value.transList.contains(transShit
                          .where((Map<String, Object> element) =>
                              element['languageId'] == languageAndCode[key2])
                          .elementAt(index)['resourceId']
                          .toString())) {
                        value.removeTransList(transShit
                            .where((Map<String, Object> element) =>
                                element['languageId'] == languageAndCode[key2])
                            .elementAt(index)['resourceId']
                            .toString());
                      } else {
                        value.addTransList(transShit
                            .where((Map<String, Object> element) =>
                                element['languageId'] == languageAndCode[key2])
                            .elementAt(index)['resourceId']
                            .toString());
                      }
                    },
                  ),
                );
                // return InkWell(
                //   onTap: () {
                //     if (value.transList.contains(transShit
                //         .where((Map<String, Object> element) =>
                //             element['languageId'] == languageAndCode[key2])
                //         .elementAt(index)['resourceId']
                //         .toString())) {
                //       value.removeTransList(transShit
                //           .where((Map<String, Object> element) =>
                //               element['languageId'] == languageAndCode[key2])
                //           .elementAt(index)['resourceId']
                //           .toString());
                //     } else {
                //       value.addTransList(transShit
                //           .where((Map<String, Object> element) =>
                //               element['languageId'] == languageAndCode[key2])
                //           .elementAt(index)['resourceId']
                //           .toString());
                //     }
                //   },
                //   child: AnimatedContainer(
                //     padding: const EdgeInsets.symmetric(horizontal: 5),
                //     margin: const EdgeInsets.symmetric(horizontal: 5),
                //     alignment: Alignment.center,
                //     decoration: BoxDecoration(
                //       color: value.transList.contains(transShit
                //               .where((Map<String, Object> element) =>
                //                   element['languageId'] ==
                //                   languageAndCode[key2])
                //               .elementAt(index)['resourceId']
                //               .toString())
                //           ? Colors.blue
                //           : Colors.transparent,
                //       borderRadius: BorderRadius.circular(5),
                //       border: Border.all(
                //           // color: Colors.black,
                //           ),
                //     ),
                //     duration: const Duration(milliseconds: 500),
                //     child: Text(
                //       "${transShit.where((Map<String, Object> element) => element['languageId'] == languageAndCode[key2]).elementAt(index)['resourceName']}",
                //     ),
                //   ),
                // );
              });
            },
            itemCount: transShit
                .where((Map<String, Object> element) =>
                    element['languageId'] == languageAndCode[key2])
                .length,
            // shrinkWrap: true,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ],
    );
  }
}
