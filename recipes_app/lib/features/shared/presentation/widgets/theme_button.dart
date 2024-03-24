import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes_app/features/shared/presentation/cubit/theme_cubit/theme_cubit.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({super.key});

  Icon _getIcon(ThemeMode mode) {
    if (mode == ThemeMode.dark) {
      return const Icon(Icons.dark_mode_rounded);
    }
    if (mode == ThemeMode.light) {
      return const Icon(Icons.light_mode_rounded);
    }
    return const Icon(Icons.auto_mode_rounded);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeCubit>();
    return Padding(
      padding: const EdgeInsets.all(10),
      child: IconButton.filledTonal(
        onPressed: context.read<ThemeCubit>().toggle,
        icon: _getIcon(theme.state),
      ),
    );
  }
}
