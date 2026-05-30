import 'package:flutter/material.dart';
import '../../domain/enums/movement_type.dart';

class MovementFormDialog extends StatefulWidget {
  final String itemName;
  final String unit;

  const MovementFormDialog({
    super.key,
    required this.itemName,
    required this.unit,
  });

  @override
  State<MovementFormDialog> createState() => _MovementFormDialogState();
}

class _MovementFormDialogState extends State<MovementFormDialog> {
  MovementType _type = MovementType.entry;
  final _quantityController = TextEditingController();
  final _noteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _quantityController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: const Text('Registrar Movimiento'),
      content: Form(
        key: _formKey,
        child: SizedBox(
          width: 320,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.itemName,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Text('Tipo de Movimiento',
                  style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              Row(
                children: MovementType.values.map((t) {
                  final isSelected = _type == t;
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: t == MovementType.entry ? 4 : 0,
                        left: t == MovementType.exit ? 4 : 0,
                      ),
                      child: ChoiceChip(
                        label: SizedBox(
                          width: double.infinity,
                          child: Text(t.displayName,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 12)),
                        ),
                        selected: isSelected,
                        onSelected: (_) => setState(() => _type = t),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(
                  labelText: 'Cantidad',
                  suffixText: widget.unit,
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Ingrese cantidad';
                  final qty = double.tryParse(v);
                  if (qty == null || qty <= 0) return 'Cantidad inválida';
                  if (_type == MovementType.exit && qty <= 0) {
                    return 'Debe ser mayor a 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _noteController,
                decoration: InputDecoration(
                  labelText: 'Observación (opcional)',
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.of(context).pop({
                'type': _type,
                'quantity': double.parse(_quantityController.text),
                'note': _noteController.text,
              });
            }
          },
          child: const Text('Registrar'),
        ),
      ],
    );
  }
}
