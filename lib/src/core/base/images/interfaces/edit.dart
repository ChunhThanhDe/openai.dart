import 'dart:io';

import '../base.dart';

abstract class EditInterface {
  Future<void> edit({
    required File image,
    File? mask,
    required String prompt,
    int? n,
    OpenAIImageSize? size,
    OpenAIResponseFormat? responseFormat,
    String? user,
  });
}
