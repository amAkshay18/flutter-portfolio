import '../../domain/entities/contact_form.dart';
import '../../domain/entities/project.dart';
import '../../domain/entities/skill.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../datasources/portfolio_local_data_source.dart';
import '../datasources/portfolio_remote_data_source.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  final PortfolioLocalDataSource localDataSource;
  final PortfolioRemoteDataSource remoteDataSource;

  PortfolioRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<List<Project>> getProjects() async {
    return localDataSource.getProjects();
  }

  @override
  Future<List<Skill>> getSkills() async {
    return localDataSource.getSkills();
  }

  @override
  Future<bool> submitContactForm(ContactForm form) async {
    return remoteDataSource.submitContactForm(form);
  }
}

