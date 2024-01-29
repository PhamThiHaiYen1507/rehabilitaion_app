class ApiException<T> implements Exception {
  final T? dbData;

  final String? message;

  ApiException({this.message, this.dbData});
}
