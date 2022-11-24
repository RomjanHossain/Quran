import 'dart:convert';
import 'dart:ui';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';

import '../../model/from_web/real_model.dart';
import '../../model/surah_model/surah_model.dart';
import '../../services/provider/font/font_size_provider.dart';
import '../../services/provider/play/play_provider.dart';
import '../../services/provider/translate/trans_provider.dart';
import '../../services/theme/theme_.dart';
import '../../widgets/const.dart';
import '../home/widget/right_drawer.dart';
import 'widget/recitation_popup.dart';
import 'widget/small_div.dart';
import 'widget/surah_playbutton.dart';

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
        title: Hero(
          tag: surah.nameEn,
          child: Text(surah.nameEn),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
              itemCount: allAyahs.length + 1,
              itemBuilder: (BuildContext context, int index) {
                // print('lets print the texts -> ');
                // print(translationLang.elementAt(index).text);
                if (index == 0) {
                  return Card(
                    // semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    // padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 20,
                    ),

                    // height: 100,
                    // color: Colors.red,
                    child: Container(
                      decoration: BoxDecoration(
                        // set an image with opacity
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://images.unsplash.com/photo-1596125160970-6f02eeba00d3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8cXVyYW58ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.5), BlendMode.dstATop),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20,
                      ),
                      child: Column(
                        children: <Widget>[
                          // name
                          Text(
                            surah.nameEn,
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          // name meaning
                          Text(
                            surah.nameMeaningEn,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SmallDivider(),
                          const SizedBox(
                            height: 10,
                          ),
                          // row [type of surah, number of ayahs]
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '${getType(surah.revelationType.replaceAll(' ', ''))} -  ',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              Text(
                                surah.ayahs,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  Iterable<Translations> _getTrans(int id) {
                    return allAyahs[index - 1].translations!.where(
                        (Translations element) => element.resourceId == id);
                  }

                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Consumer<FontSizeProvider>(
                            builder: (BuildContext context,
                                FontSizeProvider value, Widget? child) {
                              return Text(
                                value.arabicFontFamily == 'uthmani'
                                    ? allAyahs[index - 1].textUthmani.toString()
                                    : allAyahs[index - 1]
                                        .textImlaeiSimple
                                        .toString(),
                                style: TextStyle(
                                  fontSize: value.fontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.end,
                              );
                            },
                          ),
                          Consumer<TransValProvider>(
                            builder: (BuildContext context,
                                TransValProvider value, Widget? child) {
                              if (value.transList.isEmpty) {
                                return RichText(
                                  // textAlign: TextAlign.end,
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: _getTrans(131).first.text != null
                                            ? removeAllHtmlTags(
                                                _getTrans(131).first.text!)
                                            : '',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          // color: Colors.black,
                                          letterSpacing: 0.9,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '\n\n- ${_getTrans(131).first.resourceName}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontStyle: FontStyle.italic,
                                          letterSpacing: 0.5,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              //! return every widget form value.transList
                              return Column(
                                children: <Widget>[
                                  for (int i = 0;
                                      i < value.transList.length;
                                      i++)
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
                                          const TextSpan(text: '\n'),
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
                    ),
                  );
                }
                // futurebuilder which loads a local json file
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      //! bottom playing bar
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
              //! the bottom bar for playing
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  const RecitationPopupBtn(),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            final String currentSheikh =
                                context.read<PlayProvider>().playName;
                            final int i = sheikhNameList.indexWhere(
                                (String element) => element == currentSheikh);
                            // change the recitation sheikh to previous
                            if (i != 0) {
                              print('$i  $currentSheikh');
                              context
                                  .read<PlayProvider>()
                                  .addPlayer(sheikhNameList[i - 1]);
                              context.read<PlayProvider>().setPlayerUrl();
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CenterButtonWidget(
                            index: ind,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward_ios),
                          onPressed: () {
                            final String currentSheikh =
                                context.read<PlayProvider>().playName;
                            final int i = sheikhNameList.indexWhere(
                                (String element) => element == currentSheikh);
                            final int length = sheikhNameList.length;
                            // change the recitation sheikh to next
                            if (i != length - 1) {
                              print(' $length $i  $currentSheikh ');
                              context
                                  .read<PlayProvider>()
                                  .addPlayer(sheikhNameList[i + 1]);
                              context.read<PlayProvider>().setPlayerUrl();
                            }
                          },
                        ),
                      ],
                    ),
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

// class ProgressOfPlayer extends StatefulWidget {
//   const ProgressOfPlayer({
//     super.key,
//   });

//   @override
//   State<ProgressOfPlayer> createState() => _ProgressOfPlayerState();
// }

// class _ProgressOfPlayerState extends State<ProgressOfPlayer> {
//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<PlayProvider>(
//         builder: (BuildContext context, PlayProvider playprov, Widget? child) {
//       // the the playprov.player.position changes then call the setState

//       return StreamBuilder<Duration>(
//           stream: playprov.player.positionStream,
//           builder: (BuildContext context, AsyncSnapshot<Duration> snapshot) {
//             print(snapshot);

//             return ProgressBar(
//               progress: snapshot.data ?? Duration(milliseconds: 200),
//               total: playprov.player.duration ?? const Duration(seconds: 10),
//             );
//           });
//     });
//   }
// }
