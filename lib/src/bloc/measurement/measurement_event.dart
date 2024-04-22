import 'package:mmhg_flutter_test/src/model/measurement.dart';

abstract class MeasurementEvent {}

class LoadMeasurementsEvent extends MeasurementEvent {
  LoadMeasurementsEvent(this.measurements);
  final List<Measurement> measurements;
}
