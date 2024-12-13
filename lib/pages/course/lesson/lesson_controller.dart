import 'package:appstore/common/apis/lesson_api.dart';
import 'package:appstore/common/entities/entities.dart';
import 'package:appstore/pages/course/lesson/bloc/lesson_blocs.dart';
import 'package:appstore/pages/course/lesson/bloc/lesson_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class LessonController {
  final BuildContext context;
  VideoPlayerController? videoPlayerController;

  LessonController({required this.context});

  void init() async {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    context.read<LessonBlocs>().add(TriggerPlay(false));
    asycLoadLessonData(args['id']);
  }

  void asycLoadLessonData(int? id) async {
    LessonRequestEntity lessonRequestEntity = LessonRequestEntity();
    lessonRequestEntity.id = id;
    var result = await LessonAPI.lessonDetail(params: lessonRequestEntity);
    if (result.code == 200) {
      if (context.mounted) {
        context.read<LessonBlocs>().add(TriggerLessonVideo(result.data!));
        if (result.data!.isNotEmpty) {
          var url = result.data!.elementAt(0).url;
          print('my url is ${url}');
          // ignore: deprecated_member_use
          videoPlayerController = VideoPlayerController.network(url!);
          var initPlayer = videoPlayerController?.initialize();
          context.read<LessonBlocs>().add(TriggerUrlItem(initPlayer));
        }
      }
    }
  }

  void playVideo(String url) {
    if (videoPlayerController != null) {
      videoPlayerController?.pause();
      videoPlayerController?.dispose();
    }
    // ignore: deprecated_member_use
    videoPlayerController = VideoPlayerController.network(url);
    context.read<LessonBlocs>().add(const TriggerPlay(false));
    context.read<LessonBlocs>().add(const TriggerUrlItem(null));
    var initPlayer = videoPlayerController?.initialize().then((value) {
      videoPlayerController?.seekTo(const Duration(milliseconds: 0));
    });
    context.read<LessonBlocs>().add(TriggerUrlItem(initPlayer));
    context.read<LessonBlocs>().add(const TriggerPlay(true));
  }
}
