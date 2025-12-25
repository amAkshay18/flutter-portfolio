class Project {
  final String id;
  final String title;
  final String imagePath;
  final String? appStoreLink;
  final String? githubLink;
  final String subtitle;

  const Project({
    required this.id,
    required this.title,
    required this.imagePath,
    this.appStoreLink,
    this.githubLink,
    required this.subtitle,
  });
}

