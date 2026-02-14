import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/project.dart';
import '../../../domain/usecases/get_projects_usecase.dart';

part 'projects_bloc.freezed.dart';
part 'projects_event.dart';
part 'projects_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  final GetProjectsUseCase getProjectsUseCase;

  ProjectsBloc({required this.getProjectsUseCase})
      : super(const ProjectsState.initial()) {
    on<ProjectsEvent>((event, emit) async {
      await event.when(
        fetchRequested: () async {
          emit(const ProjectsState.loading());
          try {
            final projects = await getProjectsUseCase();
            emit(ProjectsState.success(projects));
          } catch (_) {
            emit(const ProjectsState.failure('Error loading projects'));
          }
        },
      );
    });
  }
}
