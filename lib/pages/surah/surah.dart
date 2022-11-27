import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import 'package:quran/pages/surah/widget/surah_aya_list.dart';

import '../../model/from_web/real_model.dart';
import '../../model/surah_model/surah_model.dart';
import '../../services/provider/font/font_size_provider.dart';
import '../../services/provider/play/play_provider.dart';
import '../../services/provider/translate/trans_provider.dart';
import '../../services/theme/theme_.dart';
import '../../widgets/const.dart';
import '../home/widget/right_drawer.dart';
import 'widget/ayanumber.dart';
import 'widget/is_sujud.dart';
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
        title: Text(surah.nameEn),
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
          return ListView(
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
                      image: const NetworkImage(
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
                      .map((dynamic e) =>
                          RealSurahModel.fromJson(e as Map<String, dynamic>))
                      .toList(),
                )
              else
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          );
        },
      ),
      //! bottom playing bar
      bottomNavigationBar: BottomAppBar(
        // color: Colors.green,
        // surfaceTintColor: Colors.blue,
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.all(10),

        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
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
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          final String currentSheikh =
                              context.read<PlayProvider>().playName;
                          final int i = sheikhNameList.indexWhere(
                              (String element) => element == currentSheikh);
                          // change the recitation sheikh to previous
                          if (i != 0) {
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
    );
  }
}
