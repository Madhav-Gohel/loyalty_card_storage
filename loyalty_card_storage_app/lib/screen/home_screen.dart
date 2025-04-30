import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/loyalty_card.dart';
import '../providers/card_provider.dart';
import 'add_card_screen.dart';
import 'card_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CardProvider>(
      builder: (context, cardProvider, _) {
        final cards = cardProvider.cards;
        return Scaffold(
          appBar: AppBar(
            title: Text('My Loyalty Cards'),
          ),
          body: cards.isEmpty
              ? Center(child: Text('No cards yet! Tap + to add.'))
              : ListView.builder(
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    final card = cards[index];
                    return ListTile(
                      title: Text(card.title),
                      subtitle: Text(card.cardNumber),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => CardDetailScreen(cardId: card.id)),
                        );
                      },
                      onLongPress: () async {
                        final confirmed = await showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text('Delete Card?'),
                            content: Text('Delete "${card.title}"?'),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context, false),
                                  child: Text('Cancel')),
                              TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: Text('Delete')),
                            ],
                          ),
                        );
                        if (confirmed == true) {
                          cardProvider.deleteCard(card.id);
                        }
                      },
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddCardScreen()),
              );
            },
          ),
        );
      },
    );
  }
}