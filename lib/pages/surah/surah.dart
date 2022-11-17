import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';

import '../../model/from_web/real_model.dart';
import '../../model/surah_model/surah_model.dart';
import '../../services/provider/font/font_size_provider.dart';
import '../../services/provider/translate/trans_provider.dart';
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
      extendBody: true,
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
                Iterable<Translations> _getTrans(int id) {
                  return allAyahs[index].translations!.where(
                      (Translations element) => element.resourceId == id);
                }

                // print('lets print the texts -> ');
                // print(translationLang.elementAt(index).text);
                if (index == 0) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      // color: kcolor2,
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
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Consumer<FontSizeProvider>(
                        builder: (BuildContext context, FontSizeProvider value,
                            Widget? child) {
                          return Text(
                            value.arabicFontFamily == 'uthmani'
                                ? allAyahs[index].textUthmani.toString()
                                : allAyahs[index].textImlaeiSimple.toString(),
                            style: TextStyle(
                              fontSize: value.fontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                      Consumer<TransValProvider>(
                        builder: (BuildContext context, TransValProvider value,
                            Widget? child) {
                          if (value.transList.isEmpty) {
                            return RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: _getTrans(131).first.text != null
                                        ? removeAllHtmlTags(
                                            _getTrans(131).first.text!)
                                        : '',
                                    style: const TextStyle(
                                      fontSize: 20, color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      // color: Colors.black,
                                      letterSpacing: 0.9,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '\n\n\t- ${_getTrans(131).first.resourceName}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic,
                                      letterSpacing: 0.5,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          // return every widget form value.transList
                          return Column(
                            children: <Widget>[
                              for (int i = 0; i < value.transList.length; i++)
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      // change font color based on the theme
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: _getTrans(int.parse(
                                                        value.transList[i]))
                                                    .first
                                                    .text !=
                                                null
                                            ? removeAllHtmlTags(_getTrans(
                                                    int.parse(
                                                        value.transList[i]))
                                                .first
                                                .text!)
                                            : '',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          // color: Colors.red,
                                        ),
                                      ),
                                      // a textspan for next line
                                      TextSpan(
                                        text:
                                            '\n\n\t- ${_getTrans(int.parse(value.transList[i])).first.resourceName}\n\n',
                                        style: const TextStyle(
                                          fontSize: 15,
                                          // color: Colors.black,
                                          fontStyle: FontStyle.italic,
                                          letterSpacing: 0.5,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          );
                          // return RichText(
                          //     text: TextSpan(children: <TextSpan>[
                          //   TextSpan(
                          //     text: translationLang.first.text != null
                          //         ? removeAllHtmlTags(
                          //             translationLang.first.text!)
                          //         : '',
                          //     style: const TextStyle(
                          //       fontSize: 20, color: Colors.black,
                          //       // fontWeight: FontWeight.bold,
                          //       fontWeight: FontWeight.w400,
                          //       // color: Colors.black,
                          //       letterSpacing: 0.9,
                          //     ),
                          //   ),
                          //   TextSpan(
                          //     text: '\n\n\t- ${translation.resourceName}',
                          //     style: const TextStyle(
                          //       fontSize: 16,
                          //       color: Colors.black,
                          //       fontStyle: FontStyle.italic,
                          //       letterSpacing: 0.5,
                          //       // fontWeight: FontWeight.bold,
                          //     ),
                          //   ),
                          // ]));
                        },
                      ),
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
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              height: 80,
              // margin: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                // color: Colors.blue,
                color: Colors.grey.shade200.withOpacity(
                    0.5), // border radius only for top left and top right
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton.large(onPressed: () {}),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
