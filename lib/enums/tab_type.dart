enum CustomTabType {
  all("all"),
  debit("debit"),
  credit("credit");

  const CustomTabType(this.param);
  final String param;
}

extension CustomTabTypeX on CustomTabType {
  String get title => param;
}
