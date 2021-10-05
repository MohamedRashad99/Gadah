import 'package:equatable/equatable.dart';

class SliderModel extends Equatable {
  final int id;
  final String image;
  final int? position;
  final String imagePath;
  const SliderModel({
    required this.id,
    required this.image,
    required this.imagePath,
    required this.position,
  });

  SliderModel copyWith({
    int? id,
    String? image,
    String? imagePath,
    int? position,
  }) {
    return SliderModel(
      id: id ?? this.id,
      image: image ?? this.image,
      position: position ?? this.position,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'position': position,
      'image_path': imagePath,
    };
  }

  factory SliderModel.fromMap(Map<String, dynamic> map) {
    return SliderModel(
      id: map['id'],
      image: map['image'],
      position: map['position'],
      imagePath: map['image_path'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        image,
        position,
        imagePath,
      ];
}
