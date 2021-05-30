library apklis_web_api;

import 'package:apklis_web_api/apklis_api_result.dart';

abstract class ApklisWebApi {
  static const API_URL = 'https://api.apklis.cu';

  Future<ApklisApiResult> get(List<String> apps) {
    final uri = buildUri(apps);
    return getByUri(uri);
  }

  static Uri buildUri(List<String> apps) {
    final uri = Uri.https(
      'api.apklis.cu',
      'v2/application',
      {'package_name': apps},
    );
    return uri;
  }

  Future<ApklisApiResult> getByUri(Uri uri);
}
