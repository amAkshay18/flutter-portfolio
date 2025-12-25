import '../../domain/entities/project.dart';

class ProjectModel extends Project {
  const ProjectModel({
    required super.id,
    required super.title,
    required super.imagePath,
    super.appStoreLink,
    super.githubLink,
    required super.subtitle,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as String,
      title: json['title'] as String,
      imagePath: json['imagePath'] as String,
      appStoreLink: json['appStoreLink'] as String?,
      githubLink: json['githubLink'] as String?,
      subtitle: json['subtitle'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imagePath': imagePath,
      'appStoreLink': appStoreLink,
      'githubLink': githubLink,
      'subtitle': subtitle,
    };
  }
}

