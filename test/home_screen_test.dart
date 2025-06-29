import 'package:flutter_test/flutter_test.dart';
import 'package:pocket_tasks/view/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('HomeScreen displays task list', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
    expect(find.byType(HomeScreen), findsOneWidget);
    // You can add more specific widget checks here if needed
  });
}
