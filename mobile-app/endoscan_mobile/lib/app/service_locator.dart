import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/presentation/viewmodels/login_viewmodel.dart';
import '../../features/auth/presentation/viewmodels/register_viewmodel.dart';
import '../../features/dashboard/presentation/viewmodels/dashboard_viewmodel.dart';
import '../core/constants/app_constants.dart';

/// Configuración de inyección de dependencias
class ServiceLocator {
  /// Inicializa todos los providers
  static List<ChangeNotifierProvider> getProviders() {
    return [
      // ViewModels
      ChangeNotifierProvider<LoginViewModel>(create: (_) => LoginViewModel()),
      ChangeNotifierProvider<RegisterViewModel>(
        create: (_) => RegisterViewModel(),
      ),
      ChangeNotifierProvider<DashboardViewModel>(
        create: (_) => DashboardViewModel(),
      ),
    ];
  }

  /// Configuración de Dio (HTTP Client)
  static Dio _setupDio() {
    final dio = Dio();
    dio.options = BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
    );

    // Interceptores (opcional)
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // TODO: Agregar token a headers si existe
          return handler.next(options);
        },
        onError: (error, handler) {
          // TODO: Manejo de errores global
          return handler.next(error);
        },
      ),
    );

    return dio;
  }

  /// Inicializa data sources
  static Future<void> setupDataSources() async {
    // Inicializar SharedPreferences
    await SharedPreferences.getInstance();

    // Configurar Dio
    _setupDio();

    // Aquí se configurarían las inyecciones de dependencia
    // cuando se necesite conectar a APIs reales
  }
}
