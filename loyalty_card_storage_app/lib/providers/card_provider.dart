import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/loyalty_card.dart';

class CardProvider with ChangeNotifier {
  List<LoyaltyCard> _cards = [];

  List<LoyaltyCard> get cards => _cards;

  CardProvider() {
    loadCards();
  }

  void loadCards() async {
    var box = Hive.box<LoyaltyCard>('cards');
    _cards = box.values.toList();
    notifyListeners();
  }

  Future<void> addCard(LoyaltyCard card) async {
    var box = Hive.box<LoyaltyCard>('cards');
    await box.put(card.id, card);
    _cards = box.values.toList();
    notifyListeners();
  }

  Future<void> deleteCard(String id) async {
    var box = Hive.box<LoyaltyCard>('cards');
    await box.delete(id);
    _cards = box.values.toList();
    notifyListeners();
  }

  LoyaltyCard? getCardById(String id) {
  return _cards.firstWhere((c) => c.id == id);
  }
}