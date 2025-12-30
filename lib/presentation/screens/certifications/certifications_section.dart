import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_theme.dart';

class CertificationsSection extends StatelessWidget {
  const CertificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Certification data - 11 certifications
    final certifications = [
      _CertificationItem(
        title: 'Udemy Certificate 1',
        imageUrl: null, // Will be set when certificate image is added
        linkUrl: 'https://drive.google.com/file/d/1MBHXiD2q2Q6FVUc6bA4X8z2J-XIvK9B1/view?usp=sharing',
        description: 'Flutter Development Course Completion',
      ),
      _CertificationItem(
        title: 'Udemy Certificate 2',
        imageUrl: null, // Will be set when certificate image is added
        linkUrl: 'https://drive.google.com/file/d/1ATpjn9z8rrFvHwpzxXU28Q9aTy5c04UO/view?usp=sharing',
        description: 'Advanced Flutter & Dart Programming',
      ),
      _CertificationItem(
        title: 'Udemy Certificate 3',
        imageUrl: null,
        linkUrl: 'https://www.udemy.com/',
        description: 'Complete Flutter App Development Bootcamp',
      ),
      _CertificationItem(
        title: 'Udemy Certificate 4',
        imageUrl: null,
        linkUrl: 'https://www.udemy.com/',
        description: 'Dart Programming Language Mastery',
      ),
      _CertificationItem(
        title: 'Udemy Certificate 5',
        imageUrl: null,
        linkUrl: 'https://www.udemy.com/',
        description: 'Flutter State Management with Provider & Riverpod',
      ),
      _CertificationItem(
        title: 'Udemy Certificate 6',
        imageUrl: null,
        linkUrl: 'https://www.udemy.com/',
        description: 'Firebase Integration with Flutter',
      ),
      _CertificationItem(
        title: 'Udemy Certificate 7',
        imageUrl: null,
        linkUrl: 'https://www.udemy.com/',
        description: 'REST API Integration in Flutter',
      ),
      _CertificationItem(
        title: 'Udemy Certificate 8',
        imageUrl: null,
        linkUrl: 'https://www.udemy.com/',
        description: 'Flutter UI/UX Design Principles',
      ),
      _CertificationItem(
        title: 'Udemy Certificate 9',
        imageUrl: null,
        linkUrl: 'https://www.udemy.com/',
        description: 'Flutter Testing & Quality Assurance',
      ),
      _CertificationItem(
        title: 'Udemy Certificate 10',
        imageUrl: null,
        linkUrl: 'https://www.udemy.com/',
        description: 'Flutter Animation & Advanced UI',
      ),
      _CertificationItem(
        title: 'Udemy Certificate 11',
        imageUrl: null,
        linkUrl: 'https://www.udemy.com/',
        description: 'Flutter Performance Optimization',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Certifications',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 50),
        _CertificationsList(certifications: certifications),
      ],
    );
  }
}

class _CertificationItem {
  final String title;
  final String? imageUrl;
  final String? linkUrl;
  final String description;

  _CertificationItem({
    required this.title,
    this.imageUrl,
    this.linkUrl,
    required this.description,
  });
}

class _CertificationsList extends StatelessWidget {
  final List<_CertificationItem> certifications;

  const _CertificationsList({required this.certifications});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth >= 768 ? 450.0 : constraints.maxWidth * 0.85;
        final cardHeight = constraints.maxWidth >= 768 ? 600.0 : 550.0;
        
        return Container(
          height: cardHeight,
          clipBehavior: Clip.none,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            itemCount: certifications.length,
            itemBuilder: (context, index) {
              return Container(
                width: cardWidth,
                margin: EdgeInsets.only(
                  right: index < certifications.length - 1 ? 40 : 0,
                ),
                padding: const EdgeInsets.all(8), // Padding to accommodate scale transformation
                clipBehavior: Clip.none, // Allow overflow for hover effects
                child: _CertificationCard(certification: certifications[index]),
              );
            },
          ),
        );
      },
    );
  }
}

class _CertificationCard extends StatefulWidget {
  final _CertificationItem certification;

  const _CertificationCard({required this.certification});

  @override
  State<_CertificationCard> createState() => _CertificationCardState();
}

class _CertificationCardState extends State<_CertificationCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
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
          // Certification Image or Placeholder
          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: _CertificationImage(certification: widget.certification),
            ),
          ),
          // Certification Info
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
                              widget.certification.title,
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
                              widget.certification.description,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: isDark ? AppTheme.textLightGray : AppTheme.textSmokyBlack,
                                fontSize: constraints.maxWidth < 400 ? 12 : AppTheme.fontSize10,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (widget.certification.linkUrl != null) ...[
                              SizedBox(height: constraints.maxWidth < 400 ? 12 : 16),
                              _CertificationLink(url: widget.certification.linkUrl!, isDark: isDark),
                            ],
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
    );
  }
}

class _CertificationImage extends StatelessWidget {
  final _CertificationItem certification;

  const _CertificationImage({required this.certification});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Placeholder if no image URL
    if (certification.imageUrl == null) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: isDark ? AppTheme.bgRichBlackFogra29 : AppTheme.bgLightGray,
        child: Icon(
          Icons.verified,
          size: 80,
          color: isDark ? AppTheme.textLightGray.withOpacity(0.5) : AppTheme.textSmokyBlack.withOpacity(0.5),
        ),
      );
    }
    
    return Image.network(
      certification.imageUrl!,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: isDark ? AppTheme.bgRichBlackFogra29 : AppTheme.bgLightGray,
          child: Icon(
            Icons.verified,
            size: 80,
            color: isDark ? AppTheme.textLightGray.withOpacity(0.5) : AppTheme.textSmokyBlack.withOpacity(0.5),
          ),
        );
      },
    );
  }
}

class _CertificationLink extends StatefulWidget {
  final String url;
  final bool isDark;

  const _CertificationLink({
    required this.url,
    required this.isDark,
  });

  @override
  State<_CertificationLink> createState() => _CertificationLinkState();
}

class _CertificationLinkState extends State<_CertificationLink> {
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
                  ? textColor.withOpacity(0.6)
                  : Colors.transparent,
              width: _isHovered ? 1.5 : 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: textColor.withOpacity(0.2),
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

