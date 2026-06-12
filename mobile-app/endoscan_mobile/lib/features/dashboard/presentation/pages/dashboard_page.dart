import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_theme.dart';
import '../widgets/appointment_card.dart';
import '../widgets/quick_action_button.dart';
import '../widgets/statistics_card.dart';
import '../viewmodels/dashboard_viewmodel.dart';
import '../../../patients/presentation/pages/patients_page.dart';
import '../../../appointments/presentation/pages/appointments_page.dart';
import '../../../analysis/presentation/pages/classification_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';

/// Página del Dashboard - Pantalla principal después del login
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    // Cargar datos del dashboard
    Future.microtask(() {
      context.read<DashboardViewModel>().loadDashboardData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Consumer<DashboardViewModel>(
          builder: (context, viewModel, _) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Encabezado de bienvenida
                    Text(
                      'Bienvenido',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          viewModel.doctorName,
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.logout),
                          onPressed: () {
                            Navigator.of(context).pop();
                            viewModel.logout();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Tarjetas de estadísticas
                    StatisticsCard(
                      label: 'Citas hoy',
                      value: viewModel.appointmentsToday.toString(),
                      backgroundColor: AppTheme.primaryColor.withValues(
                        alpha: 0.1,
                      ),
                      icon: Icons.calendar_today,
                    ),
                    const SizedBox(height: 12),
                    StatisticsCard(
                      label: 'Citas semana',
                      value: viewModel.appointmentsWeek.toString(),
                      backgroundColor: AppTheme.primaryColor.withValues(
                        alpha: 0.1,
                      ),
                      icon: Icons.event_note,
                    ),
                    const SizedBox(height: 12),
                    StatisticsCard(
                      label: 'Pacientes activos',
                      value: viewModel.activePatients.toString(),
                      backgroundColor: const Color(0xFFE8F5E9),
                      icon: Icons.people,
                    ),
                    const SizedBox(height: 12),
                    StatisticsCard(
                      label: 'Diagnósticos recientes',
                      value: viewModel.recentDiagnosis.toString(),
                      backgroundColor: const Color(0xFFFFF9E6),
                      icon: Icons.assignment,
                    ),
                    const SizedBox(height: 32),

                    // Acciones rápidas
                    Text(
                      'Acciones Rápidas',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                    ),
                    const SizedBox(height: 12),
                    QuickActionButton(
                      label: 'Ver pacientes',
                      icon: Icons.people_outline,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const PatientsPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    QuickActionButton(
                      label: 'Ver citas',
                      icon: Icons.calendar_today,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const AppointmentsPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    QuickActionButton(
                      label: 'Clasificar imagen',
                      icon: Icons.image_outlined,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const ClassificationPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    QuickActionButton(
                      label: 'Mi Perfil',
                      icon: Icons.person_outline,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const ProfilePage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 32),

                    // Próximas citas
                    Text(
                      'Próximas citas',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                    ),
                    const SizedBox(height: 12),
                    if (viewModel.upcomingAppointments.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(
                            'No hay citas próximas',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: AppTheme.textSecondary),
                          ),
                        ),
                      )
                    else
                      Column(
                        children: List.generate(
                          viewModel.upcomingAppointments.length,
                          (index) {
                            final appointment =
                                viewModel.upcomingAppointments[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    index <
                                        viewModel.upcomingAppointments.length -
                                            1
                                    ? 12
                                    : 0,
                              ),
                              child: AppointmentCard(appointment: appointment),
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
