import 'package:mmhg_flutter_test/src/model/patient.dart';

abstract class PatientEvent {}

class UpdatePatientsEvent extends PatientEvent {
  UpdatePatientsEvent(this.patients);

  final Iterable<Patient> patients;
}

class SearchPatientEvent extends PatientEvent {
  final String searchTerm;

   SearchPatientEvent(this.searchTerm);

  @override
  List<Object> get props => [searchTerm];
}