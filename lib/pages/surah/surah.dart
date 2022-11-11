import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quran/model/details/surah_detail.dart';
import 'package:quran/model/from_web/real_model.dart';
import 'package:quran/model/surah_model/surah_model.dart';
import 'package:quran/widgets/const.dart';
import 'dart:convert';
import 'package:flutter/services.dart'
    show Clipboard, ClipboardData, rootBundle;

class SurahRead extends StatelessWidget {
  const SurahRead({
    required this.surah,
    required this.ind,
    super.key,
  });

  final SurahModel surah;
  final int ind;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Surah'),
      ),
      body: FutureBuilder(
        future: rootBundle.loadString('assets/surahs/quran_$ind.json'),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            List<RealSurahModel> allAyahs =
                (jsonDecode(snapshot.data!) as List<dynamic>)
                    .map((e) => RealSurahModel.fromJson(e))
                    .toList();
            return ListView.builder(
              itemCount: allAyahs.length,
              itemBuilder: (BuildContext context, int index) {
                Translations translation = allAyahs[index].translations![0];
                // print('lets print the texts -> ');

                if (index == 0) {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    // height: 100,
                    color: Colors.red,
                    child: Column(
                      children: [
                        // name
                        Text(
                          surah.nameEn,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // name meaning
                        Text(
                          surah.nameMeaningEn,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          height: 2,
                          indent: 60,
                          endIndent: 60,
                        ),
                        // row [type of surah, number of ayahs]
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              getType(surah.revelationType.replaceAll(' ', '')),
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
                        // bismillah
                        Text(
                          allAyahs[index].textUthmani.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  );
                }
                return Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      allAyahs[index].textUthmani.toString(),
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Text(
                    //   allAyahs[index].translations?[index].text.toString() ??
                    //       '',
                    //   textAlign: TextAlign.left,
                    //   style: const TextStyle(
                    //     fontSize: 20,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: translation.text ?? '',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: ' - ${translation.resourceName}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ])),
                  ],
                );
                // futurebuilder which loads a local json file
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
