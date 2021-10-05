import 'package:equatable/equatable.dart';

class Setting extends Equatable {
  final String type;
  final String title;
  final String detail;
  const Setting({
    required this.type,
    required this.title,
    required this.detail,
  });

  Setting copyWith({
    String? type,
    String? title,
    String? detail,
  }) {
    return Setting(
      type: type ?? this.type,
      title: title ?? this.title,
      detail: detail ?? this.detail,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'title': title,
      'detail': detail,
    };
  }

  factory Setting.fromMap(Map<String, dynamic> map) {
    return Setting(
      type: map['type'] as String,
      title: map['title'] as String,
      detail: map['detail'] as String,
    );
  }

  @override
  List<Object?> get props => [type, title, detail];
}
