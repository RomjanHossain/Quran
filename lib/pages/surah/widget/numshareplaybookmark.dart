import "package:flutter/material.dart";
import "package:quran/widgets/const.dart";

/// numshareplaybookmark
class NumSharePlayBookMarkCard extends StatelessWidget {
  /// constractor
  const NumSharePlayBookMarkCard({
    required this.index,
    super.key,
  });

  /// surah index
  // ignore: diagnostic_describe_all_properties
  final int index;

  @override
  Widget build(BuildContext context) => Container(
        height: 53,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(0.8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 35,
              // height: 35,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kcolor2,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                "${index + 1}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.play_arrow),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark)),
              ],
            ),
          ],
        ),
      );
}
