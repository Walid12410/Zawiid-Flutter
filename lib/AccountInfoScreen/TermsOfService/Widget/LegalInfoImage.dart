import 'package:flutter/material.dart';

class LegalInformationImage extends StatelessWidget {
  const LegalInformationImage({
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 12,right: 12),
        child: SizedBox(
          width: double.infinity,
          child: Image.asset('assets/img/PrivacyAndTermsImage/TermsofService.png',fit: BoxFit.fill,),
        )
    );
  }
}
