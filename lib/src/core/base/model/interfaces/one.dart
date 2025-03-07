import 'package:dart_openai_plus/src/core/models/model/model.dart';

import 'package:http/http.dart' as http;

abstract class RetrieveInterface {
  Future<OpenAIModelModel> retrieve(
    String modelId, {
    http.Client? client,
  });
}
