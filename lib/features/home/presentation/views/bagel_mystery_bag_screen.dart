import 'package:flutter/material.dart';

class BagelMysteryBagScreen extends StatefulWidget {
  static const String routeName = '/bagelMysteryBag';

  const BagelMysteryBagScreen({super.key});

  @override
  State<BagelMysteryBagScreen> createState() => _BagelMysteryBagScreenState();
}

class _BagelMysteryBagScreenState extends State<BagelMysteryBagScreen> {
  bool _reserved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          // Scrollable content
          CustomScrollView(
            slivers: [
              // Hero Image Section
              SliverToBoxAdapter(
                child: _buildHeroSection(context),
              ),

              // White Card Content
              SliverToBoxAdapter(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  transform: Matrix4.translationValues(0, -24, 0),
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildStoreHeader(),
                      const SizedBox(height: 24),
                      _buildPriceBox(),
                      const SizedBox(height: 28),
                      _buildWhatsInBag(),
                      _buildDivider(),
                      _buildInfoRow(icon: Icons.access_time_rounded, iconBg: const Color(0xFFFFF3EC), label: 'Pickup Time', value: '4:00 PM - 11:00 PM', hasArrow: false),
                      _buildDivider(),
                      _buildInfoRow(icon: Icons.location_on_rounded, iconBg: const Color(0xFFFFF3EC), label: 'Location', value: 'The Isle, Juhayna Sq, Sheikh Zayed, Giza 3235142', hasArrow: true),
                      _buildDivider(),
                      _buildInfoRow(icon: Icons.phone_rounded, iconBg: const Color(0xFFFFF3EC), label: 'Contact', value: '+201111303553', hasArrow: true),
                      _buildDivider(),
                      const SizedBox(height: 8),
                      _buildAllergens(),
                      _buildDivider(),
                      const SizedBox(height: 8),
                      _buildCustomerReviews(),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Fixed Reserve Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildReserveButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFC8873A), Color(0xFFE8A855), Color(0xFFB5651D), Color(0xFF8B4513)],
              ),
            ),
          ),

          // Decorative bagel circles
          ..._buildBagelDecorations(),

          // Back button
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            left: 16,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.92),
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 8)],
                ),
                child: const Icon(Icons.arrow_back, size: 20, color: Color(0xFF333333)),
              ),
            ),
          ),

          // Badges
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildBadge(label: '🛍️  Pickup Only', outlined: true),
                const SizedBox(height: 8),
                _buildBadge(label: '🛒  3 Bags left', filled: true),
                const SizedBox(height: 8),
                _buildBadge(label: '📍  2.2 kilometer', outlined: false, light: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildBagelDecorations() {
    final bagels = [
      {'top': 0.15, 'left': 0.08, 'size': 110.0},
      {'top': 0.04, 'left': 0.36, 'size': 130.0},
      {'top': 0.18, 'left': 0.60, 'size': 100.0},
    ];

    return bagels.map((b) {
      final size = b['size'] as double;
      return Positioned(
        top: 280 * (b['top'] as double),
        left: MediaQuery.of(context).size.width * (b['left'] as double),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const RadialGradient(
              center: Alignment(-0.3, -0.3),
              colors: [Color(0xFFD4A055), Color(0xFF8B4513)],
            ),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 16, offset: const Offset(0, 8))],
          ),
          child: Center(
            child: Container(
              width: size * 0.35,
              height: size * 0.35,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFFC8873A), Color(0xFFF5C878)],
                ),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildBadge({required String label, bool outlined = false, bool filled = false, bool light = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: filled ? const Color(0xFFF07B3F) : Colors.white,
        border: outlined ? Border.all(color: const Color(0xFFF07B3F), width: 2) : null,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: filled ? Colors.white : (outlined ? const Color(0xFFF07B3F) : const Color(0xFF555555)),
        ),
      ),
    );
  }

  Widget _buildStoreHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo
        Container(
          width: 62,
          height: 62,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: const LinearGradient(
              colors: [Color(0xFFE8F0FE), Color(0xFFC5D5FB)],
            ),
            border: Border.all(color: const Color(0xFFDDE8FF)),
          ),
          child: const Center(
            child: Text("G's", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF2C4BC9), letterSpacing: -1)),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("G's Bagels & Coffee - Sheikh Zayed", style: TextStyle(fontSize: 13, color: Color(0xFF888888))),
              SizedBox(height: 4),
              Text("Bagel Mystery Bag", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF111111), height: 1.2)),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFBF0),
            border: Border.all(color: const Color(0xFFFFE082)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            children: [
              Icon(Icons.star_rounded, color: Color(0xFFF5A623), size: 16),
              SizedBox(width: 4),
              Text("5.0", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFFF5A623))),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceBox() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("PRICE", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFFAAAAAA), letterSpacing: 1)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F7EE),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text("-53%", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF27AE60))),
              ),
            ],
          ),
          const SizedBox(height: 8),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(text: "35 ", style: TextStyle(fontSize: 38, fontWeight: FontWeight.w900, color: Color(0xFF111111))),
                TextSpan(text: "EGP", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF555555))),
              ],
            ),
          ),
          const SizedBox(height: 4),
          const Text("75 EGP", style: TextStyle(fontSize: 16, color: Color(0xFFBBBBBB), decoration: TextDecoration.lineThrough)),
          const Divider(height: 28, color: Color(0xFFEEEEEE)),
          Row(
            children: [
              Container(
                width: 10, height: 10,
                decoration: const BoxDecoration(color: Color(0xFF27AE60), shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              const Text("3 available", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF333333))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWhatsInBag() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("What's in the bag?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF111111))),
        SizedBox(height: 10),
        Text(
          "Two freshly baked bagels with a surprise twist! Each mystery bag contains two delicious bagels, limited to sesame, plain, and everything varieties — perfect for a tasty snack or sharing.",
          style: TextStyle(fontSize: 15, color: Color(0xFF555555), height: 1.7),
        ),
        SizedBox(height: 28),
      ],
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required Color iconBg,
    required String label,
    required String value,
    required bool hasArrow,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(14)),
            child: Icon(icon, color: const Color(0xFFF07B3F), size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label.toUpperCase(), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFFAAAAAA), letterSpacing: 0.8)),
                const SizedBox(height: 3),
                Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF111111))),
              ],
            ),
          ),
          if (hasArrow) const Icon(Icons.chevron_right, color: Color(0xFFCCCCCC)),
        ],
      ),
    );
  }

  Widget _buildAllergens() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("INGREDIENTS & ALLERGENS", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFFAAAAAA), letterSpacing: 1.2)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF9F9F9),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32, height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFCCCCCC), width: 2),
                ),
                child: const Center(child: Text("?", style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 16, fontWeight: FontWeight.bold))),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  "The shop did not specify allergens. Please contact them to make sure.",
                  style: TextStyle(fontSize: 14, color: Color(0xFF777777), height: 1.6),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildCustomerReviews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.star_border_rounded, color: Color(0xFFDDDDDD), size: 22),
            SizedBox(width: 8),
            Text("Customer Reviews", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF111111))),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF9F9F9),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36, height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFDDDDDD), width: 2),
                ),
                child: const Icon(Icons.access_time, color: Color(0xFFBBBBBB), size: 18),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Coming Soon", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF111111))),
                    SizedBox(height: 4),
                    Text(
                      "Customer reviews will be available soon to help you make informed decisions.",
                      style: TextStyle(fontSize: 13, color: Color(0xFF999999), height: 1.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, color: Color(0xFFF0F0F0));
  }

  Widget _buildReserveButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.white, Colors.white, Colors.transparent],
        ),
      ),
      child: GestureDetector(
        onTap: () => setState(() => _reserved = !_reserved),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _reserved
                  ? [const Color(0xFF27AE60), const Color(0xFF2ECC71)]
                  : [const Color(0xFFF07B3F), const Color(0xFFF5A623)],
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: (_reserved ? const Color(0xFF27AE60) : const Color(0xFFF07B3F)).withOpacity(0.35),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: Text(
              _reserved ? '✓  Reserved! See you at pickup' : 'Reserve for Pickup',
              style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w800, letterSpacing: 0.3),
            ),
          ),
        ),
      ),
    );
  }
}
