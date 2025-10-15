import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/cart_item.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState());

  void addItem(String id, String name, double price, {double discount = 0.0}) {
    final items = List<CartItem>.from(state.items);
    final index = items.indexWhere((item) => item.id == id);

    if (index != -1) {
      final updatedItem = items[index].copyWith(quantity: items[index].quantity + 1);
      items[index] = updatedItem;
    } else {
      items.add(CartItem(id: id, name: name, price: price, discount: discount));
    }

    emit(state.copyWith(items: items));
  }

  void updateQuantity(String id, int newQuantity) {
    final items = List<CartItem>.from(state.items);
    final index = items.indexWhere((item) => item.id == id);

    if (index != -1) {
      if (newQuantity <= 0) {
        items.removeAt(index);
      } else {
        final updatedItem = items[index].copyWith(quantity: newQuantity);
        items[index] = updatedItem;
      }
      emit(state.copyWith(items: items));
    }
  }

  void clearCart() {
    emit(state.copyWith(items: []));
  }

  void removeItem(String id) {
    final items = List<CartItem>.from(state.items)
      ..removeWhere((item) => item.id == id);
    emit(state.copyWith(items: items));
  }
}
