import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_theme.dart';
import '../../widgets/custom_button.dart';

class CtaSection extends StatelessWidget {
  const CtaSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark ? AppTheme.borderEerieBlack : AppTheme.borderGainsboro;

    final bgColor = isDark ? AppTheme.bgEerieBlack : AppTheme.bgLightGray;
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(
          top: BorderSide(color: borderColor),
          bottom: BorderSide(color: borderColor),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Center(
        child: CustomButton(
          text: AppStrings.hireMeNow,
          icon: Icons.arrow_forward,
          onPressed: () {
            // Scroll to contact section
          },
        ),
      ),
    );
  }
}

