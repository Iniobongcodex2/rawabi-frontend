import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  // --- DICTIONARY ---
  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'welcome': 'Welcome to Rawabi',
      'subtitle': 'Sign in to manage your business services',
      'email': 'Email',
      'password': 'Password',
      'signIn': 'Sign In',
      'invalidEmail': 'Please enter your email',
      'invalidPassword': 'Please enter your password',
      
      // Navigation
      'home': 'Home',
      'services': 'Services',
      'documents': 'Documents',
      'support': 'Support',
      'profile': 'Profile',
      
      // Dashboard
      'welcomeBack': 'Welcome back,',
      'activeServices': 'Active Services',
      'pending': 'Pending',
      'expiringDocs': 'Expiring Docs',
      'quickActions': 'Quick Actions',
      'mainServices': 'Main Services',
      'requestService': 'Request\nService',
      'uploadDoc': 'Upload\nDoc',
      'bookVideo': 'Book\nVideo',
      
      // Support
      'supportAgents': 'Support & Agents',
      'aiAssistant': 'Rawabi AI Assistant',
      'aiSubtitle': 'Ask me anything about our services',
      'chat': 'Chat',
      'assignedAgent': 'Your Assigned Agent',
      'online': 'Online',
      'call': 'Call',
      'video': 'Video',
      'whatsapp': 'WhatsApp',
      'recentAlerts': 'Recent Alerts',
      'docExpiring': 'Document Expiring Soon',
      'docExpiringSubtitle': 'Your Trade License expires in 30 days.',

      // Services & Documents & Profile
      'ourServices': 'Our Services',
      'docVault': 'Document Vault',
      'addDoc': 'Add Document',
      'transHistory': 'Transaction History',
      'addFunds': 'Add 100 AED',
      'walletBalance': 'Wallet Balance',
      'addedFunds': 'Added funds to wallet',
      'familyStaff': 'Family & Staff',
      'myServices': 'My Services & Agents',
      'security': 'Security',
      'signOut': 'Sign Out',
      'manageStaff': 'Manage dependents and employees',
      'trackRequests': 'Track your active requests',
      'passwords': 'Passwords and biometrics',
      'logout': 'Log out of your account',

      // My Services Screen
      'noServices': 'No services found. Submit a new request!',
      'applicant': 'Applicant',
      'contact': 'Contact',
      'agent': 'Agent',

      // Documents & Family
      'noDocs': 'No documents found. Click + to add.',
      'owner': 'Owner',
      'expires': 'Expires',
      'noMembers': 'No members found. Click + to add one.',
    },
    'ar': {
      'welcome': 'مرحباً بكم في روابي',
      'subtitle': 'تسجيل الدخول لإدارة خدمات الأعمال',
      'email': 'البريد الإلكتروني',
      'password': 'كلمة المرور',
      'signIn': 'تسجيل الدخول',
      'invalidEmail': 'الرجاء إدخال البريد الإلكتروني',
      'invalidPassword': 'الرجاء إدخال كلمة المرور',
      
      // Navigation
      'home': 'الرئيسية',
      'services': 'الخدمات',
      'documents': 'المستندات',
      'support': 'الدعم',
      'profile': 'الملف الشخصي',
      
      // Dashboard
      'welcomeBack': 'مرحباً بعودتك،',
      'activeServices': 'الخدمات النشطة',
      'pending': 'قيد الانتظار',
      'expiringDocs': 'مستندات تنتهي قريباً',
      'quickActions': 'إجراءات سريعة',
      'mainServices': 'الخدمات الرئيسية',
      'requestService': 'طلب\nخدمة',
      'uploadDoc': 'رفع\nمستند',
      'bookVideo': 'حجز\nفيديو',
      
      // Support
      'supportAgents': 'الدعم والوكلاء',
      'aiAssistant': 'مساعد روابي الذكي',
      'aiSubtitle': 'اسألني أي شيء عن خدماتنا',
      'chat': 'محادثة',
      'assignedAgent': 'الوكيل المعين لك',
      'online': 'متصل',
      'call': 'اتصال',
      'video': 'فيديو',
      'whatsapp': 'واتساب',
      'recentAlerts': 'التنبيهات الأخيرة',
      'docExpiring': 'مستند ينتهي قريباً',
      'docExpiringSubtitle': 'رخصة تجارتك تنتهي خلال 30 يوماً.',

      // Services & Documents & Profile
      'ourServices': 'خدماتنا',
      'docVault': 'خزنة المستندات',
      'addDoc': 'إضافة مستند',
      'transHistory': 'سجل المعاملات',
      'addFunds': 'إضافة 100 درهم',
      'walletBalance': 'رصيد المحفظة',
      'addedFunds': 'تمت إضافة أموال للمحفظة',
      'familyStaff': 'العائلة والموظفين',
      'myServices': 'خدماتي والوكلاء',
      'security': 'الأمان',
      'signOut': 'تسجيل الخروج',
      'manageStaff': 'إدارة المعالين والموظفين',
      'trackRequests': 'تتبع طلباتك النشطة',
      'passwords': 'كلمات المرور والبصمات',
      'logout': 'تسجيل الخروج من حسابك',

      // My Services Screen
      'noServices': 'لم يتم العثور على خدمات. قم بتقديم طلب جديد!',
      'applicant': 'مقدم الطلب',
      'contact': 'جهة الاتصال',
      'agent': 'الوكيل',

      // Documents & Family
      'noDocs': 'لم يتم العثور على مستندات. انقر على + للإضافة.',
      'owner': 'المالك',
      'expires': 'ينتهي في',
      'noMembers': 'لم يتم العثور على أعضاء. انقر على + للإضافة.',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]![key] ?? key;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

// This global variable will hold the current language
final ValueNotifier<Locale> appLocale = ValueNotifier(const Locale('en'));