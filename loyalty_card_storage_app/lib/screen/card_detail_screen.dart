import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:barcode_widget/barcode_widget.dart';
import '../providers/card_provider.dart';

class CardDetailScreen extends StatelessWidget {
  final String cardId;
  const CardDetailScreen({required this.cardId});

  @override
  Widget build(BuildContext context) {
    final card = Provider.of<CardProvider>(
      context,
      listen: false,
    ).getCardById(cardId);

    if (card == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Card Not Found')),
        body: Center(child: Text('Card not found!')),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(card.title)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(card.title, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Card Number: ${card.cardNumber}', style: TextStyle(fontSize: 18)),
            if (card.expiry != null)
              Text('Expires: ${card.expiry}'),
            SizedBox(height: 40),
            BarcodeWidget(
              data: card.barcodeValue,
              barcode: card.barcodeType == 'qr' ? Barcode.qrCode() : Barcode.code128(),
              width: 250,
              height: 100,
              errorBuilder: (ctx, err) => Text('Invalid code!'),
            ),
            SizedBox(height: 16),
            Text('Show this at checkout', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}