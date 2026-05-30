import 'package:flutter/material.dart';

/// Modelo para representar una cita
class Appointment {
  final String id;
  final String patientName;
  final String status;
  final DateTime date;
  final String? time;

  Appointment({
    required this.id,
    required this.patientName,
    required this.status,
    required this.date,
    this.time,
  });
}

/// ViewModel para el Dashboard
class DashboardViewModel extends ChangeNotifier {
  // Datos del doctor
  String _doctorName = 'Dr. House';

  // Estadísticas
  int _appointmentsToday = 1;
  int _appointmentsWeek = 5;
  int _activePatients = 3;
  int _recentDiagnosis = 1;

  // Próximas citas
  List<Appointment> _upcomingAppointments = [];

  // Getters
  String get doctorName => _doctorName;
  int get appointmentsToday => _appointmentsToday;
  int get appointmentsWeek => _appointmentsWeek;
  int get activePatients => _activePatients;
  int get recentDiagnosis => _recentDiagnosis;
  List<Appointment> get upcomingAppointments => _upcomingAppointments;

  /// Inicializa los datos del dashboard
  Future<void> loadDashboardData() async {
    try {
      // Simulación de carga de datos
      await Future.delayed(const Duration(seconds: 1));

      // Cargar próximas citas
      _upcomingAppointments = [
        Appointment(
          id: '1',
          patientName: 'Lisa Simpson',
          status: 'Pendiente',
          date: DateTime.now().add(const Duration(days: 1)),
          time: '14:30',
        ),
        Appointment(
          id: '2',
          patientName: 'Homer Simpson',
          status: 'Pendiente',
          date: DateTime.now().add(const Duration(days: 3)),
          time: '10:00',
        ),
        Appointment(
          id: '3',
          patientName: 'Marge Simpson',
          status: 'Confirmada',
          date: DateTime.now().add(const Duration(days: 7)),
          time: '09:00',
        ),
      ];

      notifyListeners();
    } catch (e) {
      debugPrint('Error loading dashboard: $e');
    }
  }

  /// Cerrar sesión
  void logout() {
    _appointmentsToday = 1;
    _appointmentsWeek = 5;
    _activePatients = 3;
    _recentDiagnosis = 1;
    _upcomingAppointments = [];
    notifyListeners();
  }
}
