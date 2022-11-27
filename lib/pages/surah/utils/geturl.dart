import "package:quran/services/json/quar_recitation.dart";

/// get the url of the recitation
String getTheUrlOfCurrentIndexAndSheikh(
  String sheikhName,
  int index,
) {
  final Iterable<MapEntry<String, Map<String, Object>>>
      checkNameInQuranRecitation = quarnRecitation.entries.where(
    (MapEntry<String, Map<String, Object>> element) =>
        element.value["sheikh_name_en"] == sheikhName,
  );
  // ignore: cast_nullable_to_non_nullable
  final Map<String, Object> getAllTheRecitation = checkNameInQuranRecitation
      .first.value["recitations"] as Map<String, Object>;
  final List<String> getAllTheSurah =
      // ignore: cast_nullable_to_non_nullable
      getAllTheRecitation["surahs"] as List<String>;
  final String surahUrl = getAllTheSurah[index];
  return surahUrl;
}
