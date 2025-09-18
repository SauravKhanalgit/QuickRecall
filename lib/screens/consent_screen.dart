import 'package:QUICKRECALL/core/utils/prefs_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../screens/flashcard_screen.dart';

class ConsentScreen extends StatefulWidget {
  @override
  _ConsentScreenState createState() => _ConsentScreenState();
}

class _ConsentScreenState extends State<ConsentScreen> {
  bool isAgreed = false;

  @override
  void initState() {
    super.initState();
    _checkConsent();
  }

  // Check if consent has already been given
  Future<void> _checkConsent() async {
    bool consentGiven = await PrefsHelper.getConsent();
    if (consentGiven) {
      _goToHome();
    }
  }

  // Save user consent
  Future<void> _saveConsent() async {
    await PrefsHelper.setConsent(true);
  }

  // Accept consent and navigate to home screen
  void _acceptConsent() async {
    await _saveConsent();
    _goToHome();
  }

  void _goToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => QUICKRECALLcreen()),
    );
  }

  // Open privacy policy link
  void _launchPrivacyPolicy() async {
    const url =
        'https://aedizz.com/apps/QUICKRECALL/privacy-policy'; // Replace with actual URL
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not open privacy policy link.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Terms & Conditions')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Allows scrolling if content overflows
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "QUICKRECALL - Privacy Policy\n\n"
                "Effective Date: April 31, 2025\n"
                "Contact Us: support@aedizz.com\n\n"
                "Your privacy is important to us. This Privacy Policy explains how we handle your data.\n\n"
                "1. Data Collection\n"
                "- We collect minimal personal data, such as your name, email, and preferences.\n"
                "- Some features may require access to flashcard activity and general usage data.\n"
                "- We do not sell or share your personal data with third parties for advertising purposes.\n\n"
                "2. Usage of Data\n"
                "- Your data is used to enhance app functionality, including flashcard saving, progress tracking, and personalization.\n"
                "- It helps personalize features and provide insights based on your usage.\n"
                "- Your information is processed securely and only for necessary purposes.\n\n"
                "3. Third-Party Services\n"
                "- We use Firebase for secure cloud storage, user authentication, and notifications.\n"
                "- We use Hive for storing QUICKRECALL locally on your device.\n"
                "- We use Start.io to display ads; it may collect anonymous data (like device info and usage stats) to serve relevant ads.\n"
                "- These services are integrated to improve your experience and keep the app functional.\n\n"
                "4. User Control & Data Management\n"
                "- You have full control over your data.\n"
                "- You can request to delete your account or change personal settings via the app support section.\n"
                "- For help, contact us at support@aedizz.com.\n\n"
                "5. Security & Protection\n"
                "- We use encryption, secure authentication, and up-to-date cloud-based measures to protect your information.\n"
                "- Regular security updates are applied to ensure strong protection.\n\n"
                "6. Changes to the Privacy Policy\n"
                "- This Privacy Policy may be updated when needed.\n"
                "- Users will be notified through the app in case of significant changes.\n"
                "- Continued use of the app means acceptance of any revised policy terms.\n",
                style: TextStyle(fontSize: 14),
              ),
              GestureDetector(
                onTap: _launchPrivacyPolicy,
                child: Text(
                  "Read Full Privacy Policy",
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: 20),
              CheckboxListTile(
                title: Text("I agree to the terms & conditions"),
                value: isAgreed,
                onChanged: (value) {
                  setState(() {
                    isAgreed = value ?? false;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: isAgreed ? _acceptConsent : null,
                child: Text("Continue"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
