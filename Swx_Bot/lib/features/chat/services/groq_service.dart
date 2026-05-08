// lib/features/chat/services/groq_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:swx_bot/core/constants/app_constants.dart';

class GroqService {
  static Future<String> chat({
    required String userMessage,
    required List<Map<String, String>> history,
    required String faqContext,
  }) async {
    try {
      final messages = [
        {
          'role': 'system',
          'content': '${AppConstants.systemPrompt}\n\nFAQs:\n$faqContext',
        },
        ...history,
      ];

      final response = await http.post(
        Uri.parse('${AppConstants.serverUrl}/api/chat'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'messages': messages}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return data['reply'] as String? ?? 'No response received.';
      } else {
        return '⚠️ Server error: ${response.statusCode}';
      }
    } catch (e) {
      return '⚠️ Connection failed. Please check your network and try again.';
    }
  }
}
