import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../providers/navigation_provider.dart';
import '../providers/theme_provider.dart';

class Header extends ConsumerWidget {
  final ScrollController scrollController;
  final Function(String)? onScrollToSection;

  const Header({
    super.key,
    required this.scrollController,
    this.onScrollToSection,
  });

  void _scrollToSection(String sectionId) {
    if (onScrollToSection != null) {
      onScrollToSection!(sectionId);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider) == AppThemeMode.dark;
    // Use a distinct color for header - darker gray for dark mode, light gray for light mode
    final backgroundColor = isDarkMode ? AppTheme.bgEerieBlack : AppTheme.bgLightGray;
    final textColor = isDarkMode ? AppTheme.textWhite : AppTheme.textBlack;

    // Responsive horizontal padding: more on desktop, less on mobile
    final horizontalPadding = MediaQuery.of(context).size.width >= 992 
        ? 80.0 
        : MediaQuery.of(context).size.width >= 768 
            ? 40.0 
            : 20.0;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: isDarkMode 
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              AppConstants.appName,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (MediaQuery.of(context).size.width >= 992) ...[
            Expanded(
              child: _buildDesktopNav(context, ref, textColor),
            ),
            const SizedBox(width: 20),
            _buildThemeToggleButton(context, ref),
          ] else
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildThemeToggleButton(context, ref),
                const SizedBox(width: 10),
                _buildMobileMenuButton(context, ref),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildDesktopNav(BuildContext context, WidgetRef ref, Color textColor) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Aggressively reduce spacing based on screen width to prevent overflow
    double spacing;
    if (screenWidth < 1100) {
      spacing = 12.0;
    } else if (screenWidth < 1200) {
      spacing = 20.0;
    } else if (screenWidth < 1400) {
      spacing = 30.0;
    } else {
      spacing = 50.0;
    }
    
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _NavItem(
            text: AppStrings.about,
            onTap: () => _scrollToSection('about'),
            textColor: textColor,
          ),
          SizedBox(width: spacing),
          _NavItem(
            text: AppStrings.projects,
            onTap: () => _scrollToSection('project'),
            textColor: textColor,
          ),
          SizedBox(width: spacing),
          _NavItem(
            text: AppStrings.certifications,
            onTap: () => _scrollToSection('certifications'),
            textColor: textColor,
          ),
          SizedBox(width: spacing),
          _NavItem(
            text: AppStrings.achievements,
            onTap: () => _scrollToSection('achievements'),
            textColor: textColor,
          ),
          SizedBox(width: spacing),
          _NavItem(
            text: AppStrings.contact,
            onTap: () => _scrollToSection('contact'),
            textColor: textColor,
          ),
          SizedBox(width: spacing),
          _NavItem(
            text: AppStrings.resume,
            onTap: () async {
              final uri = Uri.parse(AppConstants.resumeUrl);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            },
            textColor: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildThemeToggleButton(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider) == AppThemeMode.dark;
    final backgroundColor = isDarkMode ? AppTheme.bgEerieBlack : AppTheme.bgLightGray;
    final iconColor = isDarkMode ? AppTheme.textWhite : AppTheme.textBlack;

    return _HoverableButton(
      onTap: () => ref.read(themeProvider.notifier).toggleTheme(),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          isDarkMode ? Icons.light_mode : Icons.dark_mode,
          color: iconColor,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildMobileMenuButton(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider) == AppThemeMode.dark;
    final backgroundColor = isDarkMode ? AppTheme.bgSmokyBlack : AppTheme.bgLightGray;
    final iconColor = isDarkMode ? AppTheme.bgBlack : AppTheme.textBlack;

    return _HoverableButton(
      onTap: () => ref.read(navigationProvider.notifier).toggleMenu(),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 24,
              height: 2,
              color: iconColor,
            ),
            const SizedBox(height: 6),
            Container(
              width: 24,
              height: 2,
              color: iconColor,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final Color? textColor;

  const _NavItem({
    required this.text,
    required this.onTap,
    this.textColor,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultTextColor = widget.textColor ?? Theme.of(context).textTheme.bodyLarge?.color ?? 
                            (isDark ? AppTheme.textWhite : AppTheme.textBlack);
    final hoverBgColor = isDark 
        ? AppTheme.bgEerieBlack.withOpacity(0.3)
        : AppTheme.bgLightGray.withOpacity(0.5);
    
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
              letterSpacing: 0.5,
            ),
            child: Text(widget.text),
          ),
        ),
      ),
    );
  }
}

class _HoverableButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _HoverableButton({
    required this.child,
    required this.onTap,
  });

  @override
  State<_HoverableButton> createState() => _HoverableButtonState();
}

class _HoverableButtonState extends State<_HoverableButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: isDark 
                          ? Colors.white.withOpacity(0.1)
                          : Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

