import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhub/controllers/bookmark_provider.dart';
import 'package:jobhub/models/response/bookmarks/all_bookmarks.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/drawer/drawer_widget.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/common/loader.dart';
import 'package:jobhub/views/common/vertical_shimmer.dart';
import 'package:jobhub/views/ui/bookmarks/widgets/bookmark_widget.dart';
import 'package:provider/provider.dart';

class BookMarkPage extends StatefulWidget {
  const BookMarkPage({super.key});

  @override
  State<BookMarkPage> createState() => _BookMarkPageState();
}

class _BookMarkPageState extends State<BookMarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: "Bookmarks",
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: DrawerWidget(),
          ),
        ),
      ),
      body: Consumer<BookMarkProvider>(
        builder: (context, bookmarkProvider, child) {
          bookmarkProvider.getBookmarks();

          return FutureBuilder<List<AllBookmarks>>(
            future: bookmarkProvider.bookmarks,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      VerticalShimmer(),
                      HeightSpacer(size: 15),
                      VerticalShimmer(),
                      HeightSpacer(size: 15),
                      VerticalShimmer(),
                      HeightSpacer(size: 15),
                      VerticalShimmer(),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                return NoData(title: "Tidak ada bookmark");
              } else {
                final bookmarkSnapshot = snapshot.data;

                return ListView.builder(
                  itemCount: bookmarkSnapshot?.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final bookmarks = bookmarkSnapshot?[index];

                    return BookmarkTileWidget(
                      job: bookmarks,
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
