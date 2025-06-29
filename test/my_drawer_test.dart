import 'package:flutter_test/flutter_test.dart';
import 'package:pocket_tasks/widgets/my_drawer.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('MyDrawer displays home, setting', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(drawer: MyDrawer())));
    expect(find.byType(UserAccountsDrawerHeader), findsOneWidget);
  });
}
