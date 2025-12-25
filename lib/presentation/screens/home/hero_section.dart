import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 768;
        
        if (isDesktop) {
          return _buildDesktopLayout(context);
        } else {
          return _buildMobileLayout(context);
        }
      },
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildHeroIntro(context),
            ],
          ),
        ),
        _buildProfileImage(),
      ],
    );
  }

  Widget _buildHeroIntro(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? AppTheme.textWhite : AppTheme.textBlack;
    final accentColor = isDark ? const Color(0xFF60A5FA) : const Color(0xFF2563EB);
    final textColor = isDark ? AppTheme.textLightGray : AppTheme.textSmokyBlack;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.w700,
              letterSpacing: -1.5,
              height: 1.2,
              fontFamily: null,
            ),
            children: [
              TextSpan(
                text: "Hi, I'm ",
                style: TextStyle(color: primaryColor),
              ),
              TextSpan(
                text: "Akshay Pulikkottil",
                style: TextStyle(color: accentColor),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Software Engineer - Flutter',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: primaryColor,
            letterSpacing: -0.5,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          'I build cross-platform mobile applications using Flutter, creating beautiful and performant user experiences. Passionate about clean code, modern UI/UX design, and delivering apps that make a difference.',
          style: TextStyle(
            fontSize: AppTheme.fontSize8,
            fontWeight: FontWeight.w400,
            color: textColor,
            height: 1.7,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 300,
          height: 500,
          child: _buildProfileImage(),
        ),
        const SizedBox(height: 50),
        _buildHeroIntroMobile(context),
      ],
    );
  }

  Widget _buildHeroIntroMobile(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? AppTheme.textWhite : AppTheme.textBlack;
    final accentColor = isDark ? const Color(0xFF60A5FA) : const Color(0xFF2563EB);
    final textColor = isDark ? AppTheme.textLightGray : AppTheme.textSmokyBlack;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w700,
              letterSpacing: -1,
              height: 1.2,
              fontFamily: null,
            ),
            children: [
              TextSpan(
                text: "Hi, I'm ",
                style: TextStyle(color: primaryColor),
              ),
              TextSpan(
                text: "Akshay Pulikkottil",
                style: TextStyle(color: accentColor),
              ),
            ],
          ),
        ),
                    const SizedBox(height: 20),
                    Text(
                      'Software Engineer - Flutter',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                        letterSpacing: -0.3,
                        height: 1.3,
                      ),
                      textAlign: TextAlign.center,
                    ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'I build cross-platform mobile applications using Flutter, creating beautiful and performant user experiences. Passionate about clean code, modern UI/UX design, and delivering apps that make a difference.',
            style: TextStyle(
              fontSize: AppTheme.fontSize8,
              fontWeight: FontWeight.w400,
              color: textColor,
              height: 1.7,
              letterSpacing: 0.3,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImage() {
    return Builder(
      builder: (context) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isMobile = screenWidth < 768;
        final imageWidth = isMobile ? 300.0 : 410.0;
        final imageHeight = isMobile ? 500.0 : 680.0;
        
        return ClipRRect(
          borderRadius: BorderRadius.circular(AppTheme.radiusPill),
          child: Image.asset(
            'assets/images/profilepicture.jpg',
            width: imageWidth,
            height: imageHeight,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}

