import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _editing = false;
  final _emailCtrl = TextEditingController(text: 'drhouse@correo.com');
  final _phoneCtrl = TextEditingController(text: '956165786');
  final _dobCtrl = TextEditingController(text: '12/04/2000');
  final _addressCtrl = TextEditingController(text: 'No especificado');

  @override
  void dispose() {
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _dobCtrl.dispose();
    _addressCtrl.dispose();
    super.dispose();
  }

  Widget _infoCard(String label, Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(12),
        border: _editing ? Border.all(color: AppTheme.primaryColor) : null,
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          const Icon(Icons.perm_identity, color: AppTheme.primaryColor),
          const SizedBox(width: 12),
          Expanded(child: child),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          TextButton(
            onPressed: () => setState(() => _editing = !_editing),
            child: Text(
              _editing ? 'Guardar' : 'Editar perfil',
              style: const TextStyle(color: AppTheme.primaryColor),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dr. House',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),

              Text(
                'Información personal',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),

              _infoCard(
                'Correo electrónico',
                _editing
                    ? TextField(
                        controller: _emailCtrl,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Ingresa tu correo',
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Correo electrónico',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppTheme.primaryColor),
                          ),
                          const SizedBox(height: 4),
                          Text(_emailCtrl.text),
                        ],
                      ),
              ),
              const SizedBox(height: 8),

              _infoCard(
                'Teléfono',
                _editing
                    ? TextField(
                        controller: _phoneCtrl,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Teléfono',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppTheme.primaryColor),
                          ),
                          const SizedBox(height: 4),
                          Text(_phoneCtrl.text),
                        ],
                      ),
              ),
              const SizedBox(height: 8),

              _infoCard(
                'Fecha de nacimiento',
                _editing
                    ? TextField(
                        controller: _dobCtrl,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Fecha de nacimiento',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppTheme.primaryColor),
                          ),
                          const SizedBox(height: 4),
                          Text(_dobCtrl.text),
                        ],
                      ),
              ),
              const SizedBox(height: 8),

              _infoCard(
                'Dirección',
                _editing
                    ? TextField(
                        controller: _addressCtrl,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dirección',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppTheme.primaryColor),
                          ),
                          const SizedBox(height: 4),
                          Text(_addressCtrl.text),
                        ],
                      ),
              ),

              const SizedBox(height: 20),
              Text(
                'Mi actividad',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.backgroundColor.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'N° Análisis',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '3',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.backgroundColor.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Último análisis',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '16/04/2026',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
