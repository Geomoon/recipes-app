import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:recipes_app/features/recipes/domain/entities/recipe_by_type.dart';
import 'package:recipes_app/features/recipes/presentation/bloc/recipe/recipe_bloc.dart';

class RecipeTile extends StatelessWidget {
  const RecipeTile({
    super.key,
    required this.recipe,
  });

  final RecipeByType recipe;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      visualDensity: VisualDensity.standard,
      title: Text(recipe.name),
      subtitle: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.people_rounded),
          const SizedBox(width: 10),
          Text('${recipe.numPortions}'),
        ],
      ),
      leading: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Image.network(
            recipe.img ?? '',
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.restaurant_rounded),
            fit: BoxFit.cover,
          ),
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Chip(
            label: Text(
              recipe.timeTxt,
              style:
                  textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            avatar: const Icon(Icons.timer_rounded),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {
              context.read<RecipeBloc>().loadRecipe(recipe.id);
              context.push('/recipe/${recipe.id}');
            },
            icon: const Icon(Icons.arrow_forward_rounded),
          ),
        ],
      ),
    );
  }
}
