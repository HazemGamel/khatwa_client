part of 'reels_cubit.dart';

@immutable
abstract class ReelsState {}

class ReelsInitialState extends ReelsState {}

class LoadingFetchReelsState extends ReelsState {}

class ErrorFetchReelsState extends ReelsState {
  final String error;

  ErrorFetchReelsState(this.error);
}

class SuccessFetchReelsState extends ReelsState {
  final List<ReelsModel>? value;

  SuccessFetchReelsState(this.value);
}

class LoadingRemoveReelsState extends ReelsState {}

class ErrorRemoveReelsState extends ReelsState {
  final String error;

  ErrorRemoveReelsState(this.error);
}

class SuccessRemoveReelsState extends ReelsState {
  final WatchedReelsModel value;

  SuccessRemoveReelsState(this.value);
}
