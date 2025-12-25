import '../entities/project.dart';
import '../entities/skill.dart';
import '../entities/contact_form.dart';

abstract class PortfolioRepository {
  Future<List<Project>> getProjects();
  Future<List<Skill>> getSkills();
  Future<bool> submitContactForm(ContactForm form);
}

