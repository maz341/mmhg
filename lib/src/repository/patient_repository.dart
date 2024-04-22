import 'package:mmhg_flutter_test/src/model/patient.dart';

abstract class PatientRepository {
  List<Patient> getPatients();
}
