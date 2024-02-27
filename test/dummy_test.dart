import "package:bank/common/bottom_card_info.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  testWidgets("BottomCardInfo widget test", (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: BottomCardInfo(
          cardInfoParam: (
            key: "Key Text",
            value: "Value Text",
          ),
        ),
      ),
    );

    // Verify that the initial state of the widget is as expected.
    expect(find.text("Key Text"), findsOneWidget);
    expect(find.text("Value Text"), findsOneWidget);

    // You can add more test assertions here, depending on the behavior you want to test.

    // Wait for animations to complete or other asynchronous tasks, if needed.
    await tester.pumpAndSettle();

    // Verify the final state of the widget.
  });
}
