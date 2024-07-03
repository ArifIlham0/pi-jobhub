import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/models/request/bookmarks/bookmarks_model.dart';
import 'package:jobhub/models/request/chats/create_chat.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/custom_outline_btn.dart';
import 'package:jobhub/views/common/custom_small_btn.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/common/loading_outline_button.dart';
import 'package:jobhub/views/common/width_spacer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobPage extends StatefulWidget {
  const JobPage({
    super.key,
    this.title,
    this.id,
  });

  final String? title;
  final String? id;

  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  String? token;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
    });
  }

  @override
  Widget build(BuildContext context) {
    var profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    return Consumer<JobsProvider>(
      builder: (context, jobsProvider, child) {
        jobsProvider.getJobById(widget.id);

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: CustomAppBar(
              text: widget.title,
              actions: [
                Consumer<BookMarkProvider>(
                  builder: (context, bookmarkProvider, child) {
                    bookmarkProvider.loadJobs();

                    return FutureBuilder(
                      future: jobsProvider.jobById,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox();
                        } else if (snapshot.hasError) {
                          return Text("Error ${snapshot.error}");
                        } else {
                          final jobById = snapshot.data;

                          return token != null
                              ? IconButton(
                                  onPressed: () async {
                                    if (jobById?.isBookmark == true) {
                                      await bookmarkProvider
                                          .deleteBookmark(widget.id);
                                      setState(() {});
                                    } else {
                                      BookmarkReqResModel model =
                                          BookmarkReqResModel(job: widget.id);
                                      await bookmarkProvider.addBookmark(
                                          model, widget.id);
                                      setState(() {});
                                    }
                                  },
                                  icon: jobById?.isBookmark == true
                                      ? Icon(Fontisto.bookmark_alt)
                                      : Icon(Fontisto.bookmark),
                                )
                              : SizedBox.shrink();
                        }
                      },
                    );
                  },
                )
              ],
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Icon(CupertinoIcons.arrow_left),
              ),
            ),
          ),
          body: FutureBuilder(
            future: jobsProvider.jobById,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text("Error ${snapshot.error}");
              } else {
                final jobById = snapshot.data;

                return Padding(
                  padding: EdgeInsets.only(right: 14.w, left: 12.w),
                  child: Stack(
                    children: [
                      ListView(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        children: [
                          HeightSpacer(size: 30),
                          Container(
                            width: width,
                            height: height * 0.29,
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.w, vertical: 15.h),
                            decoration: BoxDecoration(
                              color: Color(kLightGrey.value),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Color(kWhite.value),
                                width: 0.3,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(jobById!.imageUrl),
                                ),
                                HeightSpacer(size: 10),
                                ReusableText(
                                  text: jobById.title,
                                  style: appstyle(22, Color(kWhite2.value),
                                      FontWeight.w600),
                                ),
                                HeightSpacer(size: 5),
                                ReusableText(
                                  text: jobById.location,
                                  style: appstyle(
                                    16,
                                    Color(kDarkGrey.value),
                                    FontWeight.normal,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 2.w),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomSmallButton(
                                        width: width * 0.26,
                                        height: height * 0.04,
                                        color2: Color(kBlack2.value),
                                        text: jobById.contract,
                                        color: Color(kGreen.value),
                                      ),
                                      WidthSpacer(width: 10),
                                      Row(
                                        children: [
                                          ReusableText(
                                            text: jobById.salary,
                                            style: appstyle(
                                              17,
                                              Color(kWhite2.value),
                                              FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * 0.2,
                                            child: ReusableText(
                                              text: "/${jobById.period}",
                                              style: appstyle(
                                                17,
                                                Color(kWhite2.value),
                                                FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          HeightSpacer(size: 20),
                          ReusableText(
                            text: "Deskripsi",
                            style: appstyle(
                                22, Color(kWhite2.value), FontWeight.w600),
                          ),
                          HeightSpacer(size: 10),
                          Text(
                            jobById.description,
                            textAlign: TextAlign.justify,
                            maxLines: 8,
                            style: appstyle(
                                16, Color(kDarkGrey.value), FontWeight.normal),
                          ),
                          HeightSpacer(size: 20),
                          ReusableText(
                            text: "Persyaratan",
                            style: appstyle(
                                22, Color(kWhite2.value), FontWeight.w600),
                          ),
                          HeightSpacer(size: 10),
                          SizedBox(
                            height: height * 0.6,
                            child: ListView.builder(
                              itemCount: jobById.requirements.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final req = jobById.requirements[index];
                                String bullet = "\u2022";
                                return Text(
                                  "$bullet $req\n",
                                  maxLines: 4,
                                  textAlign: TextAlign.justify,
                                  style: appstyle(16, Color(kDarkGrey.value),
                                      FontWeight.normal),
                                );
                              },
                            ),
                          ),
                          HeightSpacer(size: 20),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: jobsProvider.isLoading
                              ? LoadingOutlineButton(
                                  onTap: () {},
                                  color2: token != null
                                      ? Color(kGreen.value)
                                      : Color(kDarkGrey.value),
                                  width: width,
                                  height: height * 0.06,
                                  color: Color(kWhite.value),
                                )
                              : CustomOutlineBtn(
                                  onTap: token != null
                                      ? () {
                                          CreateChat model = CreateChat(
                                              userId: jobById.agentId);
                                          jobsProvider.applyJob(
                                            model,
                                            "Halo, Saya tertarik bekerja di ${jobById.company} pada posisi ${jobById.title}, berikut CV saya ${profileProvider.cvUrl}",
                                            jobById.agentId,
                                            profileProvider,
                                          );
                                        }
                                      : null,
                                  color2: token != null
                                      ? Color(kGreen.value)
                                      : Color(kDarkGrey.value),
                                  width: width,
                                  height: height * 0.06,
                                  text: "Lamar",
                                  color: Color(kWhite.value),
                                ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
