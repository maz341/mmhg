import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmhg_flutter_test/src/bloc/measurement/measurement_event.dart';
import 'package:mmhg_flutter_test/src/bloc/measurement/measurement_state.dart';
import 'package:mmhg_flutter_test/src/repository/measurement_repository.dart';

import '../../model/measurement.dart';
import '../../model/measurement_type.dart';

class MeasurementBloc extends Bloc<MeasurementEvent, MeasurementState> {
  MeasurementBloc(MeasurementRepository measurementRepository)
      : super(MeasurementState(
            measurements: measurementRepository.getMeasurements())) {
    debugPrint("New MeasurementBloc instance created.");
  }

  double averageBP(List<Measurement> measurements, int patientId) {
    final thirtyDaysAgo = DateTime.now().subtract(Duration(days: 30));
    final bpMeasurements = measurements.where((measurement) =>
        measurement.type == MeasurementType.bloodPressure &&
        measurement.patientId == patientId &&
        measurement.dateTaken.isAfter(thirtyDaysAgo));
    if (bpMeasurements.isEmpty) return 0.0;
    return bpMeasurements
            .map((measurement) => measurement.value)
            .reduce((a, b) => a + b) /
        bpMeasurements.length;
  }

  double averageGlucose(List<Measurement> measurements, int patientId) {
    final thirtyDaysAgo = DateTime.now().subtract(Duration(days: 30));
    final glucoseMeasurements = measurements.where((measurement) =>
        measurement.type == MeasurementType.glucose &&
        measurement.patientId == patientId &&
        measurement.dateTaken.isAfter(thirtyDaysAgo));
    if (glucoseMeasurements.isEmpty) return 0.0;
    return glucoseMeasurements
            .map((measurement) => measurement.value)
            .reduce((a, b) => a + b) /
        glucoseMeasurements.length;
  }
// }
}
