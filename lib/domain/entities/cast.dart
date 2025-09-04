class Cast {
  final int id;
  final String name;
  final String character;
  final String? profilePath;
  final int order;
  final String department;
  final String? knownForDepartment;

  Cast({
    required this.id,
    required this.name,
    required this.character,
    this.profilePath,
    required this.order,
    required this.department,
    this.knownForDepartment,
  });

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      character: json['character'] ?? '',
      profilePath: json['profile_path'],
      order: json['order'] ?? 0,
      department: json['department'] ?? '',
      knownForDepartment: json['known_for_department'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'character': character,
      'profile_path': profilePath,
      'order': order,
      'department': department,
      'known_for_department': knownForDepartment,
    };
  }
}
