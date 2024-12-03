class StudentModel {
  int? id;
  final String name;
  final String age;
  final String gName;
  final String phone;
  final String profilePath;

  StudentModel({
    required this.name,
    required this.age,
    required this.gName,
    required this.phone,
    this.id,
    required this.profilePath,
  });

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      gName: map['gName'],
      phone: map['phone'],
      profilePath: map['profilePath'],
    );
    
  }
}
