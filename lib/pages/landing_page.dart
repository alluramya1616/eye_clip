import 'package:flutter/material.dart';
import '../widgets/glassmorphic_container.dart';
import '../widgets/custom_button.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Enhanced gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF64B5F6), // Light blue
                  Color(0xFFE3F2FD), // Very light blue
                  Color(0xFFFFFFFF), // White
                ],
                stops: [0.0, 0.5, 1.0],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 40),
                          
                          // App Title
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  'AI-Powered',
                                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                    fontWeight: FontWeight.w300,
                                    color: const Color(0xFF1565C0),
                                    fontSize: 32,
                                  ),
                                ),
                                Text(
                                  'Glaucoma Assistant',
                                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF0D47A1),
                                    fontSize: 36,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  width: 80,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF42A5F5),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          const SizedBox(height: 40),
                          
                          // Main Content Card
                          GlassmorphicContainer(
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Introduction
                                  Text(
                                    'Advanced AI Technology for Glaucoma Care',
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF1565C0),
                                      fontSize: 22,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  
                                  Text(
                                    'Our cutting-edge application harnesses the power of Generative AI to revolutionize glaucoma detection and monitoring. Using advanced machine learning algorithms, we provide healthcare professionals with precise Optic Disc segmentation and Visual Field progression analysis from fundus images.',
                                    style: TextStyle(
                                      fontSize: 16,
                                      height: 1.6,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  
                                  const SizedBox(height: 32),
                                  
                                  // Features Section
                                  Text(
                                    'Key Features',
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF1565C0),
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  
                                  // Feature List
                                  _buildFeatureItem(
                                    Icons.visibility_outlined,
                                    'Automated Optic Disc Segmentation',
                                    'Precise AI-driven identification and analysis of optic disc boundaries',
                                  ),
                                  _buildFeatureItem(
                                    Icons.trending_up_outlined,
                                    'Visual Field Progression Tracking',
                                    'Advanced algorithms to monitor and predict VF changes over time',
                                  ),
                                  _buildFeatureItem(
                                    Icons.quiz_outlined,
                                    'Visual Question Answering',
                                    'Interactive AI assistant for multimodal optic nerve imaging analysis',
                                  ),
                                  _buildFeatureItem(
                                    Icons.security_outlined,
                                    'Secure & HIPAA Compliant',
                                    'Enterprise-grade security ensuring patient data protection',
                                  ),
                                  _buildFeatureItem(
                                    Icons.speed_outlined,
                                    'Real-time Analysis',
                                    'Instant results with high accuracy for efficient clinical workflow',
                                  ),
                                  _buildFeatureItem(
                                    Icons.smartphone_outlined,
                                    'Intuitive Mobile Interface',
                                    'User-friendly design optimized for healthcare professionals',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Call to Action Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/detection');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1565C0),
                        foregroundColor: Colors.white,
                        elevation: 8,
                        shadowColor: const Color(0xFF1565C0).withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.play_arrow_rounded, size: 24),
                          const SizedBox(width: 8),
                          Text(
                            'Start Glaucoma Detection',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFeatureItem(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF42A5F5).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF1565C0),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1565C0),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}