import 'package:flutter/material.dart';
import '../widget/header.dart';
import '../widget/footer.dart';

class ZawaInfoPage extends StatefulWidget {
  const ZawaInfoPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ZawaInfoPageState createState() => _ZawaInfoPageState();
}

class _ZawaInfoPageState extends State<ZawaInfoPage> with SingleTickerProviderStateMixin {
  String? selectedIsland;
  String? selectedRegion;

  final Map<String, List<String>> islandRegions = {
    'Unguja': ['Mjini Magharibi', 'Kusini Unguja', 'Kaskazini Unguja'],
    'Pemba': ['Kaskazini Pemba', 'Kusini Pemba']
  };

  final Map<String, List<String>> zawaCenters = {
    'Mjini Magharibi': ['ZAWA Mwanakwerekwe', 'ZAWA Amani'],
    'Kusini Unguja': ['ZAWA Makunduchi'],
    'Kaskazini Unguja': ['ZAWA Kinyasini'],
    'Kaskazini Pemba': ['ZAWA Wete'],
    'Kusini Pemba': ['ZAWA Mkoani']
  };

  double imageSize = 160;
  double ungujaScale = 1.0;
  double pembaScale = 1.0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          const Header(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Image.asset('assets/zawa_logo.png', height: 100),
                    const SizedBox(height: 12),
                    const Text(
                      "Welcome to ZAWA Customer Service Information across Zanzibar.\nPlease select an area to discover our nearest service center.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 24),

                    // Island Card with Stack
                    Card(
                      elevation: 4,
                      child: SizedBox(
                        width: double.infinity,
                        height: imageSize * 3,
                        child: Stack(
                          children: [
                            // Unguja
                            Positioned(
                              top: 0,
                              right: screenWidth * 0.05,
                              child: Column(
                                children: [
                                  const Text("Unguja", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  GestureDetector(
                                    onTapDown: (_) {
                                      setState(() => ungujaScale = 1.1);
                                    },
                                    onTapUp: (_) {
                                      setState(() {
                                        ungujaScale = 1.0;
                                        selectedIsland = 'Unguja';
                                        selectedRegion = null;
                                      });
                                    },
                                    onTapCancel: () {
                                      setState(() => ungujaScale = 1.0);
                                    },
                                    child: AnimatedScale(
                                      scale: ungujaScale,
                                      duration: const Duration(milliseconds: 200),
                                      child: Image.asset('assets/Unguja.png', width: imageSize),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Pemba
                            Positioned(
                              top: imageSize + 35,
                              left: screenWidth * 0.05,
                              child: Column(
                                children: [
                                  const Text("Pemba", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  GestureDetector(
                                    onTapDown: (_) {
                                      setState(() => pembaScale = 1.1);
                                    },
                                    onTapUp: (_) {
                                      setState(() {
                                        pembaScale = 1.0;
                                        selectedIsland = 'Pemba';
                                        selectedRegion = null;
                                      });
                                    },
                                    onTapCancel: () {
                                      setState(() => pembaScale = 1.0);
                                    },
                                    child: AnimatedScale(
                                      scale: pembaScale,
                                      duration: const Duration(milliseconds: 200),
                                      child: Image.asset('assets/Pemba.png', width: imageSize),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    if (selectedIsland != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Regions in $selectedIsland:',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          ...islandRegions[selectedIsland!]!.map(
                            (region) => ListTile(
                              title: Text(region),
                              onTap: () {
                                setState(() {
                                  selectedRegion = region;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                    if (selectedRegion != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(),
                          Text(
                            'ZAWA Centers in $selectedRegion:',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          ...zawaCenters[selectedRegion!]!.map(
                            (center) => ListTile(title: Text(center)),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
          const Footer(),
        ],
      ),
    );
  }
}
