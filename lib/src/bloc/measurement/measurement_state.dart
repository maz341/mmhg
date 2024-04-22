import 'package:mmhg_flutter_test/src/model/measurement.dart';

class MeasurementState {
  MeasurementState({required this.measurements});

  final List<Measurement> measurements;

  int getMeasurementsByPatientId(int patientId) =>
      measurements.where((element) => element.patientId == patientId).length;

  MeasurementState copyWith({List<Measurement>? measurements}) =>
      MeasurementState(measurements: measurements ?? this.measurements);
}
