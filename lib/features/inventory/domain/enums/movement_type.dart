enum MovementType {
  entry('entry', 'Entrada'),
  exit('exit', 'Salida'),
  adjustment('adjustment', 'Ajuste');

  final String value;
  final String displayName;
  const MovementType(this.value, this.displayName);

  static MovementType fromString(String value) {
    return MovementType.values.firstWhere(
      (m) => m.value == value,
      orElse: () => MovementType.entry,
    );
  }
}
