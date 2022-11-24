import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import '../model/details/surah.dart';
import '../model/surah_model/surah_model.dart';

import '../widgets/cardlistanimation.dart';
import 'home/widget/material_surah_card.dart';

class SurahListView extends StatefulWidget {
  const SurahListView({super.key});

  @override
  State<SurahListView> createState() => _SurahListViewState();
}

class _SurahListViewState extends State<SurahListView> {
  final ValueNotifier<ScrollDirection> scrollDirectionNotifier =
      ValueNotifier<ScrollDirection>(ScrollDirection.forward);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<UserScrollNotification>(
      onNotification: (UserScrollNotification notification) {
        if (notification.direction == ScrollDirection.forward ||
            notification.direction == ScrollDirection.reverse) {
          scrollDirectionNotifier.value = notification.direction;
        }
        return true;
      },
      child: ListView.builder(
        itemCount: surahs.length,
        itemBuilder: (BuildContext context, int index) {
          // Map<String, String>? surah = surahs["${index + 1}"];
          final SurahModel surah = SurahModel.fromJson(surahs['${index + 1}']!);

          return ValueListenableBuilder<ScrollDirection>(
            valueListenable: scrollDirectionNotifier,
            builder: (
              BuildContext context,
              ScrollDirection scrollDirection,
              Widget? child,
            ) =>
                CardListItemWrapper(
              scrollDirection: scrollDirection,
              child: child!,
            ),
            // child: SurahCard(
            //   index: index,
            //   surah: surah,
            // ),
            child: MaterialSurahCard(index: index, surah: surah),
          );
        },
      ),
    );
  }
}
