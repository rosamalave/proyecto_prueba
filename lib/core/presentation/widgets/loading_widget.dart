import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String mensaje;
  final Color? color;
  final IconData? icon;

  const LoadingWidget({
    super.key,
    this.mensaje = 'Cargando...',
    this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: color),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) Icon(icon, color: color ?? Colors.grey),
              if (icon != null) const SizedBox(width: 8),
              Text(
                mensaje,
                style: TextStyle(
                  fontSize: 16,
                  color: color ?? Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 