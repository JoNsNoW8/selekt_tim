import 'package:flutter/material.dart';

class GuestHomeScreen extends StatelessWidget {
  const GuestHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dobrodošli u SelektTim',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4F1516),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'O kompaniji',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            const Text(
              'SelektTim se bavi unapređenjem stočarstva kroz precizno praćenje podataka o grlima. '
              'Naša misija je da farmerima i radnicima na terenu omogućimo brz i lak pristup '
              'ključnim informacijama o poreklu i zdravlju životinja.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor '
              'incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud '
              'exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
