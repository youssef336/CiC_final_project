dynamic reshapeFlatList<T>(List<T> flat, List<int> shape) {
  if (shape.isEmpty) {
    throw ArgumentError('Shape cannot be empty');
  }

  final expectedLen = shape.fold<int>(1, (a, b) => a * b);
  if (flat.length != expectedLen) {
    throw ArgumentError(
      'Flat length ${flat.length} does not match shape product $expectedLen',
    );
  }

  var index = 0;

  dynamic build(int dim) {
    final size = shape[dim];
    if (dim == shape.length - 1) {
      final list = List<T>.generate(size, (_) => flat[index++], growable: false);
      return list;
    }
    return List.generate(size, (_) => build(dim + 1), growable: false);
  }

  return build(0);
}

dynamic makeNestedList<T>(List<int> shape, T fill) {
  if (shape.isEmpty) {
    return fill;
  }

  dynamic build(int dim) {
    final size = shape[dim];
    if (dim == shape.length - 1) {
      return List<T>.filled(size, fill, growable: false);
    }
    return List.generate(size, (_) => build(dim + 1), growable: false);
  }

  return build(0);
}

List<T> flattenNested<T>(dynamic nested) {
  final out = <T>[];

  void walk(dynamic node) {
    if (node is List) {
      for (final v in node) {
        walk(v);
      }
      return;
    }
    out.add(node as T);
  }

  walk(nested);
  return out;
}
