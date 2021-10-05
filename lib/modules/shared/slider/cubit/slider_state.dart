part of 'slider_cubit.dart';

@immutable
abstract class SliderState {}

class SliderLoading extends SliderState {}

class SliderLoaded extends SliderState {
  final List<SliderModel> slides;

  SliderLoaded(this.slides);
}

class SliderCant extends SliderState {
  final String msg;

  SliderCant(this.msg);
}

class SliderEmpty extends SliderState {
  SliderEmpty();
}
