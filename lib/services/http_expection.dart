class HttpExpection implements Exception {
  final String message;

  HttpExpection(this.message);

  @override
  String toString() {
    // TODO: implement toString
    return message;
  }
}
