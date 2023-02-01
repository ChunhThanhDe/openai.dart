import 'package:openai/src/core/builder/base_api_url.dart';
import 'package:openai/src/core/models/embedding.dart';

import '../../core/base/embeddings/base.dart';
import '../../core/networking/client.dart';
import '../../core/utils/logger.dart';

class OpenAIEmbedding implements OpenAIEmbeddingBase {
  @override
  String get endpoint => "/embeddings";

  /// This function creates an embeddings based on a model and input
  /// Example:
  ///```dart
  /// OpenAIEmbeddingsModel embeddings = await OpenAI.instance.embedding.create(
  ///  model: "test-embedding-ada-002",
  ///  input: "This is a text input just to test",
  /// );
  ///```
  @override
  Future<OpenAIEmbeddingsModel> create({
    required String model,
    required dynamic input,
    String? user,
  }) async {
    assert(
      input is String || input is List<String>,
      "The input field should be a String, or a List<String>",
    );

    return await OpenAINetworkingClient.post<OpenAIEmbeddingsModel>(
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIEmbeddingsModel.fromMap(response);
      },
      to: BaseApiUrlBuilder.build(endpoint),
      body: {
        "model": model,
        if (input != null) "input": input,
        if (user != null) "user": user,
      },
    );
  }

  OpenAIEmbedding() {
    OpenAILogger.logEndpoint(endpoint);
  }
}
