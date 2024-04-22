import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmhg_flutter_test/src/bloc/measurement/measurement_bloc.dart';
import 'package:mmhg_flutter_test/src/bloc/measurement/measurement_state.dart';
import 'package:mmhg_flutter_test/src/bloc/patient/patient_bloc.dart';
import 'package:mmhg_flutter_test/src/bloc/patient/patient_state.dart';
import 'package:mmhg_flutter_test/src/model/patient.dart';
import 'package:mmhg_flutter_test/src/repository/demo/demo_measurement_repository.dart';
import 'package:mmhg_flutter_test/src/ui/components/patient_card.dart';

import '../bloc/patient/patient_event.dart';
import 'profile_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  late BuildContext context;

  @override
  Widget build(BuildContext myCtx) {
    context = myCtx;

    return LayoutBuilder(
      builder: (myCtx, constraints) {
        if (constraints.maxWidth > 600) {
          return TabletLayout();
        } else {
          return MobileLayout();
        }
      },
    );
  }
}

class MobileLayout extends StatelessWidget {
  MobileLayout({super.key});
  final MeasurementBloc measurementBloc =
      MeasurementBloc(DemoMeasurementRepository());

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: MeasurementBloc(DemoMeasurementRepository()),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Patients'),
          ),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600.0),
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) => BlocProvider.of<PatientBloc>(context)
                        .add(SearchPatientEvent(value)),
                    decoration: const InputDecoration(
                      hintText: 'Search Patients...',
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Expanded(
                    child: BlocBuilder<PatientBloc, PatientState>(
                        builder: (context, state) {
                      final sortedPatients = state.patients.toList()
                        ..sort(
                          (a, b) => a.lastName.compareTo(b.lastName),
                        );

                      return ListView.builder(
                        itemCount: sortedPatients.length,
                        itemBuilder: (context, index) {
                          final patient = sortedPatients[index];
                          return BlocProvider.value(
                            value: measurementBloc,
                            child: PatientCard(patient: patient),
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TabletLayout extends StatefulWidget {
  @override
  _TabletLayoutState createState() => _TabletLayoutState();
}

class _TabletLayoutState extends State<TabletLayout> {
  Patient? _selectedPatient;

  @override
  Widget build(BuildContext context) {
    debugPrint("_selectedPatient ${_selectedPatient?.firstName}");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tablet Layout'),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: BlocBuilder<PatientBloc, PatientState>(
                builder: (context, state) {
                  final sortedPatients = state.patients.toList()
                    ..sort(
                      (a, b) => a.lastName.compareTo(b.lastName),
                    );

                  return ListView.builder(
                    itemCount: sortedPatients.length,
                    itemBuilder: (context, index) {
                      final patient = sortedPatients[index];

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedPatient = patient;
                          });
                        },
                        child: Card(
                          margin: const EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                        BlocBuilder<MeasurementBloc,
                                                MeasurementState>(
                                            builder: (context, state) {
                                          return Text(
                                            'Measurements: ${state.getMeasurementsByPatientId(patient.id)}',
                                          );
                                        })
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: _selectedPatient != null
                ? BlocProvider(
                    create: (context) =>
                        MeasurementBloc(DemoMeasurementRepository()),
                    child: ProfilePage(patient: _selectedPatient!),
                  )
                : Container(
                    decoration: const BoxDecoration(color: Colors.black12),
                    child: const Center(
                      child: Text("No data found"),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
