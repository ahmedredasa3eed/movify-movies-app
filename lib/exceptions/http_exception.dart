
class FetchDataException implements Exception {
  final _message;
  FetchDataException([this._message]);

  String toString() {
    return _message;
  }
}

class InternetException implements Exception {
  final _message;
  InternetException([this._message]);

  String toString() {
    return _message;
  }
}

