import 'package:mmhg_flutter_test/src/data/demo_data.dart';
import 'package:mmhg_flutter_test/src/model/patient.dart';
import 'package:mmhg_flutter_test/src/repository/patient_repository.dart';

class DemoPatientRepository extends PatientRepository {
  DemoPatientRepository() : _patients = demoPatients;

  final List<Patient> _patients;

  @override
  List<Patient> getPatients() {
    return _patients;
  }
}
