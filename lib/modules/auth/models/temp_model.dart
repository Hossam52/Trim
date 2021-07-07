import 'dart:convert';

import 'package:flutter/foundation.dart';

class Temp {
  int x;
  int y;
  Temp({
    @required this.x,
    @required this.y,
  });

  Temp copyWith({
    int x,
    inty,
  }) {
    return Temp(
      x: x ?? this.x,
      y: y ?? this.y,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'x': x,
      'y': y,
    };
  }

  factory Temp.fromMap(Map<String, dynamic> map) {
    return Temp(
      x: map['x'],
      y: map['y'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Temp.fromJson(String source) => Temp.fromMap(json.decode(source));

  @override
  String toString() => 'Temp(x: $x, y: $y)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Temp && other.x == x && other.y == y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}
