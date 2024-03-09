class DataLayerException implements Exception {
  final String message;

  DataLayerException(this.message);

  @override
  String toString() => 'DataLayerException: $message';
}

class SourceLayerException implements Exception {
  final String message;

  SourceLayerException(this.message);

  @override
  String toString() => 'SourceLayerException: $message';
}
