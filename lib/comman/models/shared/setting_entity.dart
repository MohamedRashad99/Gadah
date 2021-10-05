import 'package:equatable/equatable.dart';

class SettingEntity extends Equatable {
  final int? id;
  final String? name;
  final String? logo;
  final int? commission;
  final String? termsConditions;
  const SettingEntity({
    this.id,
    this.name,
    this.logo,
    this.commission,
    this.termsConditions,
  });

  SettingEntity copyWith({
    int? id,
    String? name,
    String? logo,
    int? commission,
    String? termsConditions,
  }) {
    return SettingEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      logo: logo ?? this.logo,
      commission: commission ?? this.commission,
      termsConditions: termsConditions ?? this.termsConditions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
      'commission': commission,
      'terms_and_conditions_for_customer_complaints': termsConditions,
    };
  }

  factory SettingEntity.fromMap(Map<String, dynamic> map) {
    return SettingEntity(
      id: map['id'],
      name: map['name'],
      logo: map['logo'],
      commission: map['commission'],
      termsConditions: map['terms_and_conditions_for_customer_complaints'],
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      logo,
      commission,
      termsConditions,
    ];
  }
}
