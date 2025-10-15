import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/shopping_cart.dart';

void main() {
  testWidgets("Test Shopping Cart Behaviour", (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: ShoppingCart())),
    );

    expect(find.text('Cart is empty'), findsOneWidget);

    ///Act
    ///Tap to add first item "iPhone"
    await tester.tap(find.text('Add iPhone'));
    await tester.pump();

    ///Assert
    expect(find.text('Apple iPhone'), findsOneWidget);
    expect(find.text('Total Items: 1'), findsOneWidget);
    expect(find.byIcon(Icons.remove), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byIcon(Icons.delete), findsOneWidget);
    expect(find.byType(Card), findsOneWidget);
    expect(find.byType(ListTile), findsOneWidget);

    ///Tap to add the same item again "iPhone"
    await tester.tap(find.text('Add iPhone'));
    await tester.pump();

    expect(find.text('Apple iPhone'), findsOneWidget);
    expect(find.text('Total Items: 2'), findsOneWidget);

    ///Clear the cart
    await tester.tap(find.text('Clear Cart'));
    await tester.pump();

    expect(find.text('Cart is empty'), findsOneWidget);
  });
}
