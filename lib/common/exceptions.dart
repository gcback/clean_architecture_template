class SourceLayerException implements Exception {
  final String message;

  SourceLayerException(this.message);

  @override
  String toString() => 'SourceLayerException: $message';
}

class DataLayerException implements Exception {
  final String message;

  DataLayerException(this.message);

  @override
  String toString() => 'DataLayerException: $message';
}

class DomainLayerException implements Exception {
  final String message;

  DomainLayerException(this.message);

  @override
  String toString() => 'DomainLayerException: $message';
}

class PresentationLayerException implements Exception {
  final String message;

  PresentationLayerException(this.message);

  @override
  String toString() => 'PresentationLayerException: $message';
}
