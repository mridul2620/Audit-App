import 'package:audit_app/screens/rework/questions/tabview.dart';
import 'package:audit_app/screens/rework/rework_category_model.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../fonts/fonts.dart';
import '../../global_variable.dart';
import 'school_list_rework_provider.dart';

class ReworkCategory extends StatelessWidget {
  final List<ReworkCategoryModel> categoryList;
  const ReworkCategory({required this.categoryList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/logo.png',
          width: 141,
          height: 31,
        ),
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 20,
              color: Colors.black,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: categoryList.length,
          itemBuilder: (context, index) {
            final list = categoryList[index];
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => FutureBuilder(
                          future: Provider.of<ReworkPageState>(context,
                                  listen: false)
                              .fetchAuditReportDetails(list.auditId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return ReworkQuesTab(
                                completedList: Provider.of<ReworkPageState>(
                                        context,
                                        listen: false)
                                    .completedList,
                                pendingList: Provider.of<ReworkPageState>(
                                        context,
                                        listen: false)
                                    .pendingList,
                              );
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Scaffold(
                                appBar: AppBar(
                                  backgroundColor: Colors.white,
                                  title: Image.asset(
                                    'assets/logo.png',
                                    width: 141,
                                    height: 31,
                                  ),
                                  centerTitle: true,
                                ),
                                body: Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: maincolor,
                                    valueColor: AlwaysStoppedAnimation(
                                        Color.fromARGB(255, 220, 216, 216)),
                                    strokeWidth: 4,
                                  ),
                                ),
                              );
                            } else {
                              return Text('Error occurred.');
                            }
                          })),
                );
              },
              child: Card(
                elevation: 4, // Adjust the elevation for the shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 14, bottom: 14),
                        child: Image.network(
                          base + list.categoryImage,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const VerticalDivider(
                        color: bodyColor,
                        thickness: 2,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                list.categoryName,
                                style: GoogleFonts.secularOne(
                                    textStyle: normalstyle,
                                    fontSize: 13,
                                    color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 1,
                              ),
                              Text(
                                'Audit Date: ${list.auditDate}',
                                style: GoogleFonts.poppins(
                                    fontSize: 13, color: Colors.black),
                              ),
                            ],
                          ),
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
          },
        ),
      ),
    );
  }
}
