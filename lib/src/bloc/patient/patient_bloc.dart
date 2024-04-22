import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmhg_flutter_test/src/bloc/patient/patient_event.dart';
import 'package:mmhg_flutter_test/src/bloc/patient/patient_state.dart';
import 'package:mmhg_flutter_test/src/repository/patient_repository.dart';

import '../../model/patient.dart';

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  PatientBloc(PatientRepository patientRepository)
      : _patientRepository = patientRepository,
        super(PatientState(patients: [])) {
    on<UpdatePatientsEvent>((event, emit) {
      List<Patient> updatedPatients = List<Patient>.from(state.patients);
      for (var updatedPatient in event.patients) {
        final index =
            updatedPatients.indexWhere((p) => p.id == updatedPatient.id);
        if (index != -1) {
          updatedPatients[index] = updatedPatient;
        } else {
          updatedPatients.add(updatedPatient);
        }
      }
      emit(state.copyWith(patients: updatedPatients));
    });

    on<SearchPatientEvent>((event, emit) {
      final filteredPatients = patientRepository
          .getPatients()
          .where((patient) => patient.fullName
              .toLowerCase()
              .contains(event.searchTerm.toLowerCase()))
          .toList();

      emit(PatientSearchState(filteredPatients));
    });

    add(UpdatePatientsEvent(_patientRepository.getPatients()));
  }

  final PatientRepository _patientRepository;
}
