import 'package:mmhg_flutter_test/src/model/measurement_type.dart';

class Measurement {
  Measurement({
    required this.id,
    required this.dateTaken,
    required this.type,
    required this.value,
    required this.patientId,
  });

  final int id;
  final MeasurementType type;
  final double value;
  final DateTime dateTaken;
  final int patientId;
}
