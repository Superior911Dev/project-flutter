import 'package:appstore/common/entities/entities.dart';

class LessonStates {
  final List<LessonVideoItem> lessonVideoItem;
  final Future<void>? initlizeVideoPlayerFuture;
  final bool isPlay;

  const LessonStates(
      {this.lessonVideoItem = const <LessonVideoItem>[],
      this.isPlay = false,
      this.initlizeVideoPlayerFuture});
  LessonStates copyWith(
      {List<LessonVideoItem>? lessonVideoItem,
      bool? isPlay,
      Future<void>? initlizeVideoPlayerFuture}) {
    return LessonStates(
        lessonVideoItem: lessonVideoItem ?? this.lessonVideoItem,
        isPlay: isPlay ?? this.isPlay,
        initlizeVideoPlayerFuture:
            initlizeVideoPlayerFuture ?? this.initlizeVideoPlayerFuture);
  }
}
