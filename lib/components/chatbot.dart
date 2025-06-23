import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_gen_ai_chat_ui/flutter_gen_ai_chat_ui.dart';
import 'package:http/http.dart' as http;

class Chatbot extends StatefulWidget {
  final Map<String, dynamic>? data;
  const Chatbot({super.key, this.data});

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  final _controller = ChatMessagesController();
  final _currentUser = const ChatUser(id: 'user', firstName: 'You');
  final _aiUser = const ChatUser(id: 'ai', firstName: 'AI Assistant');
  bool _isLoading = false;

  // Store chat history in memory
  final List<ChatMessage> _chatHistory = [];

  Future<void> _handleSend(ChatMessage message) async {
    setState(() => _isLoading = true);
    _controller.addMessage(message);
    _chatHistory.add(message);

    try {
      final response = await http.post(
        Uri.parse(
          'https://us-central1-tenderiq-f763c.cloudfunctions.net/ai_chatbot',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'llmContext': widget.data, 'query': message.text}),
      );
      print(widget.data);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final aiText = data['response'] ?? 'No response.';
        final aiMessage = ChatMessage(
          text: aiText,
          user: _aiUser,
          createdAt: DateTime.now(),
        );
        _controller.addMessage(aiMessage);
        _chatHistory.add(aiMessage);
      } else {
        _controller.addMessage(
          ChatMessage(
            text: 'AI error: ${response.body}',
            user: _aiUser,
            createdAt: DateTime.now(),
          ),
        );
      }
    } catch (e) {
      _controller.addMessage(
        ChatMessage(
          text: 'Failed to connect to AI: $e',
          user: _aiUser,
          createdAt: DateTime.now(),
        ),
      );
    }
    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _controller.messages.clear(); // Clear chat history in controller
    _chatHistory.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 238, 249, 255), // Light blue bg
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Row(
              children: const [
                Icon(Icons.chat_bubble_outline, color: Colors.blueAccent),
                SizedBox(width: 8),
                Text(
                  "AI Assistant",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Chat interface with custom input box color
            Expanded(
              child: SizedBox(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      inputDecorationTheme: InputDecorationTheme(
                        filled: true,
                        fillColor: Colors.white, // 👈 Fixed pale input box
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ),
                    child: AiChatWidget(
                      currentUser: _currentUser,
                      aiUser: _aiUser,
                      controller: _controller,
                      onSendMessage: _handleSend,
                      loadingConfig: LoadingConfig(isLoading: _isLoading),
                      inputOptions: const InputOptions(
                        enableSuggestions: true,
                        autocorrect: true,
                        sendOnEnter: true,
                      ),
                      welcomeMessageConfig: const WelcomeMessageConfig(
                        title: "Chat with AI",
                        questionsSectionTitle: "Try asking:",
                      ),
                      exampleQuestions: const [
                        ExampleQuestion(
                          question: "What are eligibility criteria?",
                        ),
                        ExampleQuestion(question: "Deadline and amount info?"),
                      ],
                      scrollBehaviorConfig: const ScrollBehaviorConfig(
                        autoScrollBehavior:
                            AutoScrollBehavior.onUserMessageOnly,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
