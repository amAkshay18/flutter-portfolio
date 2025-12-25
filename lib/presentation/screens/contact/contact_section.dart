import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:email_validator/email_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../providers/portfolio_provider.dart';
import '../../widgets/custom_button.dart';

class _BuiltWithFlutter extends StatefulWidget {
  const _BuiltWithFlutter();

  @override
  State<_BuiltWithFlutter> createState() => _BuiltWithFlutterState();
}

class _BuiltWithFlutterState extends State<_BuiltWithFlutter> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _fadeAnimation = Tween<double>(
      begin: 0.6,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.98,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? 
                     (isDark ? AppTheme.textWhite : AppTheme.textBlack);
    final flutterColor = isDark ? const Color(0xFF60A5FA) : const Color(0xFF2563EB);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Built with ',
                  style: TextStyle(
                    fontSize: AppTheme.fontSize9,
                    fontWeight: FontWeight.w400,
                    color: textColor,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  'Flutter',
                  style: TextStyle(
                    fontSize: AppTheme.fontSize9,
                    fontWeight: FontWeight.w600,
                    color: flutterColor,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ContactSection extends ConsumerWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppStrings.getHoldOf,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -1,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'I look forward to contribute and learn with your team.',
              style: TextStyle(
                fontSize: AppTheme.fontSize8,
                color: isDark ? AppTheme.textLightGray : AppTheme.textSmokyBlack,
                height: 1.6,
                letterSpacing: 0.3,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
            LayoutBuilder(
              builder: (context, constraints) {
                final padding = constraints.maxWidth < 600 ? 24.0 : 50.0;
                return Container(
                  padding: EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                    color: isDark ? AppTheme.bgEerieBlack : AppTheme.bgWhite,
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                      color: isDark 
                          ? AppTheme.borderEerieBlack.withOpacity(0.5)
                          : AppTheme.borderGainsboro,
                      width: 1,
                    ),
                  ),
                  child: _ContactForm(),
                );
              },
            ),
            const SizedBox(height: 60),
            _SocialLinks(),
            const SizedBox(height: 40),
            _BuiltWithFlutter(),
          ],
        ),
      ),
    );
  }
}

class _SocialLinks extends StatelessWidget {
  const _SocialLinks();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;
        final spacing = isSmallScreen ? 12.0 : 24.0;
        
        return Wrap(
          alignment: WrapAlignment.center,
          spacing: spacing,
          runSpacing: spacing,
          children: [
            _SocialLink(
              icon: FontAwesomeIcons.linkedin,
              url: AppConstants.linkedInUrl,
              brandColor: const Color(0xFF0077B5), // LinkedIn blue
            ),
            _SocialLink(
              icon: FontAwesomeIcons.github,
              url: AppConstants.githubUrl,
              brandColor: const Color(0xFF333333), // GitHub black/gray
            ),
            _SocialLink(
              icon: FontAwesomeIcons.code,
              url: AppConstants.leetcodeUrl,
              brandColor: const Color(0xFFFFA116), // LeetCode orange
            ),
            _SocialLink(
              icon: FontAwesomeIcons.instagram,
              url: AppConstants.instagramUrl,
              brandColor: const Color(0xFFE4405F), // Instagram pink/red
            ),
            _SocialLink(
              icon: FontAwesomeIcons.twitter,
              url: AppConstants.twitterUrl,
              brandColor: const Color(0xFF1DA1F2), // Twitter blue
            ),
            _SocialLink(
              icon: FontAwesomeIcons.envelope,
              url: 'mailto:akshaypprabhakaran@gmail.com',
              brandColor: const Color(0xFFEA4335), // Gmail red
              isEmail: true,
            ),
          ],
        );
      },
    );
  }
}

class _SocialLink extends StatefulWidget {
  final IconData icon;
  final String url;
  final Color brandColor;
  final bool isEmail;

  const _SocialLink({
    required this.icon,
    required this.url,
    required this.brandColor,
    this.isEmail = false,
  });

  @override
  State<_SocialLink> createState() => _SocialLinkState();
}

class _SocialLinkState extends State<_SocialLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultIconColor = Theme.of(context).textTheme.bodyLarge?.color ?? 
                            (isDark ? AppTheme.textWhite : AppTheme.textBlack);
    
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(widget.url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(
              uri,
              mode: widget.isEmail 
                  ? LaunchMode.externalApplication
                  : LaunchMode.externalApplication,
            );
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? AppTheme.bgEerieBlack : AppTheme.bgLightGray,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            widget.icon,
            color: _isHovered ? widget.brandColor : defaultIconColor,
            size: 24,
          ),
        ),
      ),
    );
  }
}

class _ContactForm extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(contactFormProvider);
    final formNotifier = ref.read(contactFormProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _TextField(
          hint: AppStrings.fullName,
          onChanged: formNotifier.updateName,
          value: formState.name,
          keyboardType: TextInputType.name,
        ),
        const SizedBox(height: 24),
        _TextField(
          hint: AppStrings.emailAddress,
          onChanged: formNotifier.updateEmail,
          value: formState.email,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 24),
        _TextField(
          hint: AppStrings.enterMessage,
          onChanged: formNotifier.updateMessage,
          value: formState.message,
          maxLines: 6,
          maxLength: 200,
        ),
        const SizedBox(height: 48),
        SizedBox(
          width: double.infinity,
          child: CustomButton(
            text: AppStrings.submit,
            onPressed: formState.isLoading ? null : () => _handleSubmit(context, ref),
          ),
        ),
        if (formState.error != null)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              formState.error!,
              style: TextStyle(
                color: Colors.red.shade400,
                fontSize: AppTheme.fontSize10,
              ),
            ),
          ),
        if (formState.success == true)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              AppStrings.formSubmittedSuccess,
              style: TextStyle(
                color: Colors.green.shade600,
                fontSize: AppTheme.fontSize10,
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _handleSubmit(BuildContext context, WidgetRef ref) async {
    final formState = ref.read(contactFormProvider);
    final formNotifier = ref.read(contactFormProvider.notifier);

    // Validation
    if (formState.name.isEmpty ||
        formState.email.isEmpty ||
        formState.message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.emptyFieldError)),
      );
      return;
    }

    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(formState.name.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.nameValidationError)),
      );
      return;
    }

    if (!EmailValidator.validate(formState.email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.emailValidationError)),
      );
      return;
    }
    
    if (formState.message.length > 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message must be 200 characters or less')),
      );
      return;
    }

    await formNotifier.submitForm();
    
    if (ref.read(contactFormProvider).success == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.formSubmittedSuccess)),
      );
    }
  }
}

class _TextField extends StatefulWidget {
  final String hint;
  final ValueChanged<String> onChanged;
  final String value;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? maxLength;

  const _TextField({
    required this.hint,
    required this.onChanged,
    required this.value,
    this.keyboardType,
    this.maxLines,
    this.maxLength,
  });

  @override
  State<_TextField> createState() => _TextFieldState();
}

class _TextFieldState extends State<_TextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? 
                     (isDark ? AppTheme.textWhite : AppTheme.textBlack);
    final hintColor = isDark ? AppTheme.textLightGray.withOpacity(0.6) : AppTheme.textSmokyBlack.withOpacity(0.6);
    final enabledBorderColor = isDark 
        ? AppTheme.borderEerieBlack.withOpacity(0.3)
        : AppTheme.borderGainsboro;
    final focusedBorderColor = isDark 
        ? AppTheme.textWhite.withOpacity(0.6)
        : AppTheme.bgBlack;
    final bgColor = isDark 
        ? AppTheme.bgRichBlackFogra29.withOpacity(0.5)
        : AppTheme.bgLightGray.withOpacity(0.5);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _isFocused ? focusedBorderColor : enabledBorderColor,
          width: _isFocused ? 2 : 1,
        ),
        boxShadow: _isFocused
            ? [
                BoxShadow(
                  color: (isDark ? AppTheme.textWhite : AppTheme.bgBlack)
                      .withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 5),
                  spreadRadius: 0,
                ),
              ]
            : [],
      ),
      child: TextField(
        focusNode: _focusNode,
        controller: TextEditingController(text: widget.value)
          ..selection = TextSelection.collapsed(offset: widget.value.length),
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType,
        maxLines: widget.maxLines ?? 1,
        maxLength: widget.maxLength,
        style: TextStyle(
          color: textColor,
          fontSize: AppTheme.fontSize8,
          fontWeight: FontWeight.w400,
          height: widget.maxLines != null ? 1.6 : 1.0,
          letterSpacing: 0.2,
        ),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(
            color: hintColor,
            fontSize: AppTheme.fontSize8,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.2,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          counterText: widget.maxLength != null ? '${widget.value.length}/${widget.maxLength}' : null,
          counterStyle: TextStyle(
            color: hintColor,
            fontSize: AppTheme.fontSize10,
          ),
        ),
      ),
    );
  }
}


