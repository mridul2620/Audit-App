import 'package:audit_app/list/viewModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../fonts/fonts.dart';
import '../global_variable.dart';

class CompletedAuditList extends StatefulWidget {
  @override
  State<CompletedAuditList> createState() => _CompletedAuditListState();
}

class _CompletedAuditListState extends State<CompletedAuditList> {
  Widget _buildCard(String categoryName, String categoryImage, int index) {
    final image = base + categoryImage;

    return InkWell(
      onTap: () {},
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Image.network(
                image,
                width: 25,
                height: 28,
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
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final completedAudits = context.watch<AuditViewModel>().completedAudits;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemCount: completedAudits.length,
          separatorBuilder: (context, index) => const SizedBox(
                height: 6,
              ),
          itemBuilder: (context, index) {
            final audit = completedAudits[index];
            return _buildCard(audit.auditType, audit.categoryImage, index);
            // ListTile(
            //   title: Text(audit.auditType),
          }),
    );
  }
}

class PendingAuditList extends StatelessWidget {
  Widget _buildCard(String categoryName, String categoryImage, int index) {
    final image = base + categoryImage;

    return InkWell(
      onTap: () {},
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Image.network(
                image,
                width: 25,
                height: 28,
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
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pendingAudits = context.watch<AuditViewModel>().pendingAudits;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemCount: pendingAudits.length,
          separatorBuilder: (context, index) => const SizedBox(
                height: 6,
              ),
          itemBuilder: (context, index) {
            final audit = pendingAudits[index];
            return _buildCard(audit.auditType, audit.categoryImage, index);
          }),
    );
  }
}
