import 'package:app_parking/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('PageView control test', (WidgetTester tester) async {
    await tester.pumpWidget(const ParkingApp());

    final expansionTitleFind = find.byKey(Key("pageView"));
    expect(expansionTitleFind, findsOneWidget);

    PageView pageView = tester.firstWidget(expansionTitleFind);

    // await tester.tap(find.byWidget(customExpansionTile));
    // await tester.pump();
    // expect(customExpansionTile.title, "O que é?");
    // expect(customExpansionTile.descriptionText, "A antecipação de recebíveis é a antecipação dos valores a receber, das vendas realizadas no crédito à vista ou parcelado.");
    // expect(customExpansionTile.isExpanded, false);
  });
}
