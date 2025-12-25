import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/navigation_provider.dart';

class Preloader extends ConsumerWidget {
  const Preloader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVisible = ref.watch(
      navigationProvider.select((state) => state.isPreloaderVisible),
    );

    if (!isVisible) {
      return const SizedBox.shrink();
    }

    final bgColor = Theme.of(context).scaffoldBackgroundColor;

    return Container(
      color: bgColor,
      child: Center(
        child: Container(
          width: 1,
          height: double.infinity,
          color: bgColor,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 0.3),
            duration: const Duration(milliseconds: 1000),
            builder: (context, value, child) {
              return FractionallySizedBox(
                heightFactor: value,
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: bgColor,
                ),
              );
            },
            onEnd: () {
              Future.delayed(const Duration(milliseconds: 500), () {
                ref.read(navigationProvider.notifier).hidePreloader();
              });
            },
          ),
        ),
      ),
    );
  }
}

