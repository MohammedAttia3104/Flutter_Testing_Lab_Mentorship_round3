import 'package:equatable/equatable.dart';

import '../../models/cart_item.dart';

class CartState extends Equatable {
  final List<CartItem> items;

  const CartState({this.items = const []});

  double get subtotal =>
      items.fold(0, (sum, item) => sum + item.price * item.quantity);

  double get totalDiscount => items.fold(
    0,
    (sum, item) => sum + item.price * item.quantity * item.discount,
  );

  double get totalAmount => subtotal - totalDiscount;

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  bool get isEmpty => items.isEmpty;

  CartState copyWith({List<CartItem>? items}) {
    return CartState(items: items ?? this.items);
  }

  @override
  List<Object?> get props => [items];
}
