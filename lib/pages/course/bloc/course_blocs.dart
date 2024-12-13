import 'package:appstore/pages/course/bloc/course_events.dart';
import 'package:appstore/pages/course/bloc/course_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseBloc extends Bloc<CourseEvents, CourseStates> {
  CourseBloc() : super(const CourseStates()) {
    on<TriggerCourse>(_triggerCourseDetail);
  }
  void _triggerCourseDetail(TriggerCourse event, Emitter<CourseStates> emit) {
    emit(state.copyWith(courseItem: event.courseItem));
  }
}
