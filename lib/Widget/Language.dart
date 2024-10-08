import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import '../provider/Localization_Provider.dart';

class LanguageChangeDialog extends StatefulWidget {
  const LanguageChangeDialog({super.key});

  @override
  State<LanguageChangeDialog> createState() => _LanguageChangeDialogState();
}

class _LanguageChangeDialogState extends State<LanguageChangeDialog> {
  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return AlertDialog(
      title: Text(
        'Select Language',
        style: TextStyle(
            fontSize: 15.sp, color: tdBlack, fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: L10n.supportedLocales.map((locale) {
          return ListTile(
            title: Text(
              L10n.getLanguageCode(locale),
              style: TextStyle(fontSize: 12.sp, color: tdBlack),
            ),
            onTap: () async {
              await localeProvider.setLocale(locale);
              setState(() {
                Navigator.of(context).pop();
              });
            },
          );
        }).toList(),
      ),
    );
  }
}
