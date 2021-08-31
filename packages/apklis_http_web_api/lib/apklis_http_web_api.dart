library apklis_http_web_api;

import 'dart:convert';

import 'package:apklis_web_api/apklis_api_result.dart';
import 'package:apklis_web_api/apklis_web_api.dart';
import 'package:apklis_web_api/models/models.dart';
import 'package:http/http.dart';

class ApklisHttpWebApi extends ApklisWebApi {
  ApklisHttpWebApi(this.httpClient);

  final BaseClient httpClient;

  @override
  Future<ApklisApiResult> getByUri(Uri uri) async {
    try {
      final response = await httpClient.get(uri);
      if (response.statusCode == 200) {
        var text = '';
        try {
          text = utf8.decode(response.bodyBytes);
        } on FormatException {
          text = response.body;
        }
        final json = jsonDecode(text) as Map<String, dynamic>;
        final model = ApklisModel.fromJson(json);
        return ApklisApiResult.success(model);
      } else {
        return ApklisApiResult.failure(response.reasonPhrase!);
      }
    } catch (e) {
      return ApklisApiResult.failure(e.toString());
    }
  }
}
