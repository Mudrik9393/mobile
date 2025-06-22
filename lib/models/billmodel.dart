class BillModel {
  final String billName;
  final double amount;
  final int unit;

  BillModel({
    required this.billName,
    required this.amount,
    required this.unit,
  });

  factory BillModel.fromJson(Map<String, dynamic> json) {
    return BillModel(
      billName: json['billName'] ?? '',          // key from backend
      amount: (json['amount'] as num).toDouble(),
      unit: json['unit'] ?? 0,                    // key from backend
    );
  }
}
