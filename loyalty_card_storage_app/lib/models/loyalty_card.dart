import 'package:hive/hive.dart';

part 'loyalty_card.g.dart';

@HiveType(typeId: 0)
class LoyaltyCard extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String cardNumber;
  @HiveField(3)
  String barcodeValue;
  @HiveField(4)
  String barcodeType; // "code128" or "qr"
  @HiveField(5)
  DateTime? expiry;

  LoyaltyCard({
    required this.id,
    required this.title,
    required this.cardNumber,
    required this.barcodeValue,
    required this.barcodeType,
    this.expiry,
  });
}