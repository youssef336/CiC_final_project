import 'package:flutter/material.dart';

class BagDetailsView extends StatelessWidget {
  const BagDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body: Column(
    children: [

      /// 🔹 الصورة فوق
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.45,
        width: double.infinity,
        child: Image.asset(
          "assets/images/onboarding_image1.jpg",
          fit: BoxFit.cover,
        ),
      ),

      /// 🔹 الجزء الأبيض
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Row(
                      children: [
                        Text("5.0",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        SizedBox(width: 5),
                        Icon(Icons.star, color: Colors.amber),
                      ],
                    ),
                    Text(
                      "مستري باج عروسة",
                      style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                const Text(
                  "السعر",
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 10),

                const Text(
                  "50 ج.م",
                  style: TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),

                const Text(
                  "100 ج.م",
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  "ماذا في الشنطة؟",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                const Text(
                  "ساندوتش عروسة واحد معمول بعيش شامي، معاه بطاطس مقرمشة ومشروب منعش.",
                  style: TextStyle(height: 1.5, color: Colors.grey),
                ),

                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "احجز للاستلام",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  ),
);
  }
}