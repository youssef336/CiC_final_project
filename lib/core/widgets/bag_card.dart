import 'package:flutter/material.dart';

class BagCard extends StatelessWidget {
  final String title;
  final double price;
  final double oldPrice;
  final int bagsLeft;
  final double rating;

  final bagItemModel;
  const BagCard({
    super.key,
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.bagsLeft,
    required this.rating,
    required this.bagItemModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      margin: const EdgeInsets.only(left: 16, bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 14,
                      color: Color.fromARGB(255, 255, 153, 0),
                    ),
                    const SizedBox(width: 4),
                    Text(rating.toString()),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Text(
            "$oldPrice EGP",
            style: const TextStyle(
              decoration: TextDecoration.lineThrough,
              color: Colors.grey,
            ),
          ),

          Text(
            "$price EGP",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),

          const Spacer(),

          Text(
            "$bagsLeft Bags left",
            style: const TextStyle(color: Colors.orange),
          ),

          const SizedBox(height: 10),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Reserve",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
