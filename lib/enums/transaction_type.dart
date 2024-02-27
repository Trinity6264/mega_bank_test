import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";

enum TransactionType {
  @JsonValue("D")
  debit(
    title: "Debit",
    color: Color(0xff022E64),
    bgColor: Color.fromRGBO(120, 200, 225, 0.08),
    linearGradient: [
      Color(0xFF022E64),
      Color(0xFF0E5DBD),
    ],
    icon: "assets/money-send.svg",
  ),

  @JsonValue("C")
  credit(
    title: "Credit",
    color: Color(0xffE6B014),
    bgColor: Color(0xffFDF8EC),
    linearGradient: [
      Color(0xFFA07801),
      Color(0xFFE0AD0F),
    ],
    icon: "assets/money-recive.svg",
  );

  const TransactionType({
    required this.title,
    required this.color,
    required this.bgColor,
    required this.linearGradient,
    required this.icon,
  });
  final String title;
  final Color color;
  final Color bgColor;
  final List<Color> linearGradient;
  final String icon;
}

extension TransactionTypeExtension on TransactionType {
  String get getTitle => title;
  Color get getColor => color;
  Color get getBgColor => bgColor;
  List<Color> get gradientColors => linearGradient;
  String get getIcon => icon;
}
