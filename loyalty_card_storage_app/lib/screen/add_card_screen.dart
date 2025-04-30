// lib/screens/add_card_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../providers/card_provider.dart';
import '../models/loyalty_card.dart';

class AddCardScreen extends StatefulWidget {
  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _cardNumberCtrl = TextEditingController();
  final _barcodeCtrl = TextEditingController();

  String _barcodeType = 'code128';
  DateTime? _expiry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Loyalty Card')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleCtrl,
                decoration: InputDecoration(labelText: 'Store/Program Name'),
                validator: (v) => v == null || v.isEmpty ? "Required" : null,
              ),
              TextFormField(
                controller: _cardNumberCtrl,
                decoration: InputDecoration(labelText: 'Card Number'),
                validator: (v) => v == null || v.isEmpty ? "Required" : null,
              ),
              TextFormField(
                controller: _barcodeCtrl,
                decoration: InputDecoration(labelText: 'Barcode/QR Value'),
                validator: (v) => v == null || v.isEmpty ? "Required" : null,
              ),
              SizedBox(height: 10),
              DropdownButtonFormField(
                value: _barcodeType,
                onChanged: (value) {
                  setState(() => _barcodeType = value as String);
                },
                items: [
                  DropdownMenuItem(value: 'code128', child: Text('Barcode')),
                  DropdownMenuItem(value: 'qr', child: Text('QR Code')),
                ],
                decoration: InputDecoration(labelText: 'Type'),
              ),
              SizedBox(height: 10),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Expiry Date: ' +
                    (_expiry != null
                        ? "${_expiry!.toLocal()}".split(' ')[0]
                        : "Not set")),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(Duration(days: 365)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365 * 10)),
                  );
                  if (date != null)
                    setState(() {
                      _expiry = date;
                    });
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                child: Text('Save'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final provider = Provider.of<CardProvider>(context, listen: false);
                    final id = Uuid().v4();
                    final card = LoyaltyCard(
                      id: id,
                      title: _titleCtrl.text,
                      cardNumber: _cardNumberCtrl.text,
                      barcodeValue: _barcodeCtrl.text,
                      barcodeType: _barcodeType,
                      expiry: _expiry,
                    );
                    provider.addCard(card);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}