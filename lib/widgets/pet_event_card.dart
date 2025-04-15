import 'package:flutter/material.dart';

class PetEventCard extends StatelessWidget {
  final String imageUrl;
  final String eventTitle;
  final DateTime eventDate;
  final String eventTime;
  final VoidCallback onParticipate;
  final VoidCallback onJoinAsVisitor;
  final VoidCallback onTermsAndPolicy;

  const PetEventCard({
    Key? key,
    required this.imageUrl,
    required this.eventTitle,
    required this.eventDate,
    required this.eventTime,
    required this.onParticipate,
    required this.onJoinAsVisitor,
    required this.onTermsAndPolicy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Event Image
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.pets, size: 64, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Event Title
                Text(
                  eventTitle,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Event Date and Time
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.orange[700], size: 18),
                    const SizedBox(width: 8),
                    Text(
                      '${_formatDate(eventDate)}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.access_time, color: Colors.orange[700], size: 18),
                    const SizedBox(width: 8),
                    Text(
                      eventTime,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onParticipate,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[700],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('Participate in Event'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onJoinAsVisitor,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.orange[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Colors.orange[700]!),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('Join as Visitor'),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 8),
                
                // Terms and Policy
                Center(
                  child: TextButton(
                    onPressed: onTermsAndPolicy,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey[700],
                      minimumSize: Size.zero,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Terms and Policy',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    // Format date as you prefer, e.g., "April 15, 2025"
    List<String> months = [
      'January', 'February', 'March', 'April', 'May', 'June', 
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

// Example usage:
class PetEventScreen extends StatelessWidget {
  const PetEventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Events'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PetEventCard(
          imageUrl: 'https://example.com/pet_event_image.jpg',
          eventTitle: 'Annual Dog Show & Contest',
          eventDate: DateTime(2025, 5, 15),
          eventTime: '10:00 AM - 4:00 PM',
          onParticipate: () {
            // Handle participate action
            print('User wants to participate');
          },
          onJoinAsVisitor: () {
            // Handle join as visitor action
            print('User wants to join as visitor');
          },
          onTermsAndPolicy: () {
            // Show terms and policy
            print('User wants to see terms and policy');
          },
        ),
      ),
    );
  }
}