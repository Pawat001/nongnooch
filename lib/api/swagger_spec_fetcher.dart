import 'package:dio/dio.dart';

/// Lightweight helper to fetch an OpenAPI/Swagger JSON spec and return
/// the parsed Map. Useful to verify connectivity to the API spec URL
/// before running code generation.
class SwaggerSpecFetcher {
  final Dio _dio;

  SwaggerSpecFetcher([Dio? dio]) : _dio = dio ?? Dio();

  /// Fetches the OpenAPI JSON/YAML at [specUrl]. Returns decoded JSON as Map
  /// or throws an exception on failure.
  Future<Map<String, dynamic>> fetchSpec(String specUrl) async {
    try {
      final response = await _dio.get(specUrl);
      if (response.statusCode == 200) {
        final data = response.data;
        if (data is Map<String, dynamic>) return data;
        // If YAML/text returned, try to decode JSON string
        if (data is String) {
          // Try parse JSON string
          try {
            return Map<String, dynamic>.from(response.data != null ? response.data : {});
          } catch (_) {
            throw Exception('Spec returned as text but could not parse as JSON.');
          }
        }
        throw Exception('Unexpected spec format: ${data.runtimeType}');
      }
      throw Exception('Failed to fetch spec: ${response.statusCode}');
    } on DioException catch (e) {
      throw Exception('Dio error fetching spec: ${e.message}');
    }
  }
}
