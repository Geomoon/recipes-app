import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes_app/features/recipe_types/domain/entities/get_recipe_type_model.dart';
import 'package:recipes_app/features/recipe_types/presentation/bloc/tab_selector/tab_selector_cubit.dart';

class RecipeTypeListTile extends StatelessWidget {
  const RecipeTypeListTile({
    super.key,
    required this.onTap,
    required this.item,
    required this.width,
    this.isSelected = false,
  });

  final void Function()? onTap;
  final GetRecipeTypeModel item;
  final bool isSelected;
  final double width;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return CustomPaint(
      painter: _BookmarkPainter(
        isSelected ? Colors.amber : Colors.transparent,
      ),
      child: ListTile(
        tileColor: Colors.transparent,
        hoverColor: Colors.transparent,
        selectedTileColor: Colors.transparent,
        leading: isSelected ? const SizedBox(width: 2) : null,
        minLeadingWidth: 4,
        onTap: () {
          context.read<TabSelectorCubit>().setTab(item.id);
        },
        title: Text(
          item.name,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : null,
            color: isSelected ? colors.onPrimary : null,
          ),
        ),
      ),
    );
  }
}

class _BookmarkPainter extends CustomPainter {
  final Color color;

  _BookmarkPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bookmarkPaint = Paint()..color = color;

    final Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width * 0.9, size.height / 2)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, bookmarkPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
