import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../providers/navigation_provider.dart';

class MobileMenu extends ConsumerWidget {
  final Function(String)? onScrollToSection;

  const MobileMenu({
    super.key,
    this.onScrollToSection,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMenuOpen = ref.watch(
      navigationProvider.select((state) => state.isMenuOpen),
    );
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final overlayColor = isDark 
        ? AppTheme.bgBlack.withOpacity(0.5) 
        : AppTheme.bgBlack.withOpacity(0.3);
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? 
                     (isDark ? AppTheme.textWhite : AppTheme.textBlack);
    final borderColor = isDark ? AppTheme.borderSmokyBlack : AppTheme.borderGainsboro;

    if (!isMenuOpen) {
      return const SizedBox.shrink();
    }

    return Stack(
      children: [
        // Overlay
        Positioned.fill(
          child: GestureDetector(
            onTap: () => ref.read(navigationProvider.notifier).closeMenu(),
            child: Container(
              color: overlayColor,
            ),
          ),
        ),
        // Menu
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          width: 300,
          child: Container(
            color: bgColor,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Akshay Pulikkottil',
                      style: TextStyle(
                        fontSize: AppTheme.fontSize6,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: textColor),
                      onPressed: () => ref.read(navigationProvider.notifier).closeMenu(),
                    ),
                  ],
                ),
                Divider(color: borderColor),
                const SizedBox(height: 10),
                _MenuItem(
                  text: AppStrings.about,
                  onTap: () {
                    ref.read(navigationProvider.notifier).closeMenu();
                    if (onScrollToSection != null) {
                      onScrollToSection!('about');
                    }
                  },
                ),
                _MenuItem(
                  text: AppStrings.projects,
                  onTap: () {
                    ref.read(navigationProvider.notifier).closeMenu();
                    if (onScrollToSection != null) {
                      onScrollToSection!('project');
                    }
                  },
                ),
                _MenuItem(
                  text: AppStrings.certifications,
                  onTap: () {
                    ref.read(navigationProvider.notifier).closeMenu();
                    if (onScrollToSection != null) {
                      onScrollToSection!('certifications');
                    }
                  },
                ),
                _MenuItem(
                  text: AppStrings.achievements,
                  onTap: () {
                    ref.read(navigationProvider.notifier).closeMenu();
                    if (onScrollToSection != null) {
                      onScrollToSection!('achievements');
                    }
                  },
                ),
                _MenuItem(
                  text: AppStrings.contact,
                  onTap: () {
                    ref.read(navigationProvider.notifier).closeMenu();
                    if (onScrollToSection != null) {
                      onScrollToSection!('contact');
                    }
                  },
                ),
                _MenuItem(
                  text: AppStrings.resume,
                  onTap: () async {
                    ref.read(navigationProvider.notifier).closeMenu();
                    final uri = Uri.parse(AppConstants.resumeUrl);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri, mode: LaunchMode.externalApplication);
                    }
                  },
                  textColor: Colors.red,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MenuItem extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final Color? textColor;

  const _MenuItem({
    required this.text,
    required this.onTap,
    this.textColor,
  });

  @override
  State<_MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<_MenuItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultTextColor = widget.textColor ?? 
                            (Theme.of(context).textTheme.bodyLarge?.color ?? 
                             (isDark ? AppTheme.textLightGray : AppTheme.textSmokyBlack));
    final hoverBgColor = isDark 
        ? AppTheme.bgEerieBlack.withOpacity(0.3)
        : AppTheme.bgLightGray.withOpacity(0.5);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: _isHovered ? hoverBgColor : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                color: defaultTextColor,
                fontSize: AppTheme.fontSize8,
                fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w500,
              ),
              child: Text(widget.text),
            ),
          ),
        ),
      ),
    );
  }
}

