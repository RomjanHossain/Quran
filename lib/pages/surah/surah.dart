// ignore_for_file: lines_longer_than_80_chars, discarded_futures

import "dart:convert";
import "dart:ui";

import "package:flutter/material.dart";
import "package:flutter/services.dart" show rootBundle;
import "package:provider/provider.dart";
import "package:quran/model/from_web/real_model.dart";
import "package:quran/model/surah_model/surah_model.dart";
import "package:quran/pages/home/widget/right_drawer.dart";
import "package:quran/pages/surah/widget/recitation_popup.dart";
import "package:quran/pages/surah/widget/small_div.dart";
import "package:quran/pages/surah/widget/surah_aya_list.dart";
import "package:quran/pages/surah/widget/surah_playbutton.dart";
import "package:quran/services/provider/play/play_provider.dart";
import "package:quran/services/theme/theme_.dart";
import "package:quran/widgets/const.dart";

/// surah page
class SurahRead extends StatelessWidget {
  /// constractor
  SurahRead({
    required this.surah,
    required this.ind,
    super.key,
  });

  /// surah model
  // ignore: diagnostic_describe_all_properties
  final SurahModel surah;

  /// surah index
  // ignore: diagnostic_describe_all_properties
  final int ind;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        extendBody: true,
        endDrawer: const MyRightDrawer(),
        appBar: AppBar(
          title: Text(surah.nameEn),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Provider.of<ModelTheme>(context, listen: false).isDark
                    ? Icons.nightlight_round
                    : Icons.wb_sunny,
              ),
              onPressed: () {
                Provider.of<ModelTheme>(context, listen: false).isDark
                    ? Provider.of<ModelTheme>(context, listen: false).isDark =
                        false
                    : Provider.of<ModelTheme>(context, listen: false).isDark =
                        true;
              },
            ),
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
          future: rootBundle.loadString("assets/surahs/quran_$ind.json"),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) =>
              ListView(
            children: <Widget>[
              Card(
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
                      image: const AssetImage("assets/images/quran.jpg"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5),
                        BlendMode.dstATop,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  child: Column(
                    children: <Widget>[
                      // name
                      Hero(
                        tag: surah.nameEn,
                        child: Text(
                          surah.nameEn,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
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
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            surah.ayahs,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (snapshot.hasData)
                AyaListView(
                  allAyahs: (jsonDecode(snapshot.data!) as List<dynamic>)
                      .map(
                        // ignore: avoid_annotating_with_dynamic
                        (dynamic e) =>
                            RealSurahModel.fromJson(e as Map<String, dynamic>),
                      )
                      .toList(),
                )
              else
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
        //! bottom playing bar
        bottomNavigationBar: BottomAppBar(
          // color: Colors.green,
          // surfaceTintColor: Colors.blue,
          clipBehavior: Clip.antiAlias,
          padding: const EdgeInsets.all(10),

          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: DecoratedBox(
              // height: 80,
              // margin: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                // color: Colors.blue,
                color: Colors.transparent,
                // border radius only for top left and top right
                borderRadius: BorderRadius.only(
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
                        const PlayForwardButton(
                          isBack: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: CenterButtonWidget(
                            index: ind,
                          ),
                        ),
                        const PlayForwardButton(
                          isBack: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

/// play forward button
class PlayForwardButton extends StatelessWidget {
  /// consts
  const PlayForwardButton({
    required this.isBack,
    super.key,
  });

  /// is back button
  // ignore: diagnostic_describe_all_properties
  final bool isBack;

  @override
  Widget build(BuildContext context) => IconButton(
        icon: isBack
            ? const Icon(Icons.arrow_back_ios)
            : const Icon(Icons.arrow_forward_ios),
        onPressed: () {
          if (isBack) {
            final String currentSheikh = context.read<PlayProvider>().playName;
            final int currentSheikhIndex = sheikhNameList.indexWhere(
              (String element) => element == currentSheikh,
            );
            // change the recitation sheikh to previous
            if (currentSheikhIndex != 0) {
              context
                  .read<PlayProvider>()
                  .addPlayer(sheikhNameList[currentSheikhIndex - 1]);
              // ignore: use_build_context_synchronously
              context.read<PlayProvider>().setPlayerUrl();
            }
          } else {
            final String currentSheikh = context.read<PlayProvider>().playName;
            final int currentSheikhIndex = sheikhNameList.indexWhere(
              (String element) => element == currentSheikh,
            );
            final int length = sheikhNameList.length;
            // change the recitation sheikh to next
            if (currentSheikhIndex != length - 1) {
              context
                  .read<PlayProvider>()
                  .addPlayer(sheikhNameList[currentSheikhIndex + 1]);
              // ignore: use_build_context_synchronously
              context.read<PlayProvider>().setPlayerUrl();
            }
          }
        },
      );
}
