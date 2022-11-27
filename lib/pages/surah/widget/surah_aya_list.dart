// ignore_for_file: lines_longer_than_80_chars

import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:quran/model/from_web/real_model.dart";
import "package:quran/pages/surah/widget/ayanumber.dart";
import "package:quran/pages/surah/widget/is_sujud.dart";
import "package:quran/pages/surah/widget/small_div.dart";
import "package:quran/services/provider/font/font_size_provider.dart";
import "package:quran/services/provider/translate/trans_provider.dart";
import "package:quran/widgets/const.dart";

/// ayah list
class AyaListView extends StatelessWidget {
  /// constractor
  const AyaListView({
    required this.allAyahs,
    super.key,
  });

  /// all ayahs
  // ignore: diagnostic_describe_all_properties
  final List<RealSurahModel> allAyahs;

  @override
  Widget build(BuildContext context) => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: allAyahs.length + 1,
        itemBuilder: (BuildContext context, int index) {
          // ignore: no_leading_underscores_for_local_identifiers
          Iterable<Translations> _getTrans(int id) => allAyahs[index - 1]
              .translations!
              .where((Translations element) => element.resourceId == id);

          if (index == 0) {
            return const SizedBox.shrink();
          }

          return Stack(
            children: <Widget>[
              Card(
                margin: const EdgeInsets.all(10),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: allAyahs[index - 1].sajdahNumber != null
                          ? Colors.grey
                          : Colors.transparent,
                      width: allAyahs[index - 1].sajdahNumber != null ? 2 : 0,
                    ),
                    color: allAyahs[index - 1].sajdahNumber != null
                        ? Theme.of(context).cardColor
                        : Colors.transparent,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      const SizedBox(
                        height: 50,
                      ),
                      Consumer<FontSizeProvider>(
                        builder: (
                          BuildContext context,
                          FontSizeProvider value,
                          Widget? child,
                        ) =>
                            Text(
                          value.arabicFontFamily == "uthmani"
                              ? allAyahs[index - 1].textUthmani.toString()
                              : allAyahs[index - 1].textImlaeiSimple.toString(),
                          style: TextStyle(
                            fontSize: value.fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      Consumer<TransValProvider>(
                        builder: (
                          BuildContext context,
                          TransValProvider value,
                          Widget? child,
                        ) {
                          if (value.transList.isEmpty) {
                            return RichText(
                              // textAlign: TextAlign.end,
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: _getTrans(131).first.text != null
                                        ? removeAllHtmlTags(
                                            _getTrans(131).first.text!,
                                          )
                                        : "",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      // color: Colors.black,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                      letterSpacing: 0.9,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        "\n\n- ${_getTrans(131).first.resourceName}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                      letterSpacing: 0.5,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
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
                                      const TextSpan(text: "\n"),
                                      TextSpan(
                                        text: _getTrans(
                                                  int.parse(
                                                    value.transList[i],
                                                  ),
                                                ).first.text !=
                                                null
                                            ? removeAllHtmlTags(
                                                _getTrans(
                                                  int.parse(
                                                    value.transList[i],
                                                  ),
                                                ).first.text!,
                                              )
                                            : "",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          // color: Colors.red,
                                        ),
                                      ),
                                      // a textspan for next line
                                      TextSpan(
                                        text:
                                            "\n\n\t- ${_getTrans(int.parse(value.transList[i])).first.resourceName}\n\n",
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
              ),

              // top left circularavater for surah number
              AyaNumberWidget(
                ayaNumber: allAyahs[index - 1].verseNumber.toString(),
                juzNumber: allAyahs[index - 1].juzNumber.toString(),
                rukuNumber: allAyahs[index - 1].rukuNumber.toString(),
                manzilNumber: allAyahs[index - 1].manzilNumber.toString(),
              ),
              if (allAyahs[index - 1].sajdahNumber != null)
                const SujudNumberWidget()
            ],
          );
        },
      );
}
