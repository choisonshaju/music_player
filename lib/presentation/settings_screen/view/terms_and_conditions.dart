import 'package:flutter/material.dart';
import 'package:music_player/core/constant/Textstyle.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms And Conditions"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "License Grant",
                style: heading(),
              ),
              Text(
                  "\nUsers are granted a limited, non-exclusive, non-transferable license to use the app for personal, non-commercial purposes, subject to these terms."),
              Text("\nRestrictions", style: heading()),
              Text(
                  "\nUsers may not reverse engineer, decompile, disassemble, or attempt to derive the source code of the app. They also may not modify, adapt, translate, or create derivative works based upon the app."),
              Text("\nContent", style: heading()),
              Text(
                  "\nUsers are responsible for the content they access or upload through the app. The app may allow access to third-party content, and users agree to comply with any applicable terms or licenses associated with such content."),
              Text("\nPrivacy", style: heading()),
              Text(
                  "\nThe app may collect and use personal information as outlined in the app's Privacy Policy. Users should review the Privacy Policy to understand how their information is collected, used, and shared."),
              Text("\nUpdates", style: heading()),
              Text(
                  "\nThe app developer may release updates or patches to improve functionality or security. Users may be required to install these updates to continue using the app."),
              Text("\nDisclaimer of Warranty", style: heading()),
              Text(
                  "\nThe app is provided ${"as is"} without warranties of any kind. The app developer does not warrant that the app will be error-free or uninterrupted."),
              Text("\nLimitation of Liability", style: heading()),
              Text(
                  "\nTo the fullest extent permitted by law, the app developer shall not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues."),
              Text("\nGoverning Law", style: heading()),
              Text(
                  "\nThese terms shall be governed by and construed in accordance with the laws of [Jurisdiction], without regard to its conflict of law principles."),
              Text("\nChanges to Terms", style: heading()),
              Text(
                  "\nThe app developer reserves the right to update or modify these terms and conditions at any time. Users will be notified of changes through the app or via other reasonable means."),
              Text("\nContact Information", style: heading()),
              Text(
                  "\nUsers can contact the app developer regarding any questions or concerns about these terms and conditions at choisonshaju007@gmail.com."),
            ],
          ),
        ),
      ),
    );
  }
}
