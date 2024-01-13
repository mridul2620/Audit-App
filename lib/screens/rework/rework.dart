import 'package:audit_app/global_variable.dart';
import 'package:audit_app/screens/rework/rework_category.dart';
import 'package:audit_app/screens/rework/school_list_rework_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../fonts/fonts.dart';

class Rework extends StatefulWidget {
  const Rework({super.key});

  @override
  State<Rework> createState() => _ReworkState();
}

class _ReworkState extends State<Rework> {
  @override
  void initState() {
    super.initState();
    Provider.of<ReworkPageState>(context, listen: false).reworkApi();
  }

  @override
  Widget build(BuildContext context) {
    final reworkLists = Provider.of<ReworkPageState>(context).reworkList;
    final bool reworkLoading =
        Provider.of<ReworkPageState>(context).rework_loading;
    return Scaffold(
      backgroundColor: bodyColor,
      body: Center(
        child: SingleChildScrollView(
            child: reworkLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: maincolor,
                      valueColor: AlwaysStoppedAnimation(
                          Color.fromARGB(255, 220, 216, 216)),
                      strokeWidth: 4,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: reworkLists.length,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 0,
                      ),
                      itemBuilder: (context, index) {
                        final reworkList = reworkLists[index];
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => FutureBuilder(
                                  future: Provider.of<ReworkPageState>(context,
                                          listen: false)
                                      .reworkCategoryApi(reworkList.auditName,
                                          reworkList.address),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return ReworkCategory(
                                        categoryList:
                                            Provider.of<ReworkPageState>(
                                                    context)
                                                .reworkCategoryList,
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
                                                Color.fromARGB(
                                                    255, 220, 216, 216)),
                                            strokeWidth: 4,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Text('Error occurred.');
                                    }
                                  },
                                ),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 4, // Adjust the elevation for the shadow
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Container(
                              height: 60,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 14, bottom: 14),
                                    child: Image.asset(
                                      "assets/rework_icon.png",
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            reworkList.auditName,
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
                                            reworkList.address,
                                            style: GoogleFonts.poppins(
                                                fontSize: 13,
                                                color: Colors.black),
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
                  )),
      ),
    );
  }
}
