import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';

import '../../model/from_web/real_model.dart';
import '../../model/surah_model/surah_model.dart';
import '../../services/theme/theme_.dart';
import '../../widgets/const.dart';
import '../home/widget/right_drawer.dart';
import 'widget/small_div.dart';

class SurahRead extends StatelessWidget {
  SurahRead({
    required this.surah,
    required this.ind,
    super.key,
  });

  final SurahModel surah;
  final int ind;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const MyRightDrawer(),
      appBar: AppBar(
        title: const Text('Surah'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Provider.of<ModelTheme>(context, listen: false).isDark
                  ? Icons.nightlight_round
                  : Icons.wb_sunny),
              onPressed: () {
                Provider.of<ModelTheme>(context, listen: false).isDark
                    ? Provider.of<ModelTheme>(context, listen: false).isDark =
                        false
                    : Provider.of<ModelTheme>(context, listen: false).isDark =
                        true;
              }),
          // button to open the drawer
          IconButton(
            onPressed: () {
              // Scaffold.of(context).openEndDrawer();
              _scaffoldKey.currentState!.openEndDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: FutureBuilder<String>(
        future: rootBundle.loadString('assets/surahs/quran_$ind.json'),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            final List<RealSurahModel> allAyahs =
                (jsonDecode(snapshot.data!) as List<dynamic>)
                    .map((dynamic e) =>
                        RealSurahModel.fromJson(e as Map<String, dynamic>))
                    .toList();
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: allAyahs.length,
              itemBuilder: (BuildContext context, int index) {
                final Translations translation =
                    allAyahs[index].translations![1];
                // print('lets print the texts -> ');

                if (index == 0) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: kcolor2,
                      borderRadius: BorderRadius.circular(10),
                      // boxShadow: const <BoxShadow>[
                      //   BoxShadow(
                      //     color: Colors.indigo,
                      //     blurRadius: 10,
                      //     offset: Offset(0, 0),
                      //   ),
                      // ],
                    ),
                    // height: 100,
                    // color: Colors.red,
                    child: Column(
                      children: <Widget>[
                        // name
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
                        // name meaning
                        Text(
                          surah.nameMeaningEn,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SmallDivider(),
                        // row [type of surah, number of ayahs]
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
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
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        allAyahs[index].textUthmani.toString(),
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      RichText(
                          text: TextSpan(children: <TextSpan>[
                        TextSpan(
                          text: translation.text != null
                              ? removeAllHtmlTags(translation.text!)
                              : '',
                          style: const TextStyle(
                            fontSize: 20, color: Colors.black,
                            // fontWeight: FontWeight.bold,
                            fontWeight: FontWeight.w400,
                            // color: Colors.black,
                            letterSpacing: 0.9,
                          ),
                        ),
                        TextSpan(
                          text: '\n\n\t- ${translation.resourceName}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 0.5,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ])),
                      // NumSharePlayBookMarkCard(
                      //   index: index,
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SmallDivider(),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
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
