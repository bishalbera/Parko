import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parko/common/constants/constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About App'),
      ),
      body: _buildAboutContent(),
    );
  }

  Widget _buildAboutContent() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '$appName',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            const SizedBox(height: 8),
            const Text(
              '$appTagline',
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            const Text(
              'Motive of the App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Text(
                '$aboutTheApp',
                style: GoogleFonts.poppins(),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Version',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              '1.0.0', // Replace this with the actual version of your app
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            const Text(
              'APIs Used',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildBulletPoint('Google Maps API'),
            // Add more APIs if needed

            const SizedBox(height: 24),
            const Text(
              'Working of the app',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Text(
                '$workingOfTheApp',
                style: GoogleFonts.poppins(),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                "Made with 💖 by Adarsh, Armaan and Bishal for Stemist Hacks II.",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            // Add more developers if needed
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 8),
        Icon(Icons.circle, size: 12),
        SizedBox(width: 8),
        Expanded(child: Text(text, style: TextStyle(fontSize: 18))),
      ],
    );
  }
}
