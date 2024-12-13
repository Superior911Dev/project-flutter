import 'package:appstore/common/entities/entities.dart';
import 'package:appstore/common/values/colors.dart';
import 'package:appstore/common/widgets/base_text_widget.dart';
import 'package:appstore/common/widgets/flutter_toast.dart';
import 'package:appstore/pages/course/lesson/bloc/lesson_blocs.dart';
import 'package:appstore/pages/course/lesson/bloc/lesson_event.dart';
import 'package:appstore/pages/course/lesson/bloc/lesson_states.dart';
import 'package:appstore/pages/course/lesson/lesson_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class LessonDetail extends StatefulWidget {
  const LessonDetail({super.key});

  @override
  State<LessonDetail> createState() => _LessonDetailState();
}

class _LessonDetailState extends State<LessonDetail> {
  late LessonController _lessonController;
  int videoIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _lessonController = LessonController(context: context);
    context.read<LessonBlocs>().add(TriggerUrlItem(null));
    _lessonController.init();
  }

  @override
  void dispose() {
    _lessonController.videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonBlocs, LessonStates>(builder: (context, state) {
      return SafeArea(
          child: Container(
              color: Colors.white,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: buildAppBar("Lesson detail"),
                body: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.h, horizontal: 25.w),
                      sliver: SliverToBoxAdapter(
                          child: Column(children: [
                        Container(
                          width: 325.w,
                          height: 200.h,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage("assets/icons/video.png"),
                                  fit: BoxFit.fitWidth),
                              borderRadius: BorderRadius.circular(20.h)),
                          child: FutureBuilder(
                            future: state.initlizeVideoPlayerFuture,
                            builder: (context, snapshot) {
                              print(
                                  '-------video snapshot is ${snapshot.connectionState}------------');
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return _lessonController
                                            .videoPlayerController ==
                                        null
                                    ? Container()
                                    : AspectRatio(
                                        aspectRatio: _lessonController
                                            .videoPlayerController!
                                            .value
                                            .aspectRatio,
                                        child: Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: [
                                            VideoPlayer(_lessonController
                                                .videoPlayerController!),
                                            VideoProgressIndicator(
                                              _lessonController
                                                  .videoPlayerController!,
                                              allowScrubbing: true,
                                              colors: const VideoProgressColors(
                                                  playedColor:
                                                      AppColors.primaryElement),
                                            )
                                          ],
                                        ),
                                      );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15.h),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    videoIndex = videoIndex - 1;
                                    if (videoIndex < 0) {
                                      videoIndex = 0;
                                      toastInfo(
                                          msg:
                                              "This is the firast video you are watching");
                                      return;
                                    } else {
                                      var videoItem = state.lessonVideoItem
                                          .elementAt(videoIndex);
                                      _lessonController
                                          .playVideo(videoItem.url!);
                                    }
                                  },
                                  child: Container(
                                    width: 24.w,
                                    height: 24.h,
                                    margin: EdgeInsets.only(right: 15.w),
                                    child: Image.asset(
                                        "assets/icons/rewind-left.png"),
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      if (state.isPlay) {
                                        _lessonController.videoPlayerController
                                            ?.pause();
                                        context
                                            .read<LessonBlocs>()
                                            .add(const TriggerPlay(false));
                                      } else {
                                        _lessonController.videoPlayerController
                                            ?.play();
                                        context
                                            .read<LessonBlocs>()
                                            .add(const TriggerPlay(true));
                                      }
                                    },
                                    child: state.isPlay
                                        ? Container(
                                            width: 24.w,
                                            height: 24.w,
                                            child: Image.asset(
                                                "assets/icons/pause.png"),
                                          )
                                        : Container(
                                            width: 24.w,
                                            height: 24.w,
                                            child: Image.asset(
                                                "assets/icons/play-circle.png"))),
                                GestureDetector(
                                  onTap: () {
                                    videoIndex = videoIndex + 1;
                                    if (videoIndex >=
                                        state.lessonVideoItem.length) {
                                      videoIndex = videoIndex - 1;
                                      toastInfo(
                                          msg: "No videos in the play list");
                                      return;
                                    } else {
                                      var videoItem = state.lessonVideoItem
                                          .elementAt(videoIndex);
                                      _lessonController
                                          .playVideo(videoItem.url!);
                                    }
                                  },
                                  child: Container(
                                    width: 24.w,
                                    height: 24.h,
                                    margin: EdgeInsets.only(left: 15.w),
                                    child: Image.asset(
                                        "assets/icons/rewind-right.png"),
                                  ),
                                ),
                              ]),
                        )
                      ])),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                          vertical: 18.h, horizontal: 25.w),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return buildLessonItems(
                              context, index, state.lessonVideoItem[index]);
                        }, childCount: state.lessonVideoItem.length),
                      ),
                    )
                  ],
                ),
              )));
    });
  }

  Widget buildLessonItems(
      BuildContext context, int index, LessonVideoItem item) {
    return Container(
      width: 325.w,
      height: 80.h,
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.w),
          color: Color.fromRGBO(255, 255, 255, 1),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(.5),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 1))
          ]),
      child: InkWell(
        onTap: () {
          videoIndex = index;
          _lessonController.playVideo(item.url!);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 60.h,
                  height: 60.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.w),
                      image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: NetworkImage("${item.thumbnail}"))),
                ),
                Container(
                  width: 210.h,
                  height: 60.h,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 6.sp),
                  child: reusableText("${item.name}", fontSize: 13.sp),
                )
              ],
            ),
            Row(
              children: [
                Container(
                    child: GestureDetector(
                  onTap: () {
                    videoIndex = index;
                    _lessonController.playVideo(item.url!);
                  },
                  child: reusableText("play", fontSize: 13.sp),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
