import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:recipes_app/features/recipe_ingredients/domain/entities/create_recipe_ingredient.dart';
import 'package:recipes_app/features/recipe_ingredients/presentation/bloc/recipe_ingredient_form/recipe_ingredient_form_bloc.dart';

class RecipeIngredientsForm extends StatelessWidget {
  const RecipeIngredientsForm({super.key, required this.onSuccess});

  final void Function(CreateRecipeIngredient) onSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecipeIngredientFormBloc(
        onSuccess: onSuccess,
      ),
      child: _FormViewProvider(),
    );
  }
}

class _FormViewProvider extends StatelessWidget {
  _FormViewProvider();

  final _controllerDescription = TextEditingController();
  final _controllerQuantity = TextEditingController();
  final _controllerType = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                Icons.fastfood_rounded,
                color: colors.onSecondaryContainer,
              ),
              const SizedBox(width: 10),
              Text(
                'Ingredients',
                style: textTheme.headlineSmall?.copyWith(
                  color: colors.onSecondaryContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _IngredientInput(_controllerDescription),
              ),
              Expanded(
                flex: 1,
                child: _QuantityInput(_controllerQuantity),
              ),
              Expanded(
                flex: 1,
                child: _MeasureInput(_controllerType),
              ),
              Expanded(
                flex: 1,
                child: TextButton.icon(
                  onPressed: () {
                    context
                        .read<RecipeIngredientFormBloc>()
                        .add(const Submit());

                    _controllerDescription.clear();
                    _controllerQuantity.clear();
                    _controllerType.clear();
                    context.read<RecipeIngredientFormBloc>().add(const Reset());
                  },
                  label: const Text('Add'),
                  icon: const Icon(Icons.add_circle_rounded),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _MeasureInput extends StatelessWidget {
  const _MeasureInput(this._controller);

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeIngredientFormBloc, RecipeIngredientFormState>(
      builder: (context, state) {
        return TextFormField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Measure'),
          onChanged: (value) => context
              .read<RecipeIngredientFormBloc>()
              .add(ChangeQuantityTypeInput(value)),
        );
      },
    );
  }
}

class _QuantityInput extends StatelessWidget {
  const _QuantityInput(this._controller);

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeIngredientFormBloc, RecipeIngredientFormState>(
      builder: (context, state) {
        return TextFormField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Quantity'),
          // validator: NumericValidator.validate,
          onChanged: (value) => context
              .read<RecipeIngredientFormBloc>()
              .add(ChangeQuantityInput(value)),
        );
      },
    );
  }
}

class _IngredientInput extends StatelessWidget {
  const _IngredientInput(this._controller);

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeIngredientFormBloc, RecipeIngredientFormState>(
      buildWhen: (previous, current) =>
          previous.ingredient.value != current.ingredient.value,
      builder: (context, state) {
        return TextFormField(
          controller: _controller,
          onChanged: (value) => context
              .read<RecipeIngredientFormBloc>()
              .add(ChangeIngredientInput(value)),
          decoration: const InputDecoration(hintText: 'Ingredient'),
        );
      },
    );
  }
}
