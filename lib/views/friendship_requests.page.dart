import 'package:flutter/material.dart';

class FriendshipRequestsPage extends StatelessWidget {
  const FriendshipRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Richieste di amicizia"),
      ),
      body: const Center(
        child: Text("Non ci sono richieste"),
      ),
    );
  }
}
