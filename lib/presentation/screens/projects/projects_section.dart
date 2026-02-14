import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../domain/entities/project.dart';
import '../../../data/datasources/portfolio_local_data_source.dart';
import '../../../data/datasources/portfolio_remote_data_source.dart';
import '../../../data/repositories/portfolio_repository_impl.dart';
import '../../../domain/usecases/get_projects_usecase.dart';
import '../../bloc/projects/projects_bloc.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProjectsBloc(
        getProjectsUseCase: GetProjectsUseCase(
          PortfolioRepositoryImpl(
            localDataSource: PortfolioLocalDataSource(),
            remoteDataSource: PortfolioRemoteDataSource(),
          ),
        ),
      )..add(const ProjectsEvent.fetchRequested()),
      child: const _ProjectsContent(),
    );
  }
}

class _ProjectsContent extends StatelessWidget {
  const _ProjectsContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectsBloc, ProjectsState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 70),
              child: CircularProgressIndicator(),
            ),
          ),
          success: (projects) {
        final industryProjects = projects
            .where((project) => project.id.startsWith('industry_'))
            .toList();
        final personalProjects = projects
            .where((project) => project.id.startsWith('personal_'))
            .toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Industry Projects
            _ProjectCategory(
              title: 'Industry Projects',
              projects: industryProjects,
            ),
            const SizedBox(height: 100),
            // Personal Projects
            _ProjectCategory(
              title: 'Personal Projects',
              projects: personalProjects,
            ),
          ],
        );
          },
          failure: (message) => Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 70),
              child: Text(message),
            ),
          ),
        );
      },
    );
  }
}

class _ProjectCategory extends StatelessWidget {
  final String title;
  final List<Project> projects;

  const _ProjectCategory({
    required this.title,
    required this.projects,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 50),
        _ProjectsList(projects: projects),
      ],
    );
  }
}

class _ProjectsList extends StatelessWidget {
  final List<Project> projects;

  const _ProjectsList({required this.projects});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth >= 768 ? 450.0 : constraints.maxWidth * 0.85;
        final cardHeight = constraints.maxWidth >= 768 ? 600.0 : 550.0;
        
        return SizedBox(
          height: cardHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return Container(
                width: cardWidth,
                margin: EdgeInsets.only(
                  right: index < projects.length - 1 ? 40 : 0,
                ),
                padding: const EdgeInsets.all(8), // Padding to accommodate scale transformation
                clipBehavior: Clip.none, // Allow overflow for hover effects
                child: _ProjectCard(project: projects[index]),
              );
            },
          ),
        );
      },
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Project project;

  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  Future<void> _openProjectLink() async {
    final link = widget.project.appStoreLink ?? widget.project.githubLink;
    if (link == null) return;

    final uri = Uri.parse(link);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _openProjectLink,
        child: Transform.scale(
          scale: _isHovered ? 1.02 : 1.0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
            color: isDark ? AppTheme.bgEerieBlack : AppTheme.bgWhite,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isHovered
                  ? (isDark 
                      ? AppTheme.borderEerieBlack.withOpacity(0.6)
                      : AppTheme.borderGainsboro.withOpacity(0.8))
                  : (isDark 
                      ? AppTheme.borderEerieBlack.withOpacity(0.3)
                      : AppTheme.borderGainsboro),
              width: 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: isDark 
                          ? Colors.black.withOpacity(0.4)
                          : Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                      spreadRadius: 0,
                    ),
                  ]
                : [],
          ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Image
            Expanded(
              flex: 5,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                child: _ProjectImage(project: widget.project),
              ),
            ),
            // Project Info
            Expanded(
              flex: 4,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final padding = constraints.maxWidth < 400 ? 16.0 : 32.0;
                  return Padding(
                    padding: EdgeInsets.all(padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.project.title,
                                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                  height: 1.2,
                                  fontWeight: FontWeight.w600,
                                  fontSize: constraints.maxWidth < 400 ? 20 : null,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: constraints.maxWidth < 400 ? 12 : 16),
                              _ProjectLinks(project: widget.project),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
          ),
        ),
      ),
    );
  }
}

class _ProjectLinks extends StatelessWidget {
  final Project project;

  const _ProjectLinks({required this.project});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? 
                     (isDark ? AppTheme.textWhite : AppTheme.textBlack);
    
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        if (project.appStoreLink != null)
          _LinkButton(
            icon: Icons.shopping_bag,
            label: 'App Store',
            url: project.appStoreLink!,
            color: textColor,
            isDark: isDark,
          ),
        if (project.githubLink != null)
          _LinkButton(
            icon: Icons.code,
            label: 'GitHub',
            url: project.githubLink!,
            color: textColor,
            isDark: isDark,
          ),
      ],
    );
  }
}

class _LinkButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;
  final Color color;
  final bool isDark;

  const _LinkButton({
    required this.icon,
    required this.label,
    required this.url,
    required this.color,
    required this.isDark,
  });

  @override
  State<_LinkButton> createState() => _LinkButtonState();
}

class _LinkButtonState extends State<_LinkButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.isDark 
        ? AppTheme.bgRichBlackFogra29.withOpacity(0.5)
        : AppTheme.bgLightGray.withOpacity(0.5);
    
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(widget.url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          constraints: const BoxConstraints(minHeight: 40),
          transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
          decoration: BoxDecoration(
            color: _isHovered 
                ? (widget.isDark 
                    ? AppTheme.bgRichBlackFogra29.withOpacity(0.7)
                    : AppTheme.bgLightGray.withOpacity(0.7))
                : bgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered 
                  ? widget.color.withOpacity(0.6)
                  : Colors.transparent,
              width: _isHovered ? 1.5 : 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: widget.color.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 18,
                color: widget.color,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  color: widget.color,
                  fontSize: AppTheme.fontSize10,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectImage extends StatelessWidget {
  final Project project;

  const _ProjectImage({required this.project});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      project.imagePath,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
