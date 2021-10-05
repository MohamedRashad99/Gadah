import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  final String title;
  final String data;
  final String inputs;
  const NotificationModel({
    required this.data,
    required this.title,
    required this.inputs,
  });

  NotificationModel copyWith({
    String? data,
    String? title,
    String? inputs,
  }) {
    return NotificationModel(
      data: data ?? this.data,
      title: title ?? this.title,
      inputs: inputs ?? this.inputs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'data': data,
      'inputs': inputs,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      data: map['data'],
      title: map['title'],
      inputs: map['inputs'],
    );
  }

  @override
  List<Object> get props => [
        data,
        title,
        inputs,
      ];
}
