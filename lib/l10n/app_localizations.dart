// app_localization.dart
import 'dart:ui';

class AppLocalizations {
  static AppLocalizations? _instance;
  String _currentLanguage = 'en';
  VoidCallback? onLanguageChanged;

  factory AppLocalizations() {
    _instance ??= AppLocalizations._internal();
    return _instance!;
  }

  AppLocalizations._internal();

  static AppLocalizations get instance => AppLocalizations();

  void changeLanguage(String languageCode) {
    _currentLanguage = languageCode;
    onLanguageChanged?.call();
  }

  String get currentLanguage => _currentLanguage;

  // Contoh metode translasi
  String translate(String key) {
    switch (_currentLanguage) {
      case 'en':
        return _englishTranslations[key] ?? key;
      case 'id':
        return _indonesianTranslations[key] ?? key;
      case 'tet':
        return _eastTimorTranslations[key] ?? key;
      case 'pt':
        return _portugueseTranslations[key] ?? key;
      default:
        return key;
    }
  }

  // Kamus terjemahan (tetap sama seperti sebelumnya)
  static final Map<String, String> _englishTranslations = {
    "appTitle": "Dashboard",
    "add": "Add",
    "details": "Details",
    "address": "Address",
    "village": "Village",
    "waterMeterID": "Water Meter ID",
    "totalToday": "Total Today",
    'Language': 'Language',
    'English': 'English',
    'Indonesian': 'Indonesian',
    'East Timor': 'East Timor',
    'Portuguese': 'Portuguese',
  };

  static final Map<String, String> _indonesianTranslations = {
    "appTitle": "Dashboard",
    "add": "Tambah",
    "details": "Rincian",
    "address": "Alamat",
    "village": "Desa",
    "waterMeterID": "ID Meteran",
    "totalToday": "Total Hari Ini",
    'Language': 'Bahasa',
    'English': 'Inggris',
    'Indonesian': 'Indonesia',
    'East Timor': 'Timor Leste',
    'Portuguese': 'Portugis',
  };

  static final Map<String, String> _eastTimorTranslations = {
    "appTitle": "Painel",
    "add": "Aumenta",
    "details": "Detálhus",
    "address": "Adresu",
    "village": "Aldeia",
    "waterMeterID": "ID Medidor Bee",
    "totalToday": "Total Ohin",
    'Language': 'Lingua',
    'English': 'Ingles',
    'Indonesian': 'Indonzia',
    'East Timor': 'Timor Leste',
    'Portuguese': 'Portugés',
  };

  static final Map<String, String> _portugueseTranslations = {
    "appTitle": "Painel",
    "add": "Adicionar",
    "details": "Detalhes",
    "address": "Endereço",
    "village": "Aldeia",
    "waterMeterID": "ID do Medidor de Água",
    "totalToday": "Total de Hoje",
    'Language': 'Idioma',
    'English': 'Inglês',
    'Indonesian': 'Indonésio',
    'East Timor': 'Timor-Leste',
    'Portuguese': 'Português',
  };
}