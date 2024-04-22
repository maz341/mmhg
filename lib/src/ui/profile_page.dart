import 'package:flutter/material.dart';
import 'package:mmhg_flutter_test/src/model/patient.dart';
import 'package:mmhg_flutter_test/src/bloc/patient/patient_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/measurement/measurement_bloc.dart';
import '../bloc/patient/patient_event.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    required this.patient,
  });

  final Patient patient;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _uliController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _heightController;
  late TextEditingController _weightController;
  late double averageBP;
  late double averageGlucose;

  Sex? _selectedSex;
  DateTime? _selectedDateOfBirth;

  @override
  void initState() {
    super.initState();
    _uliController = TextEditingController(text: widget.patient.uli);
    _firstNameController =
        TextEditingController(text: widget.patient.firstName);
    _lastNameController = TextEditingController(text: widget.patient.lastName);
    _emailController = TextEditingController(text: widget.patient.email);
    _heightController =
        TextEditingController(text: widget.patient.height?.toString());
    _weightController =
        TextEditingController(text: widget.patient.weight?.toString());
    _selectedSex = widget.patient.sex;
    _selectedDateOfBirth = widget.patient.dateOfBirth;

    final measurements = context.read<MeasurementBloc>().state.measurements;
    averageBP = context
        .read<MeasurementBloc>()
        .averageBP(measurements, widget.patient.id);
    averageGlucose = context
        .read<MeasurementBloc>()
        .averageGlucose(measurements, widget.patient.id);
  }

  @override
  void dispose() {
    _uliController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ProfilePage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.patient != widget.patient) {
      _uliController.text = widget.patient.uli;
      _firstNameController.text = widget.patient.firstName;
      _lastNameController.text = widget.patient.lastName;
      _emailController.text = widget.patient.email ?? '';
      _heightController.text = widget.patient.height?.toString() ?? '';
      _weightController.text = widget.patient.weight?.toString() ?? '';
      _selectedSex = widget.patient.sex;
      _selectedDateOfBirth = widget.patient.dateOfBirth;
      final measurements = context.read<MeasurementBloc>().state.measurements;
      averageBP = context
          .read<MeasurementBloc>()
          .averageBP(measurements, widget.patient.id);
      averageGlucose = context
          .read<MeasurementBloc>()
          .averageGlucose(measurements, widget.patient.id);
    }
  }

  void _saveProfile(BuildContext context) {
    final updatedPatient = Patient(
      id: widget.patient.id,
      uli: widget.patient.uli,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text.isNotEmpty ? _emailController.text : null,
      sex: _selectedSex,
      dateOfBirth: _selectedDateOfBirth,
      height: _heightController.text.isNotEmpty
          ? double.tryParse(_heightController.text)
          : null,
      weight: _weightController.text.isNotEmpty
          ? double.tryParse(_weightController.text)
          : null,
    );

    context.read<PatientBloc>().add(UpdatePatientsEvent([updatedPatient]));

    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Details'),
        actions: [
          TextButton(
            onPressed: () => _saveProfile(context),
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _uliController,
              decoration: const InputDecoration(labelText: 'ULI'),
              enabled: false,
            ),
            TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
              validator: (value) =>
                  value!.isEmpty ? 'First name is required' : null,
            ),
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
              validator: (value) =>
                  value!.isEmpty ? 'Last name is required' : null,
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            DropdownButton<Sex>(
              value: _selectedSex,
              onChanged: (Sex? newValue) {
                setState(() {
                  _selectedSex = newValue;
                });
              },
              items: Sex.values.map((Sex classType) {
                return DropdownMenuItem<Sex>(
                  value: classType,
                  child: Text(classType.title),
                );
              }).toList(),
            ),
            TextFormField(
              controller: _heightController,
              decoration: const InputDecoration(labelText: 'Height (cm)'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _weightController,
              decoration: const InputDecoration(labelText: 'Weight (kg)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Text('Average BP (30 days): ${averageBP.toStringAsFixed(0)}'),
            const SizedBox(height: 20),
            Text(
                'Average Glucose (30 days): ${averageGlucose.toStringAsFixed(0)}'),
          ],
        ),
      ),
    );
  }
}
