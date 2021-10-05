import 'package:equatable/equatable.dart';
import 'package:gadha/comman/models/shared/user.dart';

class ReviewModel extends Equatable {
  final int id;
  final User reviewer;
  final User reviewed;
  final num stars;
  final String comment;
  const ReviewModel({
    required this.id,
    required this.reviewer,
    required this.reviewed,
    required this.stars,
    required this.comment,
  });

  ReviewModel copyWith({
    int? id,
    User? reviewer,
    User? reviewed,
    num? stars,
    String? comment,
  }) {
    return ReviewModel(
      id: id ?? this.id,
      reviewer: reviewer ?? this.reviewer,
      reviewed: reviewed ?? this.reviewed,
      stars: stars ?? this.stars,
      comment: comment ?? this.comment,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reviewer': reviewer.toJson(),
      'reviewed': reviewed.toJson(),
      'rate': stars,
      'comment': comment,
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      id: map['id'] as int,
      reviewer: User.fromJson(map['reviwer'] as Map<String, dynamic>),
      reviewed: User.fromJson(map['reviwed'] as Map<String, dynamic>),
      stars: map['rate'] as num,
      comment: map['comment'] as String,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      reviewer,
      reviewed,
      stars,
      comment,
    ];
  }
}
