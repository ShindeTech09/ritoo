import 'package:flutter/material.dart';

// Simple FooterWidget for demonstration

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(Icons.store, color: Colors.blue.shade700),
              const SizedBox(width: 8),
              Text(
                'RitoVerse Pvt. Ltd.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.facebook, color: Colors.blue),
                onPressed: () {},
                tooltip: 'Facebook',
              ),
              IconButton(
                icon: const Icon(Icons.camera_alt, color: Colors.purple),
                onPressed: () {},
                tooltip: 'Instagram',
              ),
              IconButton(
                icon: const Icon(
                  Icons.alternate_email,
                  color: Colors.lightBlue,
                ),
                onPressed: () {},
                tooltip: 'Twitter',
              ),
              IconButton(
                icon: const Icon(Icons.play_circle_fill, color: Colors.red),
                onPressed: () {},
                tooltip: 'YouTube',
              ),
            ],
          ),
          const SizedBox(height: 8),
          LayoutBuilder(
            builder: (context, constraints) {
              // Use Wrap for responsiveness. If the screen is too narrow,
              // items will wrap to the next line.
              return Wrap(
                alignment: WrapAlignment.center, // Center items horizontally
                spacing: 8.0, // Horizontal space between items
                runSpacing: 4.0, // Vertical space between lines
                children: [
                  TextButton(onPressed: () {}, child: const Text('About Us')),
                  TextButton(onPressed: () {}, child: const Text('Contact')),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Privacy Policy'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Terms of Service'),
                  ),
                  TextButton(onPressed: () {}, child: const Text('Careers')),
                ],
              );
            },
          ),
          const SizedBox(height: 8),
          Text(
            '© 2025 RetoVerse. All rights reserved.',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
