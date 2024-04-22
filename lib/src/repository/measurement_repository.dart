import 'package:mmhg_flutter_test/src/model/measurement.dart';

abstract class MeasurementRepository {
  List<Measurement> getMeasurements();
}
