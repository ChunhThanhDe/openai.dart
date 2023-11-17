import 'package:dart_openai/src/core/constants/strings.dart';
import 'package:dart_openai/src/core/utils/logger.dart';
import 'package:meta/meta.dart';

/// {@template openai_config}
/// This class is responsible about general configs for the SDK such as the base url..
/// {@endtemplate}
@immutable
@internal
abstract class OpenAIConfig {
  static final defaultRequestsTimeOut = Duration(seconds: 30);

  /// {@template openai_config_requests_timeOut}
  /// The maximum duration a request can take, this will be applied to all requests, defaults to 30 seconds.
  /// if you need custom timeout for each method individulaly, consider using the `client` field in each method and pass a custom HTTP client to it.
  /// {@endtemplate}
  static Duration requestsTimeOut = defaultRequestsTimeOut;

  /// {@template openai_config_base_url}
  /// This is base API url for all the requests.
  /// {@endtemplate}
  static String? _baseUrl;

  // /// {@template openai_config_is_web}
  // /// This is a flag that indicates if the library is running on the web or not.
  // /// {@endtemplate}
  // static bool _isWeb = false;

  /// This is the version of the API.
  static String get version => OpenAIStrings.version;

  /// {@macro openai_config_base_url}
  @internal
  static String get baseUrl {
    return _baseUrl ?? OpenAIStrings.defaultBaseUrl;
  }

  // /// {@macro openai_config_is_web}
  // static bool get isWeb => _isWeb;

  @internal
  static set baseUrl(String? baseUrl) {
    _baseUrl = baseUrl;
    OpenAILogger.logBaseUrl(_baseUrl);
  }

  // @internal
  // static set isWeb(bool isWeb) {
  //   _isWeb = isWeb;
  //   OpenAILogger.logIsWeb(_isWeb);
  // }
}
