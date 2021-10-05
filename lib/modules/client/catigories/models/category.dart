import 'package:equatable/equatable.dart';
import 'package:queen/queen.dart';

class CategoryModel extends Equatable {
  final int id;
  final int position;
  final String nameAr;
  final String nameEn;
  final String type;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String name;
  final String image;
  final String imagePath;
  const CategoryModel({
    required this.id,
    required this.position,
    required this.nameAr,
    required this.nameEn,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.image,
    required this.imagePath,
    required this.type,
  });

  CategoryModel copyWith({
    int? id,
    int? position,
    String? nameAr,
    String? nameEn,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    String? image,
    String? imagePath,
    String? type,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      position: position ?? this.position,
      image: image ?? this.image,
      imagePath: imagePath ?? this.imagePath,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      position: map['position'],
      image: map['image'],
      imagePath: map['image_path'],
      nameAr: map['name_ar'],
      nameEn: map['name_en'],
      type: map['type'] as String,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.tryParse(map['updated_at'] ?? ''),
      name: map['name'],
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      position,
      nameAr,
      nameEn,
      createdAt,
      updatedAt,
      name,
      image,
      imagePath,
    ];
  }
}
