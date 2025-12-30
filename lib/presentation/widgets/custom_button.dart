import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultBgColor = backgroundColor ?? (isDark ? AppTheme.bgSmokyBlack : AppTheme.bgEerieBlack);
    final defaultTextColor = textColor ?? (isDark ? AppTheme.textWhite : AppTheme.textWhite);

    return _CustomButtonWithHover(
      onPressed: onPressed,
      defaultBgColor: defaultBgColor,
      defaultTextColor: defaultTextColor,
      text: text,
    );
  }
}

class _CustomButtonWithHover extends StatefulWidget {
  final VoidCallback? onPressed;
  final Color defaultBgColor;
  final Color defaultTextColor;
  final String text;

  const _CustomButtonWithHover({
    required this.onPressed,
    required this.defaultBgColor,
    required this.defaultTextColor,
    required this.text,
  });

  @override
  State<_CustomButtonWithHover> createState() => _CustomButtonWithHoverState();
}

class _CustomButtonWithHoverState extends State<_CustomButtonWithHover> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hoverBgColor = isDark
        ? widget.defaultBgColor.withOpacity(0.8)
        : Color.alphaBlend(
            Colors.white.withOpacity(0.2),
            widget.defaultBgColor,
          );

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
          decoration: BoxDecoration(
            color: _isHovered ? hoverBgColor : widget.defaultBgColor,
            borderRadius: BorderRadius.circular(AppTheme.radiusPill),
            boxShadow: [
              BoxShadow(
                color: widget.defaultBgColor.withOpacity(_isHovered ? 0.4 : 0.3),
                blurRadius: _isHovered ? 20 : 15,
                offset: Offset(0, _isHovered ? 6 : 5),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                color: widget.defaultTextColor,
                fontSize: AppTheme.fontSize9,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

