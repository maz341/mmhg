class Patient {
  const Patient({
    required this.id,
    required this.uli,
    required this.firstName,
    required this.lastName,
    this.email,
    this.dateOfBirth,
    this.sex,
    this.height,
    this.weight,
  });

  final int id;
  final String uli;
  final String firstName;
  final String lastName;
  final String? email;
  final DateTime? dateOfBirth;
  final Sex? sex;
  final double? weight;
  final double? height;

  String get fullName => "$firstName $lastName";
}

enum Sex {
  male,
  female,
}

extension SexExt on Sex {
  String get title {
    switch (this) {
      case Sex.male:
        return 'Male';
      case Sex.female:
        return 'Female';
    }
  }
}
