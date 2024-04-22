import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmhg_flutter_test/src/bloc/measurement/measurement_bloc.dart';
import 'package:mmhg_flutter_test/src/bloc/measurement/measurement_state.dart';
import 'package:mmhg_flutter_test/src/model/patient.dart';
import 'package:mmhg_flutter_test/src/ui/profile_page.dart';

class PatientCard extends StatelessWidget {
  const PatientCard({
    super.key,
    required this.patient,
  });

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeasurementBloc, MeasurementState>(
      builder: (context, state) => Card(
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      patient.fullName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text('ULI#: ${patient.uli}'),
                    const SizedBox(height: 4.0),
                    Text(
                      'Measurements: ${state.getMeasurementsByPatientId(patient.id)}',
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(
                          patient: patient,
                        ),
                      ));
                },
                child: const Text('View Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
