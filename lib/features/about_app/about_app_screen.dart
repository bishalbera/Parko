import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFeaturesScreen extends StatelessWidget {
  const AppFeaturesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Features'),
      ),
      body: _buildAppFeaturesContent(),
    );
  }

  Widget _buildAppFeaturesContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepSection(),
          SizedBox(height: 32),
          _buildFeatureSection(),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildStepSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Getting Started:',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        SizedBox(height: 16),
        _buildStep('Step 1:',
            'Register with your profile picture, name, email, and password.'),
        _buildStep('Step 2:',
            'Access the home screen and search for various locations (routes).'),
        _buildStep('Step 3:',
            'Get the best and most efficient route to your destination.'),
        _buildStep('Step 4:',
            'Rent a parking spot or list your parking spot for rent.'),
        _buildStep(
            'Step 5:', 'View your booking history and profile information.'),
        _buildStep(
            'Step 6:', 'Get gift cards and earn points for using the app.'),
      ],
    );
  }

  Widget _buildStep(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo),
        ),
        SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildFeatureSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'App Features:',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        SizedBox(height: 16),
        _buildFeatureTile(
            'Route Search', 'Find the best routes to your destination.'),
        _buildFeatureTile(
            'Parking Spot Rental', 'Rent or list your parking spot for rent.'),
        _buildFeatureTile(
            'Booking History', 'View your past bookings and history.'),
        _buildFeatureTile(
            'Profile', 'View and manage your profile information.'),
        _buildFeatureTile('Gift Cards and Points',
            'Earn points and use gift cards for rewards.'),
        const SizedBox(
          height: 30,
        ),
        Center(
          child: Text(
            "App Version: 1.0.0",
            style: GoogleFonts.poppins(color: Colors.grey, fontSize: 18),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureTile(String title, String description) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        description,
        style: const TextStyle(fontSize: 18),
      ),
      leading: const Icon(Icons.check_circle, color: Colors.green, size: 32),
    );
  }
}
