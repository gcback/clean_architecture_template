class DataLayerException implements Exception {
  final String message;

  DataLayerException(this.message);

  @override
  String toString() => 'DataLayerException: $message';
}
