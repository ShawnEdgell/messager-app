import 'package:flutter/material.dart';
// If you're not using the PocketBaseService, consider removing this import
// import 'package:messager_app/services/pocketbase_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key); // Add Key parameter

  @override
  ChatScreenState createState() => ChatScreenState(); // Make class public
}

// Renamed class to be public
class ChatScreenState extends State<ChatScreen> {
  // If you are not using the _pocketBaseService in this class, consider removing this line
  // final PocketBaseService _pocketBaseService = PocketBaseService();
  final TextEditingController _messageController = TextEditingController();
  // Made final since it does not seem to be reassigned
  final List<Map<String, dynamic>> _messages = [];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    // Implement sending messages
  }

  // If _loadMessages is not used, consider removing this method.
  // Future<void> _loadMessages() async {
  //   // Implement message loading
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')), // Use const for Text
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                // If message['content'] is not static, then do not use const
                return ListTile(
                  title: Text(
                      message['content']), // Adjust based on your data model
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0), // Use const for EdgeInsets
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                        hintText:
                            'Type a message'), // Use const for InputDecoration
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send), // Use const for Icon
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
