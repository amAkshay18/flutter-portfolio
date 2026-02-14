part of 'projects_bloc.dart';

@freezed
class ProjectsState with _$ProjectsState {
  const factory ProjectsState.initial() = _Initial;
  const factory ProjectsState.loading() = _Loading;
  const factory ProjectsState.success(List<Project> projects) = _Success;
  const factory ProjectsState.failure(String message) = _Failure;
}
