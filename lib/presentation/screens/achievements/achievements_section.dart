import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_constants.dart';

class AchievementsSection extends StatelessWidget {
  const AchievementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Achievement data - LeetCode badges
    final achievements = [
      _AchievementItem(
        title: 'LeetCode Badge 1',
        imageUrl: null, // Will be set when badge image is added
        linkUrl: AppConstants.leetcodeUrl,
        description: 'Problem Solving & Algorithm Skills',
      ),
      _AchievementItem(
        title: 'LeetCode Badge 2',
        imageUrl: null, // Will be set when badge image is added
        linkUrl: AppConstants.leetcodeUrl,
        description: 'Data Structures & Algorithms Excellence',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Achievements',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 50),
        _AchievementsList(achievements: achievements),
      ],
    );
  }
}

class _AchievementItem {
  final String title;
  final String? imageUrl;
  final String linkUrl;
  final String description;

  _AchievementItem({
    required this.title,
    this.imageUrl,
    required this.linkUrl,
    required this.description,
  });
}

class _AchievementsList extends StatelessWidget {
  final List<_AchievementItem> achievements;

  const _AchievementsList({required this.achievements});

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
            itemCount: achievements.length,
            itemBuilder: (context, index) {
              return Container(
                width: cardWidth,
                margin: EdgeInsets.only(
                  right: index < achievements.length - 1 ? 40 : 0,
                ),
                child: _AchievementCard(achievement: achievements[index]),
              );
            },
          ),
        );
      },
    );
  }
}

class _AchievementCard extends StatelessWidget {
  final _AchievementItem achievement;

  const _AchievementCard({required this.achievement});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppTheme.bgEerieBlack : AppTheme.bgWhite,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark 
              ? AppTheme.borderEerieBlack.withOpacity(0.3)
              : AppTheme.borderGainsboro,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Achievement Image or Placeholder
          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: _AchievementImage(achievement: achievement),
            ),
          ),
          // Achievement Info
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
                              achievement.title,
                              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                height: 1.2,
                                fontWeight: FontWeight.w600,
                                fontSize: constraints.maxWidth < 400 ? 20 : null,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: constraints.maxWidth < 400 ? 8 : 12),
                            Text(
                              achievement.description,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: isDark ? AppTheme.textLightGray : AppTheme.textSmokyBlack,
                                fontSize: constraints.maxWidth < 400 ? 12 : AppTheme.fontSize10,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: constraints.maxWidth < 400 ? 12 : 16),
                            _AchievementLink(url: achievement.linkUrl, isDark: isDark),
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
    );
  }
}

class _AchievementImage extends StatelessWidget {
  final _AchievementItem achievement;

  const _AchievementImage({required this.achievement});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Placeholder if no image URL
    if (achievement.imageUrl == null) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: isDark ? AppTheme.bgRichBlackFogra29 : AppTheme.bgLightGray,
        child: Icon(
          Icons.emoji_events,
          size: 80,
          color: isDark ? AppTheme.textLightGray.withOpacity(0.5) : AppTheme.textSmokyBlack.withOpacity(0.5),
        ),
      );
    }
    
    return Image.network(
      achievement.imageUrl!,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: isDark ? AppTheme.bgRichBlackFogra29 : AppTheme.bgLightGray,
          child: Icon(
            Icons.emoji_events,
            size: 80,
            color: isDark ? AppTheme.textLightGray.withOpacity(0.5) : AppTheme.textSmokyBlack.withOpacity(0.5),
          ),
        );
      },
    );
  }
}

class _AchievementLink extends StatefulWidget {
  final String url;
  final bool isDark;

  const _AchievementLink({
    required this.url,
    required this.isDark,
  });

  @override
  State<_AchievementLink> createState() => _AchievementLinkState();
}

class _AchievementLinkState extends State<_AchievementLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? 
                     (widget.isDark ? AppTheme.textWhite : AppTheme.textBlack);
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          constraints: const BoxConstraints(minHeight: 40),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered 
                  ? textColor.withOpacity(0.5)
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.open_in_new,
                size: 18,
                color: textColor,
              ),
              const SizedBox(width: 8),
              Text(
                'View',
                style: TextStyle(
                  color: textColor,
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

