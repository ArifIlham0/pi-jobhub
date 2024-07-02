import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/models/response/jobs/jobs_response.dart';
import 'package:jobhub/services/helpers/jobs_helper.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/loader.dart';
import 'package:jobhub/views/ui/jobs/widgets/job_tile.dart';
import 'package:jobhub/views/ui/search/widgets/custom_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(kOrange.value),
        iconTheme: IconThemeData(color: Color(kLight.value)),
        elevation: 0,
        title: CustomField(
          hintText: "Cari Lowongan",
          controller: search,
          onEditingComplete: () {
            setState(() {});
          },
          suffixIcon: InkWell(
            onTap: () {
              setState(() {});
            },
            child: Icon(AntDesign.search1),
          ),
        ),
      ),
      body: search.text.isNotEmpty
          ? Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 12.h,
              ),
              child: FutureBuilder<List<JobsResponse>>(
                future: JobsHelper.searchJobs(search.text),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error ${snapshot.error}");
                  } else if (snapshot.data!.isEmpty) {
                    return NoData(
                      title: "No jobs found",
                    );
                  } else {
                    final searchJobs = snapshot.data;

                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: searchJobs!.length,
                      itemBuilder: (context, index) {
                        final job = searchJobs[index];
                        return VerticalTileWidget(
                          job: job,
                        );
                      },
                    );
                  }
                },
              ),
            )
          : NoData(
              title: "Mulai cari lowongan",
            ),
    );
  }
}
