import 'package:flutter/material.dart';
import 'package:music_player/presentation/settings_screen/view/privacy_screen.dart';
import 'package:music_player/presentation/settings_screen/view/terms_and_conditions.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text("SETTINGS"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PrivacyScreen(),
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text("Privacy and policy"),
              )),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TermsAndConditions(),
                ));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Text("Terms And Conditions"),
              )),
        ],
      ),
    );
  }
}
