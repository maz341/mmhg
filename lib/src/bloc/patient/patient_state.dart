import 'package:mmhg_flutter_test/src/model/patient.dart';

class PatientState {
  PatientState({
    required this.patients,
  });

  final List<Patient> patients;

  PatientState copyWith({
    List<Patient>? patients,
  }) =>
      PatientState(
        patients: patients ?? this.patients,
      );
}
class InitialPatientState extends PatientState {
   InitialPatientState({required List<Patient> patients}) : super(patients: patients);
}

class PatientSearchState extends PatientState {
   PatientSearchState(List<Patient> patients) : super(patients: patients);
}
