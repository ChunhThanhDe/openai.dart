import 'dart:io';

import '../../../../../dart_openai_plus.dart';

abstract class VariationInterface {
  Future<OpenAIImageModel> variation({
    required File image,
    int? n,
    OpenAIImageSize? size,
    OpenAIImageResponseFormat? responseFormat,
    String? user,
  });
}
