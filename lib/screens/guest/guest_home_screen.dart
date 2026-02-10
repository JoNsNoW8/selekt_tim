import 'package:flutter/material.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';

class GuestHomeScreen extends StatelessWidget {
  const GuestHomeScreen({super.key});

  final List<String> imgList = const [
    'https://images.unsplash.com/photo-1548550023-2bdb3c5beed7?q=80&w=1000', 
    'https://images.unsplash.com/photo-1516467508483-a7212febe31a?q=80&w=1000', 
    'https://images.unsplash.com/photo-1500382017468-9049fed747ef?q=80&w=1000', 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Slideshow ---
            CarouselSlider(
              options: CarouselOptions(
                height: 250.0,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 1.0,
              ),
              items: imgList.map((imageUrl) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            ),

            Padding(
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
                  const SizedBox(height: 15),
                  const Text(
                    'O kompaniji',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'SelektTim se bavi unapređenjem stočarstva kroz precizno praćenje podataka o grlima. '
                    'Naša misija je da gazdinstvima i radnicima na terenu omogućimo brz i lak pristup '
                    'ključnim informacijama o poreklu i zdravlju životinja.',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 30),
                  
                  const Text(
                    'Kontaktirajte nas',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: const Icon(Icons.email, color: Color(0xFF4F1516)),
                    title: const Text('office@selekcijskakuca.rs'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone, color: Color(0xFF4F1516)),
                    title: const Text('025 421 830'),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}