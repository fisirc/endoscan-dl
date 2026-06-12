import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';

/// Página de clasificación (subida de archivo y elegir paciente)
class ClassificationPage extends StatefulWidget {
  const ClassificationPage({super.key});

  @override
  State<ClassificationPage> createState() => _ClassificationPageState();
}

class _ClassificationPageState extends State<ClassificationPage> {
  String _patient = '';
  String? _fileName;

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
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Clasificación',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),

              // Paciente field
              Text('Paciente', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.backgroundColor.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: TextField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Escriba el nombre del paciente',
                  ),
                  onChanged: (v) => setState(() => _patient = v),
                ),
              ),
              const SizedBox(height: 16),

              // Archivo upload area
              Text('Archivo', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  // Placeholder: abrir selector de archivos más adelante
                  setState(() => _fileName = 'imagen_ejemplo.jpg');
                },
                child: Container(
                  width: double.infinity,
                  height: 160,
                  decoration: BoxDecoration(
                    color: AppTheme.backgroundColor.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: _fileName == null
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.add_circle_outline,
                                size: 36,
                                color: AppTheme.primaryColor,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Arrastra un archivo',
                                style: TextStyle(color: AppTheme.primaryColor),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.insert_drive_file,
                                size: 36,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _fileName!,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                  ),
                ),
              ),

              const Spacer(),

              // Clasificar button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (_patient.isNotEmpty && _fileName != null)
                      ? () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Clasificación iniciada'),
                            ),
                          );
                        }
                      : null,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Text('Clasificar'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
