import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_theme.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppTheme.textLightGray : AppTheme.textSmokyBlack;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.aboutMe,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 40),
        Text(
          "I'm a Flutter developer passionate about creating beautiful and performant cross-platform mobile applications. With expertise in Dart programming and Flutter framework, I specialize in building intuitive user interfaces and seamless user experiences. I'm constantly learning new technologies and best practices to deliver high-quality mobile solutions that make a positive impact.",
          style: TextStyle(
            fontSize: AppTheme.fontSize8,
            fontWeight: FontWeight.w400,
            color: textColor,
            height: 1.75,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}
