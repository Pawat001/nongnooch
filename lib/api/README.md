OpenAPI / Swagger integration guide

Goal
----
Generate a typed Dart API client from an OpenAPI/Swagger spec (the Swagger UI you gave is at: https://sales-backend.nongnooch.app/api-docs/#/ ) and integrate it into this Flutter project. This guide shows how to generate the client using OpenAPI Generator and how to integrate it into the project. It also contains a small helper to verify connectivity to the spec URL.

Option A — Recommended: Generate client with OpenAPI Generator (dart-dio-next)
--------------------------------------------------------------------------
Prerequisites
- Docker (recommended) OR Java (for the JAR) OR npm (openapi-generator-cli)
- A working internet connection to fetch the OpenAPI JSON/YAML (or a local spec file)

Generator choices
- "dart-dio-next" (uses Dio, good for Flutter apps)
- "dart" (simpler)

Basic Docker command (PowerShell)
```powershell
# Replace <SPEC_URL> with the OpenAPI JSON/YAML URL. For your swagger UI the spec URL may be something like:
# https://sales-backend.nongnooch.app/v3/api-docs or https://sales-backend.nongnooch.app/openapi.json
# If unsure, open the Swagger UI and look for "Download JSON" or the raw spec URL.

$spec = 'https://sales-backend.nongnooch.app/v3/api-docs' # <- adjust if needed

docker run --rm -v ${PWD}:/local openapitools/openapi-generator-cli generate `
  -i $spec `
  -g dart-dio-next `
  -o /local/lib/api

# This will create a generated Dart client under lib/api
```

If you prefer JAR (requires Java):
```powershell
java -jar openapi-generator-cli.jar generate -i "https://sales-backend.nongnooch.app/v3/api-docs" -g dart-dio-next -o lib/api
```

After generation
1. Add generated files to VCS (or move them into a package dir).
2. The generated code will depend on `dio`. Make sure `dio` is in your `pubspec.yaml` (this project already has it added).
3. Run `flutter pub get`.
4. See the generated README (usually created under lib/api) for exact usage. Typically you create a Dio instance and then an API class; for example:

```dart
import 'package:dio/dio.dart';
import 'package:your_app/api/api.dart'; // path depends on generator output

final dio = Dio();
final api = DefaultApi(dio);
final resp = await api.getAttractions();
```

Notes
- If your API requires authentication, configure Dio interceptors (e.g., add Authorization header).
- Customize generator with config options if you want different naming or to split files.

Option B — If you cannot run the generator here
-----------------------------------------------
I can provide the exact commands and a small helper in the app to verify connectivity to the spec (see `swagger_spec_fetcher.dart`). If you run the Docker/JAR command locally it will produce the generated client which you can then commit; I can then update the app to call the generated client.

Quick test in the app (verify spec reachable)
--------------------------------------------
A small helper `SwaggerSpecFetcher` exists at `lib/api/swagger_spec_fetcher.dart`. Use it like:

```dart
final fetcher = SwaggerSpecFetcher();
try {
  final spec = await fetcher.fetchSpec('https://sales-backend.nongnooch.app/v3/api-docs');
  print('Spec fetched - keys: ${spec.keys.toList()}');
} catch (e) {
  print('Spec fetch failed: $e');
}
```

After generation: integrating generated client into UI
----------------------------------------------------
- Generated models can be used directly to decode responses.
- Wrap API calls behind Providers (like `CartProvider`, `SomeDataProvider`) and expose methods to UI.
- Add error handling, retry/backoff and optionally local caching (Hive) for offline UX.

If you want me to continue
--------------------------
- I can generate a client *for you* if you provide the raw OpenAPI JSON/YAML file (upload here). I cannot run Docker or remote generator from inside this environment, but I can: generate example wrappers, or after you run generator locally and paste the generated files here I will integrate them into the project.
- Or I can implement a small manual `ApiService` using `dio` that calls specific endpoints you care about (no codegen). Tell me which endpoints you want to call from the app (e.g., list attractions, product details, cart endpoints, etc.).

Which path do you want to take?
- I can (A) provide the exact Docker/JAR command you should run locally (done above) and then integrate generated files you produce, or
- (B) implement a manual `dio`-based service for a few endpoints you name so the app can call the API now without generation.

