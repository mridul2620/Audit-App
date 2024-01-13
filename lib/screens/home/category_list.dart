import 'dart:convert';
import 'package:audit_app/screens/audit%20report/audit_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../fonts/fonts.dart';
import '../../global_variable.dart';
import '../category_model.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<Category> categories = [];
  bool _isLoading = true;
  late String image;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');
    final response = await http.get(
      Uri.parse(category_api),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData['success'] == true) {
        final categoryList = List<Map<String, dynamic>>.from(jsonData['data']);
        final List<Category> tempCategories = [];

        for (var categoryData in categoryList) {
          final List<Question> questions = List<Question>.from(
              categoryData['questions'].map((questionData) => Question(
                    id: questionData['id'],
                    categoryId: questionData['category_id'],
                    questionNo: questionData['question_no'],
                    questionName: questionData['question_name'],
                  )));

          final category = Category(
              id: categoryData['id'],
              categoryName: categoryData['category_name'],
              questions: questions,
              categoryImage: categoryData['category_image']);

          tempCategories.add(category);
        }

        setState(() {
          categories = tempCategories;
          _isLoading = false;
        });
      }
    } else {
      // Handle API error
    }
  }

  Widget _buildCategoryCard(
      String categoryName, String categoryImage, int index, int id) {
    final image = base + categoryImage;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AuditDetails(
              id: categories[index].id,
              categoryName: categories[index].categoryName,
              category: categories[index],
            ),
          ),
        );
      },
      child: Card(
        elevation: 4, // Adjust the elevation for the shadow
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Image.network(
                  image,
                  width: 25,
                  height: 28,
                ),
              ),
              const SizedBox(width: 10),
              const VerticalDivider(color: bodyColor, thickness: 2,),
              Expanded(
                child: Text(
                  categoryName,
                  style: GoogleFonts.secularOne(
                      textStyle: normalstyle, color: Colors.black),
                ),
              ),
              const SizedBox(width: 10),
              Icon(
                Icons.arrow_forward,
                size: 24,
                color: Colors.green.shade900,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            : ListView.separated(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: categories.length,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 0,
                ),
                itemBuilder: (context, index) {
                  //final category = categories[index];
                  return _buildCategoryCard(
                    categories[index].categoryName,
                    categories[index].categoryImage,
                    index,
                    categories[index].id,
                  );
                  //category['category_name'], category['category_image']);
                },
              ));
  }
}
