import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmhg_flutter_test/src/bloc/patient/patient_bloc.dart';
import 'package:mmhg_flutter_test/src/repository/demo/demo_patient_repository.dart';
import 'package:mmhg_flutter_test/src/ui/home_page.dart';

import 'src/bloc/measurement/measurement_bloc.dart';
import 'src/repository/demo/demo_measurement_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: PatientBloc(DemoPatientRepository())),
        BlocProvider<MeasurementBloc>(
          create: (context) => MeasurementBloc(DemoMeasurementRepository()),
        ),
      ],
      child: MaterialApp(
        title: 'Mmhg Flutter Test',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: false,
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(centerTitle: true),
        ),
        home: HomePage(),
      ),
    );
  }
}
