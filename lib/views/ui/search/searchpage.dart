import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/models/response/jobs/jobs_response.dart';
import 'package:jobhub/services/helpers/jobs_helper.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/common/loader.dart';
import 'package:jobhub/views/common/vertical_shimmer.dart';
import 'package:jobhub/views/common/width_spacer.dart';
import 'package:jobhub/views/ui/jobs/widgets/job_tile.dart';
import 'package:jobhub/views/ui/search/widgets/custom_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController search = TextEditingController();
  String? _selectedCategory;
  Future<List<JobsResponse>>? jobsFuture;
  List<String> categories = [
    'Teknologi',
    'Bisnis',
    'Engineering',
    'Multimedia'
  ];

  ListTile buildListTile(String category) {
    return ListTile(
      title: Padding(
        padding: EdgeInsets.only(left: 25.w),
        child: Text(
          category,
          style: appstyle(14, Color(kWhite.value), FontWeight.normal),
        ),
      ),
      leading: Radio(
        fillColor: MaterialStateProperty.all(Color(kGreen.value)),
        value: category,
        groupValue: _selectedCategory,
        onChanged: (String? value) {
          setState(() {
            _selectedCategory = value;
            search.clear();
            updateJobsFuture();
          });
        },
      ),
    );
  }

  void updateJobsFuture() {
    if (search.text.isNotEmpty) {
      jobsFuture = JobsHelper.searchJobs(search.text);
    } else if (_selectedCategory != null) {
      jobsFuture = JobsHelper.searchJobCategory(_selectedCategory!);
    } else {
      jobsFuture = null;
    }
  }

  @override
  void initState() {
    super.initState();
    updateJobsFuture();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(kGreen.value),
        iconTheme: IconThemeData(color: Color(kBlack2.value)),
        elevation: 0,
        title: CustomField(
          hintText: "Cari Lowongan",
          controller: search,
          onEditingComplete: () {
            setState(() {
              _selectedCategory = null;
              updateJobsFuture();
            });
          },
        ),
        actions: [
          InkWell(
            onTap: () {
              setState(() {
                _selectedCategory = null;
                updateJobsFuture();
              });
            },
            child: Icon(
              AntDesign.search1,
              size: 23,
            ),
          ),
          WidthSpacer(width: 10),
          Builder(
            builder: (context) => InkWell(
              onTap: () {
                Scaffold.of(context).openEndDrawer();
              },
              child: Icon(
                FontAwesome.sliders,
                size: 23,
              ),
            ),
          ),
          WidthSpacer(width: 10),
        ],
      ),
      endDrawer: Drawer(
        elevation: 0.0,
        backgroundColor: Color(kLightGrey.value),
        child: Column(
          children: [
            HeightSpacer(size: 180),
            ReusableText(
              text: "Kategori",
              style: appstyle(28, Color(kWhite.value), FontWeight.bold),
            ),
            Expanded(
              child: ListView(
                children: categories
                    .map((category) => buildListTile(category))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
      body: search.text.isNotEmpty || _selectedCategory != null
          ? Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 12.h,
              ),
              child: FutureBuilder<List<JobsResponse>>(
                future: jobsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        VerticalShimmer(),
                        HeightSpacer(size: 10),
                        VerticalShimmer(),
                        HeightSpacer(size: 10),
                        VerticalShimmer(),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error ${snapshot.error}");
                  } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return NoData(
                      title: "Tidak menemukan lowongan",
                      isCentre: true,
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
          : NoData(title: "Mulai cari lowongan"),
    );
  }
}
