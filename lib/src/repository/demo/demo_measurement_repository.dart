import 'package:mmhg_flutter_test/src/data/demo_data.dart';
import 'package:mmhg_flutter_test/src/model/measurement.dart';
import 'package:mmhg_flutter_test/src/repository/measurement_repository.dart';

class DemoMeasurementRepository extends MeasurementRepository {
  DemoMeasurementRepository() : _measurements = generateMeasurements();

  final List<Measurement> _measurements;

  @override
  List<Measurement> getMeasurements() {
    return _measurements;
  }
}
