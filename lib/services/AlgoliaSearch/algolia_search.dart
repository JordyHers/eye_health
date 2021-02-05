import 'package:algolia/algolia.dart';

class AlgoliaApplication{
  static final Algolia algolia = Algolia.init(
    applicationId: 'FO2RGMNVSH', //ApplicationID
    apiKey: '5049b0fea8f0b0425341f49ed7d4a870', //search-only api key in flutter code
  );
}