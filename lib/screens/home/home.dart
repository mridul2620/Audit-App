import 'package:audit_app/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'banner.dart';
import 'category_list.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      width: double.infinity,
      decoration:const BoxDecoration(color: bodyColor),
      child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(
                delay: const Duration(milliseconds: 100),
                child: const BannerImage()),
            Padding(
              padding: const EdgeInsets.only(left:8, right: 8,),
              child: FadeInDown(
                  delay: const Duration(milliseconds: 100),
                  child: const Categories()),
            ),
          ],
        ),
     
    ));
  }
}
