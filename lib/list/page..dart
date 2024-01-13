import 'package:audit_app/global_variable.dart';
import 'package:audit_app/list/viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'audit_list.dart';

class AuditPage extends StatefulWidget {
  @override
  State<AuditPage> createState() => _AuditPageState();
}

class _AuditPageState extends State<AuditPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
    context.read<AuditViewModel>().fetchAudits();
  }

  void _handleTabChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bodyColor,
        appBar: AppBar(
          titleSpacing: 0,
          backgroundColor: Colors.white, // Background color for the app bar
          elevation: 1, // No shadow
          toolbarHeight: 50,
          title: TabBar(
              controller: _tabController,
              labelColor: Colors.white, // Text color for the selected tab
              unselectedLabelColor: Colors.black,
              padding: EdgeInsets.zero,
              indicatorPadding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero, // Text color for unselected tabs
              indicator: BoxDecoration(
                color: maincolor, // Green color for the selected tab background
              ),
              indicatorWeight: 4,
              tabs: [
                Tab(
                  text: "Completed",
                ),
                Tab(
                  text: "Pending",
                )
              ]),
        ),
        body: TabBarView(controller: _tabController, children: [
          CompletedAuditList(),
          PendingAuditList(),
        ]));
  }
}
