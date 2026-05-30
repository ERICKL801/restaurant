enum KitchenOrderStatus {
  sent('sent'),
  preparing('preparing'),
  ready('ready'),
  delivered('delivered');

  final String value;
  const KitchenOrderStatus(this.value);

  String get displayName {
    switch (this) {
      case KitchenOrderStatus.sent:
        return 'Pendiente';
      case KitchenOrderStatus.preparing:
        return 'Preparando';
      case KitchenOrderStatus.ready:
        return 'Listo';
      case KitchenOrderStatus.delivered:
        return 'Entregado';
    }
  }

  static KitchenOrderStatus fromString(String value) {
    return KitchenOrderStatus.values.firstWhere(
      (s) => s.value == value,
      orElse: () => KitchenOrderStatus.sent,
    );
  }

  KitchenOrderStatus? get nextStatus {
    switch (this) {
      case KitchenOrderStatus.sent:
        return KitchenOrderStatus.preparing;
      case KitchenOrderStatus.preparing:
        return KitchenOrderStatus.ready;
      case KitchenOrderStatus.ready:
        return KitchenOrderStatus.delivered;
      case KitchenOrderStatus.delivered:
        return null;
    }
  }
}
