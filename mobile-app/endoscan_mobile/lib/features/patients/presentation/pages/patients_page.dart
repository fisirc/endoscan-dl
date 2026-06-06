import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../widgets/patient_card.dart';

/// Página de lista de pacientes
class PatientsPage extends StatefulWidget {
  const PatientsPage({super.key});

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  final List<Patient> _patients = [
    Patient(
      id: '1',
      name: 'Lisa Simpson',
      age: 21,
      weightKg: 80.7,
      lastEndoscopy: DateTime(2026, 4, 16),
      risk: 'Medio',
      mlPercent: 32,
    ),
    Patient(
      id: '2',
      name: 'Marge Simpson',
      age: 38,
      weightKg: 70.2,
      lastEndoscopy: DateTime(2025, 11, 20),
      risk: 'Bajo',
      mlPercent: 10,
    ),
    Patient(
      id: '3',
      name: 'Homer Simpson',
      age: 45,
      weightKg: 102.3,
      lastEndoscopy: DateTime(2024, 12, 5),
      risk: 'Alto',
      mlPercent: 78,
    ),
  ];

  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = _patients
        .where((p) => p.name.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text('Mis pacientes'),
        centerTitle: false,
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add, color: AppTheme.primaryColor),
            label: const Text(
              'Nuevo paciente',
              style: TextStyle(color: AppTheme.primaryColor),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${_patients.length} pacientes',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary),
            ),
            const SizedBox(height: 12),
            // Search bar
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppTheme.backgroundColor.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.grey),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Buscar',
                              border: InputBorder.none,
                              isDense: true,
                            ),
                            onChanged: (v) => setState(() => _query = v),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_list, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // List
            Expanded(
              child: ListView.separated(
                itemCount: filtered.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final p = filtered[index];
                  return PatientCard(patient: p);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Patient {
  final String id;
  final String name;
  final int age;
  final double weightKg;
  final DateTime lastEndoscopy;
  final String risk;
  final int mlPercent;

  Patient({
    required this.id,
    required this.name,
    required this.age,
    required this.weightKg,
    required this.lastEndoscopy,
    required this.risk,
    required this.mlPercent,
  });
}
