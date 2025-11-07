# Nongnooch API (OpenAPI generated)

This folder will contain the Dart client generated from the backend's OpenAPI/Swagger spec.

## Generate (Windows PowerShell)

Ensure Docker Desktop is running, then run:

```
docker run --rm -v ${PWD}:/local openapitools/openapi-generator-cli generate -i "<SPEC_URL_OR_PATH>" -g dart-dio -o /local/lib/nongnooch_api
```

Replace `<SPEC_URL_OR_PATH>` with one of:
- A valid public spec URL (JSON/YAML), e.g. https://example.com/openapi.json
- A local file path mounted into the container, e.g. `/local/specs/api.yaml` (place `specs/api.yaml` at the repo root)

Note: The generator name `dart-dio-next` is not available in the current Docker image. Use `-g dart-dio`.

## After generation

1. Check `lib/nongnooch_api/` contains files like `api.dart`, `apis/`, `models/`.
2. If any new package imports are used (e.g., `json_annotation`), add them to `pubspec.yaml`.
3. Run `flutter pub get`.

## Usage sketch

```dart
// import 'package:suannongnuch_app/nongnooch_api/api.dart';
// final api = DefaultApi(ApiClient(basePath: 'https://sales-backend.nongnooch.app'));
// final result = await api.someEndpoint();
```
