import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/portfolio_local_data_source.dart';
import '../../data/datasources/portfolio_remote_data_source.dart';
import '../../data/repositories/portfolio_repository_impl.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../../domain/entities/project.dart';
import '../../domain/entities/skill.dart';
import '../../domain/entities/contact_form.dart';

// Data Sources
final portfolioLocalDataSourceProvider = Provider<PortfolioLocalDataSource>((ref) {
  return PortfolioLocalDataSource();
});

final portfolioRemoteDataSourceProvider = Provider<PortfolioRemoteDataSource>((ref) {
  return PortfolioRemoteDataSource();
});

// Repository
final portfolioRepositoryProvider = Provider<PortfolioRepository>((ref) {
  return PortfolioRepositoryImpl(
    localDataSource: ref.watch(portfolioLocalDataSourceProvider),
    remoteDataSource: ref.watch(portfolioRemoteDataSourceProvider),
  );
});

// Projects Provider
final projectsProvider = FutureProvider<List<Project>>((ref) async {
  final repository = ref.watch(portfolioRepositoryProvider);
  return repository.getProjects();
});

// Skills Provider
final skillsProvider = FutureProvider<List<Skill>>((ref) async {
  final repository = ref.watch(portfolioRepositoryProvider);
  return repository.getSkills();
});

// Contact Form State
class ContactFormState {
  final String name;
  final String phone;
  final String email;
  final String message;
  final bool isLoading;
  final String? error;
  final bool? success;

  ContactFormState({
    this.name = '',
    this.phone = '',
    this.email = '',
    this.message = '',
    this.isLoading = false,
    this.error,
    this.success,
  });

  ContactFormState copyWith({
    String? name,
    String? phone,
    String? email,
    String? message,
    bool? isLoading,
    String? error,
    bool? success,
  }) {
    return ContactFormState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      success: success,
    );
  }
}

class ContactFormNotifier extends StateNotifier<ContactFormState> {
  final PortfolioRepository repository;

  ContactFormNotifier(this.repository) : super(ContactFormState());

  void updateName(String value) {
    state = state.copyWith(name: value);
  }

  void updatePhone(String value) {
    state = state.copyWith(phone: value);
  }

  void updateEmail(String value) {
    state = state.copyWith(email: value);
  }

  void updateMessage(String value) {
    state = state.copyWith(message: value);
  }

  Future<void> submitForm() async {
    state = state.copyWith(isLoading: true, error: null, success: null);
    
    try {
      final form = ContactForm(
        name: state.name,
        phone: state.phone,
        email: state.email,
        message: state.message,
      );
      
      final success = await repository.submitContactForm(form);
      
      if (success) {
        state = state.copyWith(
          isLoading: false,
          success: true,
          name: '',
          phone: '',
          email: '',
          message: '',
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Something went wrong',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Something went wrong',
      );
    }
  }

  void reset() {
    state = ContactFormState();
  }
}

final contactFormProvider = StateNotifierProvider<ContactFormNotifier, ContactFormState>((ref) {
  final repository = ref.watch(portfolioRepositoryProvider);
  return ContactFormNotifier(repository);
});

