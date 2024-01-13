import 'package:audit_app/global_variable.dart';
import 'package:audit_app/screens/home/homepage.dart';
import 'package:flutter/material.dart';
import 'cards.dart';
import 'plans_model.dart';

class SubscriptionPage extends StatefulWidget {
  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  int _currentIndex = 0;
  final List<CardData> cardDataList = [
    CardData(
        plan: 'Starter Plan',
        //title: 'Basic',
        price: '\₹300',
        type: "user/month",
        number: "500 free Reports"),
    CardData(
        plan: 'Monthly Plan',
        //title: 'Pro',
        price: '\₹50,000',
        type: "per month",
        number: "2000 free Reports"),
    CardData(
        plan: 'Yearly Plan',
        //title: 'Premium',
        price: '\₹90,000',
        type: "per year",
        number: "10000 free Reports"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bodyColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Image.asset(
            'assets/logo.png',
            width: 141,
            height: 31,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            },
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  SizedBox(
                    height: 450,
                    child: PageView.builder(
                      itemCount: cardDataList.length, // Number of cards
                      controller: PageController(viewportFraction: 0.88),
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        // Pass the card data from the list
                        return CardItem(
                          isSelected: index == _currentIndex,
                          cardData: cardDataList[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
