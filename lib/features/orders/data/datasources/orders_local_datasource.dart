import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/menu_category_model.dart';
import '../models/menu_item_model.dart';
import '../models/order_model.dart';

final ordersLocalDataSourceProvider = Provider<OrdersLocalDataSource>((ref) {
  return OrdersLocalDataSource();
});

class OrdersLocalDataSource {
  final List<OrderModel> _orders = [];

  List<MenuCategoryModel> getCategories() => _mockCategories;

  List<MenuItemModel> getMenuItems() => _mockItems;

  Future<OrderModel> createOrder(OrderModel order) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _orders.add(order);
    return order;
  }

  Future<OrderModel?> getOrderById(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      return _orders.firstWhere((o) => o.id == orderId);
    } catch (_) {
      return null;
    }
  }

  Future<List<OrderModel>> getOrdersByStatuses(List<String> statuses) async {
    return _orders.where((o) => statuses.contains(o.status)).toList();
  }

  Future<OrderModel> updateOrderStatus({
    required String orderId,
    required String status,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _orders.indexWhere((o) => o.id == orderId);
    if (index == -1) throw Exception('Pedido no encontrado');
    _orders[index] = _orders[index].copyWith(status: status);
    return _orders[index];
  }

  static const List<MenuCategoryModel> _mockCategories = [
    MenuCategoryModel(id: 'cat-1', name: 'Bebidas'),
    MenuCategoryModel(id: 'cat-2', name: 'Entradas'),
    MenuCategoryModel(id: 'cat-3', name: 'Platos'),
    MenuCategoryModel(id: 'cat-4', name: 'Postres'),
  ];

  static const List<MenuItemModel> _mockItems = [
    MenuItemModel(id: 'item-1', name: 'Agua Mineral', description: 'Agua mineral sin gas 500ml', price: 2.50, categoryId: 'cat-1'),
    MenuItemModel(id: 'item-2', name: 'Coca-Cola', description: 'Gaseosa Coca-Cola 355ml', price: 3.00, categoryId: 'cat-1'),
    MenuItemModel(id: 'item-3', name: 'Sprite', description: 'Gaseosa Sprite 355ml', price: 3.00, categoryId: 'cat-1'),
    MenuItemModel(id: 'item-4', name: 'Jugo Natural', description: 'Jugo de fruta natural del día', price: 5.00, categoryId: 'cat-1'),
    MenuItemModel(id: 'item-5', name: 'Cerveza Artesanal', description: 'Cerveza artesanal rubia 330ml', price: 8.00, categoryId: 'cat-1'),
    MenuItemModel(id: 'item-6', name: 'Papas Fritas', description: 'Papas fritas crocantes con salsa de la casa', price: 8.50, categoryId: 'cat-2'),
    MenuItemModel(id: 'item-7', name: 'Nachos', description: 'Nachos con queso fundido y guacamole', price: 12.00, categoryId: 'cat-2'),
    MenuItemModel(id: 'item-8', name: 'Alitas de Pollo', description: 'Alitas de pollo BBQ (6 unidades)', price: 15.00, categoryId: 'cat-2'),
    MenuItemModel(id: 'item-9', name: 'Ensalada César', description: 'Ensalada César con pollo y croutones', price: 14.00, categoryId: 'cat-2'),
    MenuItemModel(id: 'item-10', name: 'Lomo Saltado', description: 'Lomo de res salteado con verduras y papas', price: 28.00, categoryId: 'cat-3'),
    MenuItemModel(id: 'item-11', name: 'Pollo a la Brasa', description: 'Pollo a la brasa con ensalada y papas', price: 32.00, categoryId: 'cat-3'),
    MenuItemModel(id: 'item-12', name: 'Tallarines Verdes', description: 'Tallarines con albahaca y crema de leche', price: 22.00, categoryId: 'cat-3'),
    MenuItemModel(id: 'item-13', name: 'Ceviche Clásico', description: 'Ceviche peruano con pescado fresco', price: 26.00, categoryId: 'cat-3'),
    MenuItemModel(id: 'item-14', name: 'Arroz con Mariscos', description: 'Arroz con mariscos y salsa criolla', price: 30.00, categoryId: 'cat-3'),
    MenuItemModel(id: 'item-15', name: 'Tiramisú', description: 'Tiramisú clásico italiano', price: 12.00, categoryId: 'cat-4'),
    MenuItemModel(id: 'item-16', name: 'Cheesecake', description: 'Cheesecake con maracuyá', price: 14.00, categoryId: 'cat-4'),
    MenuItemModel(id: 'item-17', name: 'Helado Artesanal', description: 'Dos bolas de helado artesanal', price: 10.00, categoryId: 'cat-4'),
    MenuItemModel(id: 'item-18', name: 'Suspiro Limeño', description: 'Postre tradicional peruano', price: 11.00, categoryId: 'cat-4'),
  ];
}
