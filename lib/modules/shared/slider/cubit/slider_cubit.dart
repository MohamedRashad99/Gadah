import 'package:bloc/bloc.dart';
import 'package:gadha/modules/shared/slider/data/sliders_service.dart';
import 'package:gadha/modules/shared/slider/models/slider_model.dart';
import 'package:meta/meta.dart';

part 'slider_state.dart';

class SliderCubit extends Cubit<SliderState> {
  SliderCubit() : super(SliderLoading()) {
    refresh();
  }
  Future<void> refresh() async {
    emit(SliderLoading());
    try {
      final data = await SliderService.getHomeSlides();
      if (data.isEmpty) {
        emit(SliderEmpty());
      } else {
        emit(SliderLoaded(data));
      }
    } catch (e) {
      emit(SliderCant(e.toString()));
    }
  }
}
