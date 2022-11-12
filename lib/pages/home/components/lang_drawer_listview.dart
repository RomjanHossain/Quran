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
          height: 50,
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Provider.of<TransValProvider>(context, listen: false)
                      .addTransList(transShit
                          .where((Map<String, Object> element) =>
                              element['languageId'] == languageAndCode[key2])
                          .elementAt(index)['resourceId']
                          .toString());
                  // print(
                  //   "${transShit.where((Map<String, Object> element) => element['languageId'] == languageAndCode[key2]).elementAt(index)['resourceId']}",
                  // );
                },
                child: Container(
                  // width: 100,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        // color: Colors.black,
                        ),
                  ),
                  child: Text(
                    "${transShit.where((Map<String, Object> element) => element['languageId'] == languageAndCode[key2]).elementAt(index)['resourceName']}",
                  ),
                ),
              );
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
