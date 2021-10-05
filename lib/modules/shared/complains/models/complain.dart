import 'package:equatable/equatable.dart';

class ComplianEntity extends Equatable {
  final int id;
  final String title;
  final String status;
  final String message;
  // final User owner;
  const ComplianEntity({
    required this.id,
    required this.title,
    required this.message,
    // required this.owner,
    required this.status,
  });

  ComplianEntity copyWith({
    int? id,
    String? title,
    String? message,
    String? status,
    // User? owner,
  }) {
    return ComplianEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      status: status ?? this.status,
      // owner: owner ?? this.owner,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'massage': message,
      'status': status,
      // 'owner': owner.toJson(),
    };
  }

  factory ComplianEntity.fromMap(Map<String, dynamic> map) {
    return ComplianEntity(
      id: map['id'],
      title: map['title'],
      message: map['massage'],
      status: map['status'],
      // owner: User.fromJson(map['owner'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object> get props => [
        id,
        title,
        message,
        status,
        // owner,
      ];
}
