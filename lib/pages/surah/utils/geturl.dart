import '../../../services/json/quar_recitation.dart';

String getTheUrlOfCurrentIndexAndSheikh(
  String sheikhName,
  int index,
) {
  final Iterable<MapEntry<String, Map<String, Object>>>
      checkNameInQuranRecitation = quarnRecitation.entries
          .where((MapEntry<String, Map<String, Object>> element) {
    return element.value['sheikh_name_en'] == sheikhName;
  });
  final Map<String, Object> getAllTheRecitation = checkNameInQuranRecitation
      .first.value['recitations'] as Map<String, Object>;
  final List<String> getAllTheSurah =
      getAllTheRecitation['surahs'] as List<String>;
  final String surahUrl = getAllTheSurah[index];
  return surahUrl;
}
