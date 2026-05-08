extension ListX<T> on List<T> {
  List<List<T>> chunked(int size) {
    final chunks = <List<T>>[];
    for (var i = 0; i < length; i += size) {
      final end = (i + size).clamp(0, length);
      chunks.add(sublist(i, end));
    }
    return chunks;
  }
}
