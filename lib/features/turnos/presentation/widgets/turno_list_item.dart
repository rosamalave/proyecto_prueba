import 'package:flutter/material.dart';
import '../../domain/entities/turno.dart';

class TurnoListItem extends StatelessWidget {
  final Turno turno;

  const TurnoListItem({
    super.key,
    required this.turno,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    turno.rolRequerido,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildEstadoChip(turno.estado),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  turno.zona,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.schedule, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  _formatearFecha(turno.fechaInicio),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  '${turno.duracionHoras}h',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.attach_money, size: 16, color: Colors.green),
                    const SizedBox(width: 4),
                    Text(
                      '\$${turno.pagoOfrecido.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  turno.tipo,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            if (turno.notas.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                turno.notas,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEstadoChip(String estado) {
    Color color;
    String texto;

    switch (estado.toLowerCase()) {
      case 'abierto':
        color = Colors.green;
        texto = 'Abierto';
        break;
      case 'cerrado':
        color = Colors.red;
        texto = 'Cerrado';
        break;
      case 'cancelado':
        color = Colors.orange;
        texto = 'Cancelado';
        break;
      case 'borrador':
        color = Colors.grey;
        texto = 'Borrador';
        break;
      default:
        color = Colors.grey;
        texto = estado;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        texto,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  String _formatearFecha(DateTime fecha) {
    final ahora = DateTime.now();
    final hoy = DateTime(ahora.year, ahora.month, ahora.day);
    final fechaTurno = DateTime(fecha.year, fecha.month, fecha.day);

    if (fechaTurno.isAtSameMomentAs(hoy)) {
      return 'Hoy ${_formatearHora(fecha)}';
    } else if (fechaTurno.isAtSameMomentAs(hoy.add(const Duration(days: 1)))) {
      return 'Mañana ${_formatearHora(fecha)}';
    } else {
      return '${fecha.day}/${fecha.month}/${fecha.year} ${_formatearHora(fecha)}';
    }
  }

  String _formatearHora(DateTime fecha) {
    return '${fecha.hour.toString().padLeft(2, '0')}:${fecha.minute.toString().padLeft(2, '0')}';
  }
} 