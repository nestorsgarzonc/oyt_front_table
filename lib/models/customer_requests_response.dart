import 'dart:convert';

import 'package:equatable/equatable.dart';

class CustomerRequestsResponse extends Equatable {

  factory CustomerRequestsResponse.fromJson(String source) =>
      CustomerRequestsResponse.fromMap(json.decode(source));

  factory CustomerRequestsResponse.fromMap(Map<String, dynamic> map) {
    return CustomerRequestsResponse(
      List<String>.from(map['callingTables']),
    );
  }
  const CustomerRequestsResponse(this.callingTables);

  final List<String> callingTables;

  @override
  List<Object> get props => [callingTables];

  CustomerRequestsResponse copyWith({
    List<String>? callingTables,
  }) {
    return CustomerRequestsResponse(
      callingTables ?? this.callingTables,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'callingTables': callingTables,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'CustomerRequestsResponse(callingTables: $callingTables)';
}
