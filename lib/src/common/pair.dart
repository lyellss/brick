class Pair<E, F> {
  E first;
  F last;

  Pair(this.first, this.last);

  @override
  String toString() => '($first, $last)';

  @override
  bool operator ==(other) {
    if (other is! Pair) return false;
    return other.first == first && other.last == last;
  }

  @override
  int get hashCode => first.hashCode ^ last.hashCode;
}

class Pair3<E, F, D> {
  E first;
  F second;

  D last;

  Pair3(this.first, this.second, this.last);

  @override
  String toString() {
    return 'Pair3{first: $first, second: $second, last: $last}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pair3 &&
          runtimeType == other.runtimeType &&
          first == other.first &&
          second == other.second &&
          last == other.last;

  @override
  int get hashCode => first.hashCode ^ second.hashCode ^ last.hashCode;
}

class PairString {
  String? first;
  String? last;

  PairString(this.first, this.last);

  @override
  String toString() => '($first, $last)';

  @override
  bool operator ==(other) {
    if (other is! Pair) return false;
    return other.first == first && other.last == last;
  }

  @override
  int get hashCode => first.hashCode ^ last.hashCode;
}
