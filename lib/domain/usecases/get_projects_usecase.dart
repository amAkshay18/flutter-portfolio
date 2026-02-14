import '../entities/project.dart';
import '../repositories/portfolio_repository.dart';

class GetProjectsUseCase {
  final PortfolioRepository repository;

  const GetProjectsUseCase(this.repository);

  Future<List<Project>> call() {
    return repository.getProjects();
  }
}
