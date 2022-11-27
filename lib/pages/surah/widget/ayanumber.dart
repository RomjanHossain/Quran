// allAyahs[index - 1].verseNumber.toString()

import 'package:flutter/material.dart';

// class AyaNumberWidget extends StatelessWidget {
//   const AyaNumberWidget({
//     super.key,
//     required this.ayaNumber,
//   });

//   final String ayaNumber;

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       top: 15,
//       left: 15,
//       child: Tooltip(
//         message: 'Aya Number',
//         child: Container(
//           height: 60,
//           width: 60,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             // color: Theme.of(context).splashColor,
//             color: Theme.of(context).primaryColor,
//             borderRadius: BorderRadius.circular(50),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               ayaNumber,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Theme.of(context).brightness == Brightness.dark
//                     ? Colors.white
//                     : Colors.black,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class AyaNumberWidget extends StatefulWidget {
  const AyaNumberWidget({
    super.key,
    required this.ayaNumber,
    required this.rukuNumber,
    required this.juzNumber,
    required this.manzilNumber,
  });
  // aya number
  final String ayaNumber;
  // ruku number
  final String rukuNumber;
  // Any of the seven partitions of the Qur'an, which can be read in an entire day.
  final String manzilNumber;
  // Para
  final String juzNumber;

  @override
  State<AyaNumberWidget> createState() => _AyaNumberWidgetState();
}

class _AyaNumberWidgetState extends State<AyaNumberWidget>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  double _fontSize = 20;

  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 15,
      left: 15,
      child: GestureDetector(
        // message: 'Aya Number',
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: AnimatedContainer(
          height: _isExpanded ? 70 : 60,
          width: _isExpanded ? 250 : 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            // color: Theme.of(context).splashColor,
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(50),
          ),
          duration: const Duration(milliseconds: 500),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _isExpanded
                ? FutureBuilder<dynamic>(
                    future: Future<dynamic>.delayed(
                        const Duration(milliseconds: 350)),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  widget.ayaNumber,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: _fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text('Aya'),
                              ],
                            ),
                            const VerticalDivider(),
                            Column(
                              children: <Widget>[
                                Text(
                                  widget.rukuNumber,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: _fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text('Ruku'),
                              ],
                            ),
                            const VerticalDivider(),
                            Column(
                              children: <Widget>[
                                Text(
                                  widget.manzilNumber,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: _fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text('Manzil'),
                              ],
                            ),
                            const VerticalDivider(),
                            Column(
                              children: <Widget>[
                                Text(
                                  widget.juzNumber,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: _fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text('Juz'),
                              ],
                            ),
                          ],
                        );
                      }
                      return Text(
                        widget.ayaNumber,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    })
                : Text(
                    widget.ayaNumber,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
