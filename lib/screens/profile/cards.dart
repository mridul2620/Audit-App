import 'package:audit_app/global_variable.dart';
import 'package:audit_app/screens/profile/plans_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardItem extends StatelessWidget {
  final bool isSelected;
  final CardData cardData;

  CardItem({
    required this.isSelected,
    required this.cardData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15)),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 1.0,
                  spreadRadius: 1.0,
                ),
              ]
            : [],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 24, bottom: 24, left: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            cardData.plan,
            style: GoogleFonts.inter(
                color: isSelected ? Colors.black : Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cardData.price,
                style: GoogleFonts.inter(
                  color: isSelected ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 45,
                ),
              ),
              Text(
                "*",
                style: GoogleFonts.inter(
                  color: isSelected ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              cardData.type,
              style: GoogleFonts.inter(
                color: isSelected ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(height: 50),
          Container(
            width: 218,
            height: 45,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: ElevatedButton(
              onPressed: () {},
              child: Row(
                children: [
                  Text(
                    'Upgrade To ${cardData.plan}',
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.white,
                  )
                ],
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  isSelected ? maincolor : Colors.blue,
                ),
              ),
            ),
          ),
          SizedBox(height: 50),
          Row(
            children: [
              Icon(
                Icons.arrow_circle_right,
                color: maincolor,
                size: 12,
              ),
              SizedBox(
                width: 2,
              ),
              Text(
                cardData.number,
                style: GoogleFonts.inter(
                  color: isSelected ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Icon(
                Icons.arrow_circle_right,
                color: maincolor,
                size: 12,
              ),
              SizedBox(
                width: 2,
              ),
              Text(
                "Admin Panel",
                style: GoogleFonts.inter(
                  color: isSelected ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Icon(
                Icons.arrow_circle_right,
                color: maincolor,
                size: 12,
              ),
              SizedBox(
                width: 2,
              ),
              Text(
                "Email Support",
                style: GoogleFonts.inter(
                  color: isSelected ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: 25),
          Text(
            "*Terms & Conditions Applied",
            style: GoogleFonts.inter(
              color: isSelected ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ]),
      ),
    );
  }
}
