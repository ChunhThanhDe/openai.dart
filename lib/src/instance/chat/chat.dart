import 'package:dart_openai/src/core/builder/base_api_url.dart';
import 'package:dart_openai/src/core/networking/client.dart';

import '../../core/base/chat/chat.dart';
import '../../core/constants/strings.dart';
import '../../core/models/chat/chat.dart';
import '../../core/models/tool/tool.dart';
import '../../core/utils/logger.dart';

import 'package:http/http.dart' as http;

/// {@template openai_chat}
/// This class is responsible for handling all chat requests, such as creating a chat completion for the message(s).
/// {@endtemplate}
interface class OpenAIChat implements OpenAIChatBase {
  @override
  String get endpoint => OpenAIStrings.endpoints.chat;

  /// {@macro openai_chat}
  OpenAIChat() {
    OpenAILogger.logEndpoint(endpoint);
  }

  /// Creates a chat completion for the message(s).
  ///
  /// [model] is the ID of the model to use.
  ///
  ///
  /// [messages] is the list of messages to complete from, note you need to set each message as a [OpenAIChatCompletionChoiceMessageModel] object.
  ///
  ///
  /// What sampling [temperature] to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic.
  ///
  ///
  /// [topP] is an alternative to sampling with [temperature], called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered.
  ///
  ///
  /// [n] represents how much chat completion choices to generate for each input message.
  ///
  ///
  ///  [stop] can be either a `List<String>` or a `String` and represents words up to 4 sequences where the API will stop generating further tokens.
  ///
  ///
  /// [maxTokens] is the maximum number of tokens allowed for the generated answer. By default, the number of tokens the model can return will be (4096 - prompt tokens).
  ///
  /// [presencePenalty] is a number between -2.0 and 2.0. Positive values penalize new tokens based on whether they appear in the text so far, increasing the model's likelihood to talk about new topics.
  ///
  ///
  /// [frequencyPenalty] is a Number between -2.0 and 2.0. Positive values penalize new tokens based on their existing frequency in the text so far, decreasing the model's likelihood to repeat the same line verbatim.
  ///
  ///
  /// [logitBias]Modify the likelihood of specified tokens appearing in the completion.
  /// Accepts a json object that maps tokens (specified by their token ID in the tokenizer) to an associated bias value from -100 to 100. Mathematically, the bias is added to the logits generated by the model prior to sampling. The exact effect will vary per model, but values between -1 and 1 should decrease or increase likelihood of selection; values like -100 or 100 should result in a ban or exclusive selection of the relevant token.
  ///
  ///
  /// [user] is a unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse.
  ///
  /// Returns a [OpenAIChatCompletionModel] object.
  ///
  /// Example:
  /// ```dart
  /// final chatCompletion = await OpenAI.instance.chat.create(
  /// model: "gpt-3.5-turbo",
  /// messages: [
  ///   OpenAIChatCompletionChoiceMessageModel(content: "hello, what is Flutter and Dart ?", role: "user")
  /// ]);
  /// ```
  @override
  Future<OpenAIChatCompletionModel> create({
    required String model,
    required List<OpenAIChatCompletionChoiceMessageModel> messages,
    List<OpenAIToolModel>? tools,
    toolChoice,
    double? temperature,
    double? topP,
    int? n,
    stop,
    int? maxTokens,
    double? presencePenalty,
    double? frequencyPenalty,
    Map<String, dynamic>? logitBias,
    String? user,
    Map<String, String>? responseFormat,
    int? seed,
    http.Client? client,
  }) async {
    return await OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.build(endpoint),
      body: {
        "model": model,
        "messages": messages.map((message) => message.toMap()).toList(),
        if (tools != null)
          "tools": tools.map((tool) => tool.toMap()).toList(growable: false),
        if (toolChoice != null) "tool_choice": toolChoice,
        if (temperature != null) "temperature": temperature,
        if (topP != null) "top_p": topP,
        if (n != null) "n": n,
        if (stop != null) "stop": stop,
        if (maxTokens != null) "max_tokens": maxTokens,
        if (presencePenalty != null) "presence_penalty": presencePenalty,
        if (frequencyPenalty != null) "frequency_penalty": frequencyPenalty,
        if (logitBias != null) "logit_bias": logitBias,
        if (user != null) "user": user,
        if (seed != null) "seed": seed,
        if (responseFormat != null) "response_format": responseFormat,
      },
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIChatCompletionModel.fromMap(response);
      },
      client: client,
    );
  }

  /// Creates a stream chat completion for the message(s)
  ///
  /// [model] is the ID of the model to use.
  ///
  ///
  /// [messages] is the list of messages to complete from, note you need to set each message as a [OpenAIChatCompletionChoiceMessageModel] object.
  ///
  ///
  /// What sampling [temperature] to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic.
  ///
  ///
  /// [topP] is an alternative to sampling with [temperature], called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered.
  ///
  ///
  /// [n] represents how much chat completion choices to generate for each input message.
  ///
  ///
  ///  [stop] can be either a `List<String>` or a `String` and represents words up to 4 sequences where the API will stop generating further tokens.
  ///
  ///
  /// [maxTokens] is the maximum number of tokens allowed for the generated answer. By default, the number of tokens the model can return will be (4096 - prompt tokens).
  ///
  /// [presencePenalty] is a number between -2.0 and 2.0. Positive values penalize new tokens based on whether they appear in the text so far, increasing the model's likelihood to talk about new topics.
  ///
  ///
  /// [frequencyPenalty] is a Number between -2.0 and 2.0. Positive values penalize new tokens based on their existing frequency in the text so far, decreasing the model's likelihood to repeat the same line verbatim.
  ///
  ///
  /// [logitBias]Modify the likelihood of specified tokens appearing in the completion.
  /// Accepts a json object that maps tokens (specified by their token ID in the tokenizer) to an associated bias value from -100 to 100. Mathematically, the bias is added to the logits generated by the model prior to sampling. The exact effect will vary per model, but values between -1 and 1 should decrease or increase likelihood of selection; values like -100 or 100 should result in a ban or exclusive selection of the relevant token.
  ///
  ///
  /// [user] is a unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse.
  ///
  /// Example:
  /// ```dart
  /// final chatStream = OpenAI.instance.chat.createStream(
  /// model: "gpt-3.5-turbo",
  /// messages: [
  ///   OpenAIChatCompletionChoiceMessageModel(content: "hello, what is Flutter and Dart ?", role: "user")
  /// ]);
  ///
  /// chatStream.listen((chatCompletion) {
  ///  print(chatCompletion); // ...
  /// });
  /// ```

  @override
  Stream<OpenAIStreamChatCompletionModel> createStream({
    required String model,
    required List<OpenAIChatCompletionChoiceMessageModel> messages,
    List<OpenAIToolModel>? tools,
    toolChoice,
    double? temperature,
    double? topP,
    int? n,
    stop,
    int? maxTokens,
    double? presencePenalty,
    double? frequencyPenalty,
    Map<String, dynamic>? logitBias,
    Map<String, String>? responseFormat,
    int? seed,
    String? user,
    http.Client? client,
  }) {
    return OpenAINetworkingClient.postStream<OpenAIStreamChatCompletionModel>(
      to: BaseApiUrlBuilder.build(endpoint),
      body: {
        "model": model,
        "stream": true,
        "messages": messages.map((message) => message.toMap()).toList(),
        if (tools != null)
          "tools": tools.map((tool) => tool.toMap()).toList(growable: false),
        if (toolChoice != null) "tool_choice": toolChoice,
        if (temperature != null) "temperature": temperature,
        if (topP != null) "top_p": topP,
        if (n != null) "n": n,
        if (stop != null) "stop": stop,
        if (maxTokens != null) "max_tokens": maxTokens,
        if (presencePenalty != null) "presence_penalty": presencePenalty,
        if (frequencyPenalty != null) "frequency_penalty": frequencyPenalty,
        if (logitBias != null) "logit_bias": logitBias,
        if (user != null) "user": user,
        if (seed != null) "seed": seed,
        if (responseFormat != null) "response_format": responseFormat,
      },
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIStreamChatCompletionModel.fromMap(response);
      },
      client: client,
    );
  }

  @override
  Stream<OpenAIStreamChatCompletionModel> createRemoteFunctionStream({
    required String model,
    required List<OpenAIChatCompletionChoiceMessageModel> messages,
    List<OpenAIToolModel>? tools,
    toolChoice,
    double? temperature,
    double? topP,
    int? n,
    stop,
    int? maxTokens,
    double? presencePenalty,
    double? frequencyPenalty,
    Map<String, dynamic>? logitBias,
    String? user,
    http.Client? client,
    Map<String, String>? responseFormat,
    int? seed,
  }) {
    return OpenAINetworkingClient.postStream<OpenAIStreamChatCompletionModel>(
      to: BaseApiUrlBuilder.build(endpoint),
      body: {
        "model": model,
        "stream": true,
        "messages": messages.map((message) => message.toMap()).toList(),
        if (tools != null)
          "tools": tools.map((tool) => tool.toMap()).toList(growable: false),
        if (toolChoice != null) "tool_choice": toolChoice,
        if (temperature != null) "temperature": temperature,
        if (topP != null) "top_p": topP,
        if (n != null) "n": n,
        if (stop != null) "stop": stop,
        if (maxTokens != null) "max_tokens": maxTokens,
        if (presencePenalty != null) "presence_penalty": presencePenalty,
        if (frequencyPenalty != null) "frequency_penalty": frequencyPenalty,
        if (logitBias != null) "logit_bias": logitBias,
        if (user != null) "user": user,
        if (seed != null) "seed": seed,
        if (responseFormat != null) "response_format": responseFormat,
      },
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIStreamChatCompletionModel.fromMap(response);
      },
      client: client,
    );
  }
}
