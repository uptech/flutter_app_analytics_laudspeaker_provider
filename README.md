# Flutter App Analytics Provider for Laudspeaker

Implements support for Laudspeaker into the [Flutter App Analytics](https://github.com/uptech/flutter_app_analytics) package. This package uses the Laudspeaker http API.

## How to use

```dart
LaudspeakerProvider laudspeaker = LaudspeakerProvider(apiKey: 'some_key');
Analytics analytics = ...;
analytics.providers = [laudspeaker];
```

## Testing

### Run Tests

run the tests:

```
flutter test
```
