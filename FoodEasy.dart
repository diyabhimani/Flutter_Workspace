import 'package:flutter/material.dart';

class FoodEasy extends StatefulWidget {
  const FoodEasy({super.key});

  @override
  State<FoodEasy> createState() => _FoodEasyState();
}

class _FoodEasyState extends State<FoodEasy> {
  int pizza = 0;
  int burger = 0;
  int sandwich = 0;
  int drink = 0;

  int pizzaPrice = 120;
  int burgerPrice = 50;
  int sandwichPrice = 80;
  int drinkPrice = 40;

  int total = 0;
  double gst = 0;
  double grandTotal = 0;

  void calculateBill() {
    total =
        (pizza * pizzaPrice) +
            (burger * burgerPrice) +
            (sandwich * sandwichPrice) +
            (drink * drinkPrice);

    gst = total * 0.05;
    grandTotal = total + gst;
  }

  void showBill() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "BILL",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Divider(),

                billRow("Subtotal", total.toDouble()),
                billRow("GST (5%)", gst),

                const Divider(),

                billRow("Grand Total", grandTotal, bold: true),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget billRow(String name, double amount, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          "₹ ${amount.toStringAsFixed(2)}",
          style: TextStyle(
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget foodBox(
      String name,
      IconData icon,
      int price,
      int qty,
      VoidCallback add,
      VoidCallback remove,
      ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(icon, size: 40),
            Text(name,
                style:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text("Price : ₹ $price",
                style: const TextStyle(color: Colors.grey)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: remove, icon: const Icon(Icons.remove)),
                Text(qty.toString()),
                IconButton(onPressed: add, icon: const Icon(Icons.add)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FAST FOOD"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(10),
        children: [
          foodBox("Pizza", Icons.local_pizza, pizzaPrice, pizza, () {
            setState(() {
              pizza++;
              calculateBill();
            });
          }, () {
            setState(() {
              if (pizza > 0) pizza--;
              calculateBill();
            });
          }),

          foodBox("Burger", Icons.lunch_dining, burgerPrice, burger, () {
            setState(() {
              burger++;
              calculateBill();
            });
          }, () {
            setState(() {
              if (burger > 0) burger--;
              calculateBill();
            });
          }),

          foodBox("Sandwich", Icons.fastfood, sandwichPrice, sandwich, () {
            setState(() {
              sandwich++;
              calculateBill();
            });
          }, () {
            setState(() {
              if (sandwich > 0) sandwich--;
              calculateBill();
            });
          }),

          foodBox("Cold Drink", Icons.local_drink, drinkPrice, drink, () {
            setState(() {
              drink++;
              calculateBill();
            });
          }, () {
            setState(() {
              if (drink > 0) drink--;
              calculateBill();
            });
          }),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total : ₹ $total",
                style: const TextStyle(fontSize: 18)),
            ElevatedButton(
              onPressed: total > 0 ? showBill : null,
              child: const Text("Bill"),
            ),
          ],
        ),
      ),
    );
  }
}
