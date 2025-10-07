// language_dropdown.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class LanguageDropdown extends StatefulWidget {
  final VoidCallback? onLanguageChanged;

  const LanguageDropdown({super.key, this.onLanguageChanged});

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  final AppLocalizations _appLocalizations = AppLocalizations();
  String _selectedLanguage = 'en';

  @override
  void initState() {
    super.initState();
    _selectedLanguage = _appLocalizations.currentLanguage;
  }

  void _changeLanguage(String? languageCode) {
    if (languageCode != null) {
      setState(() {
        _selectedLanguage = languageCode;
        _appLocalizations.changeLanguage(languageCode);
        widget.onLanguageChanged?.call();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: _selectedLanguage,
        dropdownColor: Colors.white,
        style: const TextStyle(color: Colors.black, fontSize: 14),
        onChanged: _changeLanguage,
        items: [
          DropdownMenuItem(
            value: 'en',
            child: Row(
              children: [
                const Icon(Icons.language, size: 16),
                const SizedBox(width: 8),
                Text(_appLocalizations.translate('English')),
              ],
            ),
          ),
          DropdownMenuItem(
            value: 'id',
            child: Row(
              children: [
                const Icon(Icons.language, size: 16),
                const SizedBox(width: 8),
                Text(_appLocalizations.translate('Indonesian')),
              ],
            ),
          ),
          DropdownMenuItem(
            value: 'tet',
            child: Row(
              children: [
                const Icon(Icons.language, size: 16),
                const SizedBox(width: 8),
                Text(_appLocalizations.translate('East Timor')),
              ],
            ),
          ),
          DropdownMenuItem(
            value: 'pt',
            child: Row(
              children: [
                const Icon(Icons.language, size: 16),
                const SizedBox(width: 8),
                Text(_appLocalizations.translate('Portuguese')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}