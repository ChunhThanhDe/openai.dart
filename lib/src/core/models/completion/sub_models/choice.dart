class OpenAICompletionModelChoice {
  /// The text generated by the completion.
  String text;

  /// The index of the choice.
  int index;

  /// The log probabilities of the tokens in the completion.
  int? logprobs;

  /// The reason the completion finished.
  String? finishReason;

  /// This class is used to represent a choice generated by an OpenAI completion.
  OpenAICompletionModelChoice({
    required this.text,
    required this.index,
    required this.logprobs,
    required this.finishReason,
  });

  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAICompletionModelChoice] object.
  factory OpenAICompletionModelChoice.fromJson(Map<String, dynamic> json) {
    return OpenAICompletionModelChoice(
      text: json['text'],
      index: json['index'],
      logprobs: json['logprobs'],
      finishReason: json['finishReason'],
    );
  }

  @override
  bool operator ==(covariant OpenAICompletionModelChoice other) {
    if (identical(this, other)) return true;

    return other.text == text &&
        other.index == index &&
        other.logprobs == logprobs &&
        other.finishReason == finishReason;
  }

  @override
  int get hashCode {
    return text.hashCode ^
        index.hashCode ^
        logprobs.hashCode ^
        finishReason.hashCode;
  }

  @override
  String toString() {
    return 'OpenAICompletionModelChoice(text: $text, index: $index, logprobs: $logprobs, finishReason: $finishReason)';
  }
}
