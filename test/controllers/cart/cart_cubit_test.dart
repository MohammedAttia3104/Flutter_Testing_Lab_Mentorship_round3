import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/controllers/cart/cart_cubit.dart';
import 'package:flutter_testing_lab/controllers/cart/cart_state.dart';
import 'package:flutter_testing_lab/models/cart_item.dart';

void main() {
  group('Cart Cubit Test', () {
    ///Add
    blocTest<CartCubit, CartState>(
      'emits state with one item after addItem',
      build: () => CartCubit(),
      act: (cubit) => cubit.addItem('1', 'Apple', 999.99, discount: 0.1),
      expect: () => [
        CartState(
          items: [
            CartItem(id: '1', name: 'Apple', price: 999.99, discount: 0.1),
          ],
        ),
      ],
    );

    ///Add same item again
    ///Increase quantity
    blocTest<CartCubit, CartState>(
      'increments quantity if same item is added again',
      build: () => CartCubit(),
      act: (cubit) {
        cubit.addItem('1', 'Apple', 999.99, discount: 0.1);
        cubit.addItem('1', 'Apple', 999.99, discount: 0.1);
      },
      expect: () => [
        CartState(
          items: [
            CartItem(id: '1', name: 'Apple', price: 999.99, discount: 0.1),
          ],
        ),
        CartState(
          items: [
            CartItem(
              id: '1',
              name: 'Apple',
              price: 999.99,
              discount: 0.1,
              quantity: 2,
            ),
          ],
        ),
      ],
    );

    ///Update Quantity
    blocTest<CartCubit, CartState>(
      'updates quantity of an existing item',
      build: () => CartCubit(),
      seed: () => CartState(
        items: [
          CartItem(
            id: '1',
            name: 'Apple',
            price: 999.99,
            quantity: 2,
            discount: 0.1,
          ),
        ],
      ),
      act: (cubit) => cubit.updateQuantity('1', 5),
      expect: () => [
        CartState(
          items: [
            CartItem(
              id: '1',
              name: 'Apple',
              price: 999.99,
              quantity: 5,
              discount: 0.1,
            ),
          ],
        ),
      ],
    );

    ///Remove Item
    blocTest<CartCubit, CartState>(
      'removes an item from the cart',
      build: () => CartCubit(),
      seed: () => CartState(
        items: [
          CartItem(
            id: '1',
            name: 'Apple',
            price: 999.99,
            quantity: 2,
            discount: 0.1,
          ),
          CartItem(id: '3', name: 'iPad Pro', price: 1099.99),
        ],
      ),
      act: (cubit) => cubit.removeItem('1'),
      expect: () => [
        CartState(
          items: [CartItem(id: '3', name: 'iPad Pro', price: 1099.99)],
        ),
      ],
    );

    ///Clear Cart
    blocTest<CartCubit, CartState>(
      'clears the cart',
      build: () => CartCubit(),
      seed: () => CartState(
        items: [
          CartItem(
            id: '1',
            name: 'Apple',
            price: 999.99,
            quantity: 2,
            discount: 0.1,
          ),
          CartItem(id: '3', name: 'iPad Pro', price: 1099.99),
        ],
      ),
      act: (cubit) => cubit.clearCart(),
      expect: () => [CartState(items: [])],
      verify: (cubit) => expect(cubit.state.isEmpty, true),
    );
  });
}

///blocTest
/// - build: A function that returns a new instance of the Cubit.
/// - seed: An optional function that returns the initial state of the Cubit.
/// - act: A function that takes the Cubit instance and performs actions on it.
/// - expect: A function that returns a list of expected states after the actions are performed.
/// - verify: An optional function that takes the Cubit instance and allows for additional verifications after the test.
