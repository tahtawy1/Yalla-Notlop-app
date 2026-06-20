import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/core/extension/context_extension.dart';
import 'package:yalla_notlop_app/core/services/service_locator.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/core/utils/app_snack_bar.dart';
import 'package:yalla_notlop_app/features/home/presentation/view/widgets/floating_action_button.dart';
import 'package:yalla_notlop_app/features/home/presentation/view_model/home_cubit/home_cubit.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/view_model/manage_categories_cubit/manage_categories_cubit.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/manage_categories/widgets/add_category_dialog.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/manage_categories/widgets/category_card.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/manage_categories/widgets/delete_category_dialog.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/manage_categories/widgets/edit_category_dialog.dart';

class ManageCategoriesView extends StatelessWidget {
  const ManageCategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ManageCategoriesCubit>()..getCategories(),
      child: const ManageCategoriesBody(),
    );
  }
}

class ManageCategoriesBody extends StatelessWidget {
  const ManageCategoriesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ManageCategoriesCubit, ManageCategoriesState>(
      listener: (context, state) {
        if (state is ManageCategoriesActionSuccess) {
          AppSnackBar.showSnackBar(
            context,
            state.message,
            SnackBarType.success,
          );
          context.read<HomeCubit>().loadHomeData();
        } else if (state is ManageCategoriesActionError) {
          AppSnackBar.showSnackBar(context, state.message, SnackBarType.error);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            context.l10n.manageCategories,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w800,
              fontSize: 18,
              color: AppColors.splashTitleColor,
            ),
          ),
        ),
        floatingActionButton: SizedBox(
          width: double.infinity,
          child: FAButton(
            onTap: () => _showAddDialog(context),
            icon: Icons.add,
            title: context.l10n.addCategory,
            mainAxisAlignment: MainAxisAlignment.start,
            padding: 24,
          ),
        ),
        body: BlocBuilder<ManageCategoriesCubit, ManageCategoriesState>(
          builder: (context, state) {
            if (state is ManageCategoriesLoading ||
                state is ManageCategoriesActionLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.secondaryColor,
                ),
              );
            }

            if (state is ManageCategoriesError) {
              return _ErrorBody(message: state.message);
            }

            if (state is ManageCategoriesEmpty) {
              return _EmptyBody();
            }

            if (state is ManageCategoriesLoaded) {
              return _LoadedBody(state: state);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final cubit = context.read<ManageCategoriesCubit>();
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: AddCategoryDialog(onAdd: (name) => cubit.addCategory(name)),
      ),
    );
  }
}

class _LoadedBody extends StatelessWidget {
  const _LoadedBody({required this.state});

  final ManageCategoriesLoaded state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 12, bottom: 100),
      itemCount: state.categories.length,
      itemBuilder: (context, index) {
        final category = state.categories[index];
        final linkedCount = state.categoryUsageCount[category.id] ?? 0;
        final cubit = context.read<ManageCategoriesCubit>();

        return CategoryCard(
          category: category,
          linkedCount: linkedCount,
          onEdit: () {
            showDialog(
              context: context,
              builder: (_) => BlocProvider.value(
                value: cubit,
                child: EditCategoryDialog(
                  category: category,
                  onSave: (newName) => cubit.editCategory(category, newName),
                ),
              ),
            );
          },
          onDelete: () {
            showDialog(
              context: context,
              builder: (_) => BlocProvider.value(
                value: cubit,
                child: DeleteCategoryDialog(
                  category: category,
                  linkedCount: linkedCount,
                  allCategories: state.categories,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _EmptyBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        context.l10n.noCategoriesAvailable,
        style: const TextStyle(
          fontFamily: 'Cairo',
          fontSize: 16,
          color: Colors.grey,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            size: 56,
            color: AppColors.dangerColor,
          ),
          const SizedBox(height: 12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14,
              color: AppColors.restaurantTextMuted,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () =>
                context.read<ManageCategoriesCubit>().getCategories(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(
              Icons.refresh_rounded,
              color: Colors.white,
              size: 18,
            ),
            label: Text(
              context.l10n.categories,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
