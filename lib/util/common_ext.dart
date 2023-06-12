extension CommonExt on Object? {
  int toInt() {
    final value = this;
    if (value is int) {
      return value;
    }
    return 0;
  }

  double toDouble() {
    final value = this;
    if (value is double) {
      return value;
    }
    return 0;
  }

  String toStringOrEmpty() {
    final value = this;
    if (value != null) {
      if (value is String) {
        return value;
      }
      return value.toString();
    }
    return "";
  }

  List<String> toListWhenString() {
    final value = this;
    if (value is String && value.isNotEmpty) {
      return value.split(", ");
    }
    return [];
  }
}