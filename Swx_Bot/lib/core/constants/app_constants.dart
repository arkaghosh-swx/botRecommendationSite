// lib/core/constants/app_constants.dart
class AppConstants {

static const String serverUrl = 'https://botrecommendationsite-production.up.railway.app';

  // ── Supabase ─────────────────────────────────────────────
  static const String supabaseUrl = 'https://sbzoxwvuoidtywvkabmz.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNiem94d3Z1b2lkdHl3dmthYm16Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzYxNDYzNTAsImV4cCI6MjA5MTcyMjM1MH0.IrfSKiuShXz0RA26fn5NFUS-VLk3mQAwJoSu28prju4';

  // ── App Info ─────────────────────────────────────────────
  static const String appName = 'Swx AI';
  static const String appTagline = 'Your Health Assistant';
  static const String botName = 'Swx';
  static const String clinicName = 'Warrior Homoeopath';

  // ── System Prompt ────────────────────────────────────────
  static const String systemPrompt = '''
You are Swx — the official AI assistant for Warrior Homoeopath.

ABOUT WARRIOR HOMOEOPATH:
- A global collective of licensed Homoeopaths led by Dr Gayatri
- Practitioners across India, UAE, and UK
- Website: https://warriorhomeopath.com
- Book consultations: https://warriorhomoeopath.dayschedule.com
- Appointments: appointment@warriorhomoeopath.com
- Enquiries: ask@warriorhomoeopath.com
- India: +91 9071961355 | UK: +44 7700 148710

CONDITIONS TREATED:
Skin (eczema, psoriasis, acne, vitiligo), chronic (migraines, PCOS), digestive (SIBO, IBS), mental health (anxiety, depression, sleep), autoimmune (rheumatoid arthritis, lupus), men's health (BPH, infertility), women's health (PCOS, menopause), respiratory (asthma, sinusitis), autism spectrum, veterans (PTSD, chronic pain), diabetes, osteoarthritis.

CONSULTATIONS & PRICING:
- All online via Zoom/Google Meet/Teams
- International: First £150, Follow-up £75, Urgent £50
- India: First ₹5,000, Follow-up ₹1,500, Urgent ₹1,000
- Medicines NOT included

YOUR CAPABILITIES:
✅ CAN: answer questions, share links, explain services, guide users
❌ CANNOT: send emails, book appointments directly, make calls, remember past sessions

CRITICAL RULES:
1. NEVER pretend to send emails or book appointments
2. NEVER ask for personal information — you cannot use it
3. Booking link: https://warriorhomoeopath.dayschedule.com
4. Website: https://warriorhomeopath.com
5. Contact: ask@warriorhomoeopath.com
6. NEVER diagnose or prescribe
7. Emergencies → "Please call emergency services or go to hospital immediately"
8. Off-topic requests (PPT, coding etc.) → politely decline and redirect to health topics
9. Keep responses SHORT — 2-4 sentences max
10. Always read full conversation context before responding

TONE: Calm, warm, professional. Like a trusted medical receptionist.
''';


  // ── Quick Actions ────────────────────────────────────────
  static const List<Map<String, String>> quickActions = [
    {'label': 'About us', 'question': 'What is Warrior Homoeopath?'},
    {'label': 'Consultation', 'question': 'How are consultations conducted?'},
    {'label': 'Conditions', 'question': 'What conditions do you treat?'},
    {'label': 'Safety', 'question': 'Is homoeopathy safe?'},
    {'label': 'Book consultation', 'question': 'How do I book a consultation?'},
  ];

  // ── Suggestion Cards ─────────────────────────────────────
  static const List<Map<String, String>> suggestionCards = [
    {
      'icon': 'doctor',
      'title': 'About us',
      'subtitle': 'Understand our approach',
      'question': 'What is Warrior Homoeopath?',
    },
    {
      'icon': 'video',
      'title': 'Consultation process',
      'subtitle': 'How online consultation works',
      'question': 'How are consultations conducted?',
    },
    {
      'icon': 'heart',
      'title': 'Conditions treated',
      'subtitle': 'Chronic & complex cases',
      'question': 'What conditions do you treat?',
    },
    {
      'icon': 'calendar',
      'title': 'Book consultation',
      'subtitle': 'Start your treatment journey',
      'question': 'How do I book a consultation?',
    },
  ];

  // ── Recommendations Map ──────────────────────────────────
  static const Map<String, List<String>> recoMap = {
    'consultation': [
      'How are consultations conducted?',
      'Is consultation private?',
      'How do I book a consultation?',
    ],
    'treatment': [
      'What conditions do you treat?',
      'How long does treatment take?',
      'Is treatment personalised?',
    ],
    'safety': [
      'Is homoeopathy safe?',
      'Can children take treatment?',
      'Any side effects?',
    ],
    'default': [
      'What is Warrior Homoeopath?',
      'How does it work?',
      'How do I get started?',
    ],
  };

  // ── Stats ────────────────────────────────────────────────
  static const List<Map<String, String>> stats = [
    {'value': '1:1', 'label': 'Personalised care'},
    {'value': '100%', 'label': 'Private consultations'},
    {'value': '24/7', 'label': 'Always available guidance'},
  ];

  // ── Initial bot greeting ─────────────────────────────────
  static const String initialGreeting =
      "Hello 👋 I'm Swx.\nHow can I help you with your health concerns or consultation?";

  // ── Max conversation history to send to API ──────────────
  static const int maxHistoryLength = 20;

  // ── Toast duration ───────────────────────────────────────
  static const int toastDurationMs = 2600;
}
