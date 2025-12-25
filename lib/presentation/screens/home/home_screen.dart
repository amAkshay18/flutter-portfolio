import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/preloader.dart';
import '../../widgets/header.dart';
import '../../widgets/mobile_menu.dart';
import 'hero_section.dart';
import '../about/about_section.dart';
import '../projects/projects_section.dart';
import '../achievements/achievements_section.dart';
import '../certifications/certifications_section.dart';
import '../contact/contact_section.dart';
import 'footer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _projectKey = GlobalKey();
  final GlobalKey _achievementsKey = GlobalKey();
  final GlobalKey _certificationsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(String sectionId) {
    GlobalKey? targetKey;
    
    switch (sectionId) {
      case 'home':
        targetKey = _homeKey;
        break;
      case 'about':
        targetKey = _aboutKey;
        break;
      case 'project':
        targetKey = _projectKey;
        break;
      case 'achievements':
        targetKey = _achievementsKey;
        break;
      case 'certifications':
        targetKey = _certificationsKey;
        break;
      case 'contact':
        targetKey = _contactKey;
        break;
    }

    if (targetKey != null && targetKey.currentContext != null) {
      Scrollable.ensureVisible(
        targetKey.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Scrollable Content
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.only(top: 80), // Space for fixed header
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Responsive horizontal padding: more on desktop, less on mobile
                final horizontalPadding = constraints.maxWidth >= 992 
                    ? 80.0 
                    : constraints.maxWidth >= 768 
                        ? 40.0 
                        : 20.0;
                
                return Column(
                  children: [
                    // Hero Section
                    Container(
                      key: _homeKey,
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: 80,
                      ),
                      child: const HeroSection(),
                    ),
                    
                    // About Section
                    Container(
                      key: _aboutKey,
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: 80,
                      ),
                      child: const AboutSection(),
                    ),
                    
                    // Projects Section
                    Container(
                      key: _projectKey,
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: 80,
                      ),
                      child: const ProjectsSection(),
                    ),
                    
                    // Certifications Section
                    Container(
                      key: _certificationsKey,
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: 80,
                      ),
                      child: const CertificationsSection(),
                    ),
                    
                    // Achievements Section
                    Container(
                      key: _achievementsKey,
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: 80,
                      ),
                      child: const AchievementsSection(),
                    ),
                    
                    // Contact Section
                    Container(
                      key: _contactKey,
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: 80,
                      ),
                      child: const ContactSection(),
                    ),
                    
                    // Footer
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                      child: const Footer(),
                    ),
                  ],
                );
              },
            ),
          ),
          
          // Fixed Header (on top of everything)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Header(
              scrollController: _scrollController,
              onScrollToSection: _scrollToSection,
            ),
          ),
          
          // Mobile Menu
          MobileMenu(onScrollToSection: _scrollToSection),
          
          // Preloader
          const Preloader(),
        ],
      ),
    );
  }
}

