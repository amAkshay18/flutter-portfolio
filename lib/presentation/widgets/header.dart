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
          Text(
            AppConstants.appName,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          if (MediaQuery.of(context).size.width >= 992) ...[
            _buildDesktopNav(context, ref, textColor),
            const SizedBox(width: 20),
            _buildThemeToggleButton(context, ref),
          ] else
            Row(
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
    return Row(
      children: [
        _NavItem(
          text: AppStrings.about,
          onTap: () => _scrollToSection('about'),
          textColor: textColor,
        ),
        const SizedBox(width: 50),
        _NavItem(
          text: AppStrings.projects,
          onTap: () => _scrollToSection('project'),
          textColor: textColor,
        ),
        const SizedBox(width: 50),
        _NavItem(
          text: AppStrings.certifications,
          onTap: () => _scrollToSection('certifications'),
          textColor: textColor,
        ),
        const SizedBox(width: 50),
        _NavItem(
          text: AppStrings.achievements,
          onTap: () => _scrollToSection('achievements'),
          textColor: textColor,
        ),
        const SizedBox(width: 50),
        _NavItem(
          text: AppStrings.contact,
          onTap: () => _scrollToSection('contact'),
          textColor: textColor,
        ),
        const SizedBox(width: 50),
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
    );
  }

  Widget _buildThemeToggleButton(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider) == AppThemeMode.dark;
    final backgroundColor = isDarkMode ? AppTheme.bgEerieBlack : AppTheme.bgLightGray;
    final iconColor = isDarkMode ? AppTheme.textWhite : AppTheme.textBlack;

    return GestureDetector(
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

    return GestureDetector(
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

class _NavItem extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? textColor;

  const _NavItem({
    required this.text,
    required this.onTap,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            text,
            style: TextStyle(
              color: textColor ?? Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: AppTheme.fontSize8,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}

