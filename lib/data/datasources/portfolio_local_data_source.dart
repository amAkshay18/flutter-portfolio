import '../../domain/entities/project.dart';
import '../../domain/entities/skill.dart';
import '../models/project_model.dart';
import '../models/skill_model.dart';

class PortfolioLocalDataSource {
  List<Project> getProjects() {
    return const [
      // Industry projects
      ProjectModel(
        id: 'industry_1',
        title: 'Onwords Smart Things',
        imagePath: 'assets/industry projects/Onwords Smart Solutions App.png',
        appStoreLink:
            'https://play.google.com/store/apps/details?id=com.onwords.smart_things&pcampaignid=web_share',
        subtitle: 'Play Store',
      ),
      ProjectModel(
        id: 'industry_2',
        title: 'Onwords Workspace',
        imagePath: 'assets/industry projects/Onwords Workspace App.png',
        appStoreLink:
            'https://play.google.com/store/apps/details?id=com.office.onwords&pcampaignid=web_share',
        subtitle: 'Play Store',
      ),
      ProjectModel(
        id: 'industry_3',
        title: 'AZ eWallet',
        imagePath: 'assets/industry projects/AZ eWallet App.png',
        appStoreLink:
            'https://play.google.com/store/apps/details?id=com.azewallet&pcampaignid=web_share',
        subtitle: 'Play Store',
      ),
      // Personal projects
      ProjectModel(
        id: 'personal_1',
        title: 'LeafLoom: Your Green Gateway to Premium Plants!',
        imagePath: 'assets/images/leafloomhome.png',
        appStoreLink: 'https://www.amazon.com/dp/B0D8C1DNB8/ref=apps_sf_sta',
        githubLink: 'https://github.com/amAkshay18/LeafLoom-E-Commerce-App',
        subtitle: 'GitHub Link',
      ),
      ProjectModel(
        id: 'personal_2',
        title: 'MeloVibe: Your Ultimate Offline Music Experience!',
        imagePath: 'assets/images/melovibe.png',
        appStoreLink: 'https://www.amazon.com/dp/B0D413D2RZ/ref=apps_sf_sta',
        githubLink: 'https://github.com/amAkshay18/Melovibe',
        subtitle: 'GitHub Link',
      ),
      ProjectModel(
        id: 'personal_3',
        title: 'Sky Cast: Your Ultimate Weather Companion for Real-Time Forecasts!',
        imagePath: 'assets/images/Skycast.png',
        githubLink: 'https://github.com/amAkshay18/Weather-App-using-API-getX',
        subtitle: 'GitHub Link',
      ),
    ];
  }

  List<Skill> getSkills() {
    return const [
      SkillModel(name: 'Dart', percentage: 85),
      SkillModel(name: 'Flutter', percentage: 70),
      SkillModel(name: 'State Managements', percentage: 65),
      SkillModel(name: 'Rest Api Integration', percentage: 80),
      SkillModel(name: 'Firebase', percentage: 75),
    ];
  }
}

