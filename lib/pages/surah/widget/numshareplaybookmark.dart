import 'package:flutter/material.dart';
import 'package:quran/widgets/const.dart';

class NumSharePlayBookMarkCard extends StatelessWidget {
  const NumSharePlayBookMarkCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.withOpacity(0.8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 35,
            // height: 35,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: kcolor2,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              '${index + 1}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Row(
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.play_arrow)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark)),
            ],
          ),
        ],
      ),
    );
  }
}
