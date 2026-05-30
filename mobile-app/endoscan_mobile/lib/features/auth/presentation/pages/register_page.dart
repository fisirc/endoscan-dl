import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/validators.dart';
import '../viewmodels/register_viewmodel.dart';
import '../widgets/app_buttons.dart';
import '../widgets/app_text_field.dart';

/// Pantalla de Registro con arquitectura MVVM
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Consumer<RegisterViewModel>(
          builder: (context, viewModel, _) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    _buildHeader(context),
                    const SizedBox(height: 40),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          AppTextField(
                            controller: viewModel.nameController,
                            label: 'Nombre completo',
                            hintText: 'Tu nombre',
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'El nombre es requerido';
                              }
                              return null;
                            },
                            prefixIcon: const Icon(Icons.person_outline),
                          ),
                          const SizedBox(height: 24),
                          AppTextField(
                            controller: viewModel.emailController,
                            label: 'Email',
                            hintText: 'tu@email.com',
                            keyboardType: TextInputType.emailAddress,
                            validator: AppValidators.validateEmail,
                            prefixIcon: const Icon(Icons.email_outlined),
                          ),
                          const SizedBox(height: 24),
                          AppTextField(
                            controller: viewModel.phoneController,
                            label: 'Teléfono',
                            hintText: '+1234567890',
                            keyboardType: TextInputType.phone,
                            validator: AppValidators.validatePhone,
                            prefixIcon: const Icon(Icons.phone_outlined),
                          ),
                          const SizedBox(height: 24),
                          AppTextField(
                            controller: viewModel.dniController,
                            label: 'DNI/Cédula',
                            hintText: '1234567890',
                            keyboardType: TextInputType.number,
                            validator: AppValidators.validateDNI,
                            prefixIcon: const Icon(Icons.assignment_outlined),
                          ),
                          const SizedBox(height: 24),
                          AppTextField(
                            controller: viewModel.passwordController,
                            label: 'Contraseña',
                            hintText: '••••••••',
                            obscureText: !viewModel.isPasswordVisible,
                            validator: AppValidators.validatePassword,
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                viewModel.isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: viewModel.togglePasswordVisibility,
                            ),
                          ),
                          const SizedBox(height: 24),
                          AppTextField(
                            controller: viewModel.confirmPasswordController,
                            label: 'Confirmar contraseña',
                            hintText: '••••••••',
                            obscureText: !viewModel.isConfirmPasswordVisible,
                            validator: (value) {
                              if (value != viewModel.passwordController.text) {
                                return 'Las contraseñas no coinciden';
                              }
                              return null;
                            },
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                viewModel.isConfirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed:
                                  viewModel.toggleConfirmPasswordVisibility,
                            ),
                          ),
                          const SizedBox(height: 24),
                          if (viewModel.errorMessage.isNotEmpty)
                            _buildErrorBanner(viewModel),
                          if (viewModel.errorMessage.isNotEmpty)
                            const SizedBox(height: 24),
                          if (viewModel.successMessage.isNotEmpty)
                            _buildSuccessBanner(viewModel),
                          if (viewModel.successMessage.isNotEmpty)
                            const SizedBox(height: 24),
                          PrimaryButton(
                            text: 'Registrarse',
                            isLoading: viewModel.isLoading,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                viewModel.register();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildLoginLink(context),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Crear Cuenta',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Únete a EndoScan',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppTheme.textSecondary),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildErrorBanner(RegisterViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.errorColor.withValues(alpha: 0.1),
        border: Border.all(color: AppTheme.errorColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: AppTheme.errorColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              viewModel.errorMessage,
              style: const TextStyle(color: AppTheme.errorColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessBanner(RegisterViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.successColor.withValues(alpha: 0.1),
        border: Border.all(color: AppTheme.successColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, color: AppTheme.successColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              viewModel.successMessage,
              style: const TextStyle(color: AppTheme.successColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '¿Ya tienes cuenta? ',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Inicia sesión',
            style: TextStyle(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
