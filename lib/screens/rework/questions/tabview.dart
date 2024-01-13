import 'package:audit_app/screens/rework/questions/completed_ques_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../fonts/fonts.dart';
import '../../../global_variable.dart';
import '../question_list_model.dart';

class ReworkQuesTab extends StatefulWidget {
  final List<CompletdQuesList> completedList;
  final List<QuestionListModel> pendingList;

  const ReworkQuesTab({
    required this.completedList,
    required this.pendingList,
  });

  @override
  State<ReworkQuesTab> createState() => _ReworkQuesTabState();
}

class _ReworkQuesTabState extends State<ReworkQuesTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    setState(() {});
  }

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
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 20,
              color: Colors.black,
            )),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white, // Text color for the selected tab
          unselectedLabelColor: Colors.black,
          indicatorPadding: EdgeInsets.zero, // Text color for unselected tabs
          indicator: BoxDecoration(
            color: maincolor, // Green color for the selected tab background
          ),
          indicatorWeight: 4,
          tabs: [
            Tab(text: 'Completed'),
            Tab(text: 'Pending'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          completedListView(widget.completedList),
          _buildListView(widget.pendingList),
        ],
      ),
    );
  }

  Widget _buildListView(List<QuestionListModel> list) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return InkWell(
            onTap: () {},
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Q" + (item.questionNo).toString() + ".",
                      style: GoogleFonts.secularOne(
                        textStyle: normalstyle,
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Expanded(
                      child: Text(
                        item.questionName,
                        style: GoogleFonts.secularOne(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   width: 1,
                    // ),
                    // Icon(
                    //   Icons.arrow_forward,
                    //   size: 24,
                    //   color: Colors.green.shade900,
                    // ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget completedListView(List<CompletdQuesList> list) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return InkWell(
            onTap: () {},
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Q" + (item.questionNo).toString() + ".",
                      style: GoogleFonts.secularOne(
                        textStyle: normalstyle,
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Expanded(
                      child: Text(
                        item.questionName,
                        style: GoogleFonts.secularOne(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
