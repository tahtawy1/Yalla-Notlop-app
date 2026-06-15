// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Add Category`
  String get addCategory {
    return Intl.message(
      'Add Category',
      name: 'addCategory',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while adding the category`
  String get addCategoryError {
    return Intl.message(
      'An error occurred while adding the category',
      name: 'addCategoryError',
      desc: '',
      args: [],
    );
  }

  /// `Add Meal`
  String get addMeal {
    return Intl.message('Add Meal', name: 'addMeal', desc: '', args: []);
  }

  /// `An error occurred while adding the meal`
  String get addMealError {
    return Intl.message(
      'An error occurred while adding the meal',
      name: 'addMealError',
      desc: '',
      args: [],
    );
  }

  /// `Add Meals`
  String get addMeals {
    return Intl.message('Add Meals', name: 'addMeals', desc: '', args: []);
  }

  /// `Add Restaurant`
  String get addRestaurant {
    return Intl.message(
      'Add Restaurant',
      name: 'addRestaurant',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while adding the restaurant`
  String get addRestaurantError {
    return Intl.message(
      'An error occurred while adding the restaurant',
      name: 'addRestaurantError',
      desc: '',
      args: [],
    );
  }

  /// `Add a new restaurant to 'Yalla Notlob' and start organizing group orders with your friends.`
  String get addRestaurantSubtitle {
    return Intl.message(
      'Add a new restaurant to \'Yalla Notlob\' and start organizing group orders with your friends.',
      name: 'addRestaurantSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Expand the Menu`
  String get addRestaurantTitle {
    return Intl.message(
      'Expand the Menu',
      name: 'addRestaurantTitle',
      desc: '',
      args: [],
    );
  }

  /// `All Cuisines`
  String get allCuisines {
    return Intl.message(
      'All Cuisines',
      name: 'allCuisines',
      desc: '',
      args: [],
    );
  }

  /// `Yalla Notlob`
  String get appName {
    return Intl.message('Yalla Notlob', name: 'appName', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Cancel Operation`
  String get cancelOperation {
    return Intl.message(
      'Cancel Operation',
      name: 'cancelOperation',
      desc: '',
      args: [],
    );
  }

  /// `Cannot delete the category because restaurants are linked to it`
  String get cannotDeleteCategoryWithRestaurants {
    return Intl.message(
      'Cannot delete the category because restaurants are linked to it',
      name: 'cannotDeleteCategoryWithRestaurants',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message('Categories', name: 'categories', desc: '', args: []);
  }

  /// `A category with this name already exists`
  String get categoryAlreadyExists {
    return Intl.message(
      'A category with this name already exists',
      name: 'categoryAlreadyExists',
      desc: '',
      args: [],
    );
  }

  /// `Bakery & Pastries`
  String get bakeryCategory {
    return Intl.message(
      'Bakery & Pastries',
      name: 'bakeryCategory',
      desc: '',
      args: [],
    );
  }

  /// `Category deleted successfully`
  String get categoryDeletedSuccess {
    return Intl.message(
      'Category deleted successfully',
      name: 'categoryDeletedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Fast Food`
  String get fastFoodCategory {
    return Intl.message(
      'Fast Food',
      name: 'fastFoodCategory',
      desc: '',
      args: [],
    );
  }

  /// `Enter category name`
  String get categoryNameHint {
    return Intl.message(
      'Enter category name',
      name: 'categoryNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Category Name`
  String get categoryNameLabel {
    return Intl.message(
      'Category Name',
      name: 'categoryNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Pizza & Pasta`
  String get pizzaCategory {
    return Intl.message(
      'Pizza & Pasta',
      name: 'pizzaCategory',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while deleting the category`
  String get deleteCategoryError {
    return Intl.message(
      'An error occurred while deleting the category',
      name: 'deleteCategoryError',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `An error occurred while deleting the meal`
  String get deleteMealError {
    return Intl.message(
      'An error occurred while deleting the meal',
      name: 'deleteMealError',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this restaurant? This action cannot be undone.`
  String get deleteRestaurantConfirmation {
    return Intl.message(
      'Are you sure you want to delete this restaurant? This action cannot be undone.',
      name: 'deleteRestaurantConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while deleting the restaurant`
  String get deleteRestaurantError {
    return Intl.message(
      'An error occurred while deleting the restaurant',
      name: 'deleteRestaurantError',
      desc: '',
      args: [],
    );
  }

  /// `Delete Restaurant Permanently`
  String get deleteRestaurantPermanently {
    return Intl.message(
      'Delete Restaurant Permanently',
      name: 'deleteRestaurantPermanently',
      desc: '',
      args: [],
    );
  }

  /// `Delete Restaurant`
  String get deleteRestaurantTitle {
    return Intl.message(
      'Delete Restaurant',
      name: 'deleteRestaurantTitle',
      desc: '',
      args: [],
    );
  }

  /// `This action will permanently delete all restaurant-related data.`
  String get deleteRestaurantWarning {
    return Intl.message(
      'This action will permanently delete all restaurant-related data.',
      name: 'deleteRestaurantWarning',
      desc: '',
      args: [],
    );
  }

  /// `Edit Restaurant Name`
  String get editRestaurantName {
    return Intl.message(
      'Edit Restaurant Name',
      name: 'editRestaurantName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a name`
  String get enterNameValidation {
    return Intl.message(
      'Please enter a name',
      name: 'enterNameValidation',
      desc: '',
      args: [],
    );
  }

  /// `Your Friends`
  String get friends {
    return Intl.message('Your Friends', name: 'friends', desc: '', args: []);
  }

  /// `An error occurred`
  String get genericError {
    return Intl.message(
      'An error occurred',
      name: 'genericError',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while fetching categories`
  String get fetchCategoriesError {
    return Intl.message(
      'An error occurred while fetching categories',
      name: 'fetchCategoriesError',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while fetching meals`
  String get fetchMealsError {
    return Intl.message(
      'An error occurred while fetching meals',
      name: 'fetchMealsError',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while fetching restaurants`
  String get fetchRestaurantsError {
    return Intl.message(
      'An error occurred while fetching restaurants',
      name: 'fetchRestaurantsError',
      desc: '',
      args: [],
    );
  }

  /// `Choose a restaurant to start your group order.`
  String get homeSubtitle {
    return Intl.message(
      'Choose a restaurant to start your group order.',
      name: 'homeSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Food for the Gathering`
  String get homeTitle {
    return Intl.message(
      'Food for the Gathering',
      name: 'homeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid price`
  String get invalidPriceValidation {
    return Intl.message(
      'Please enter a valid price',
      name: 'invalidPriceValidation',
      desc: '',
      args: [],
    );
  }

  /// `Meal`
  String get mealCount {
    return Intl.message('Meal', name: 'mealCount', desc: '', args: []);
  }

  /// `Enter meal name`
  String get mealNameHint {
    return Intl.message(
      'Enter meal name',
      name: 'mealNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Meal Name`
  String get mealNameLabel {
    return Intl.message('Meal Name', name: 'mealNameLabel', desc: '', args: []);
  }

  /// `Enter price`
  String get mealPriceHint {
    return Intl.message(
      'Enter price',
      name: 'mealPriceHint',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get mealPriceLabel {
    return Intl.message('Price', name: 'mealPriceLabel', desc: '', args: []);
  }

  /// `Please enter the price`
  String get mealPriceRequired {
    return Intl.message(
      'Please enter the price',
      name: 'mealPriceRequired',
      desc: '',
      args: [],
    );
  }

  /// `EGP`
  String get mealPriceSuffix {
    return Intl.message('EGP', name: 'mealPriceSuffix', desc: '', args: []);
  }

  /// `Meals`
  String get meals {
    return Intl.message('Meals', name: 'meals', desc: '', args: []);
  }

  /// `Meals List`
  String get mealsListTitle {
    return Intl.message(
      'Meals List',
      name: 'mealsListTitle',
      desc: '',
      args: [],
    );
  }

  /// `Minimum order 5 EGP`
  String get minimumOrderFallback {
    return Intl.message(
      'Minimum order 5 EGP',
      name: 'minimumOrderFallback',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message('History', name: 'history', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Orders`
  String get orders {
    return Intl.message('Orders', name: 'orders', desc: '', args: []);
  }

  /// `No Category`
  String get noCategory {
    return Intl.message('No Category', name: 'noCategory', desc: '', args: []);
  }

  /// `No image selected`
  String get noImageSelected {
    return Intl.message(
      'No image selected',
      name: 'noImageSelected',
      desc: '',
      args: [],
    );
  }

  /// `No restaurants available`
  String get noRestaurantsAvailable {
    return Intl.message(
      'No restaurants available',
      name: 'noRestaurantsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Order Now`
  String get orderNow {
    return Intl.message('Order Now', name: 'orderNow', desc: '', args: []);
  }

  /// `An error occurred while selecting the image`
  String get pickImageError {
    return Intl.message(
      'An error occurred while selecting the image',
      name: 'pickImageError',
      desc: '',
      args: [],
    );
  }

  /// `Priority will be given to the uploaded image!`
  String get uploadedImagePriorityWarning {
    return Intl.message(
      'Priority will be given to the uploaded image!',
      name: 'uploadedImagePriorityWarning',
      desc: '',
      args: [],
    );
  }

  /// `Restaurant added successfully ✓`
  String get restaurantAddedSuccess {
    return Intl.message(
      'Restaurant added successfully ✓',
      name: 'restaurantAddedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Restaurant deleted successfully`
  String get restaurantDeletedSuccess {
    return Intl.message(
      'Restaurant deleted successfully',
      name: 'restaurantDeletedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Image added successfully`
  String get restaurantImageAdded {
    return Intl.message(
      'Image added successfully',
      name: 'restaurantImageAdded',
      desc: '',
      args: [],
    );
  }

  /// `Restaurant Image`
  String get restaurantImage {
    return Intl.message(
      'Restaurant Image',
      name: 'restaurantImage',
      desc: '',
      args: [],
    );
  }

  /// `Restaurant Management`
  String get restaurantManagement {
    return Intl.message(
      'Restaurant Management',
      name: 'restaurantManagement',
      desc: '',
      args: [],
    );
  }

  /// `Example: Al Safha Restaurant`
  String get restaurantNameExample {
    return Intl.message(
      'Example: Al Safha Restaurant',
      name: 'restaurantNameExample',
      desc: '',
      args: [],
    );
  }

  /// `Enter restaurant name`
  String get restaurantNameHint {
    return Intl.message(
      'Enter restaurant name',
      name: 'restaurantNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Restaurant Name`
  String get restaurantNameLabel {
    return Intl.message(
      'Restaurant Name',
      name: 'restaurantNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the restaurant name`
  String get restaurantNameValidation {
    return Intl.message(
      'Please enter the restaurant name',
      name: 'restaurantNameValidation',
      desc: '',
      args: [],
    );
  }

  /// `Restaurant updated successfully`
  String get restaurantUpdatedSuccess {
    return Intl.message(
      'Restaurant updated successfully',
      name: 'restaurantUpdatedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Tap to add an image`
  String get restaurantUploadHint {
    return Intl.message(
      'Tap to add an image',
      name: 'restaurantUploadHint',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Save Changes`
  String get saveChanges {
    return Intl.message(
      'Save Changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Save Restaurant`
  String get saveRestaurant {
    return Intl.message(
      'Save Restaurant',
      name: 'saveRestaurant',
      desc: '',
      args: [],
    );
  }

  /// `Please select a category`
  String get selectCategoryValidation {
    return Intl.message(
      'Please select a category',
      name: 'selectCategoryValidation',
      desc: '',
      args: [],
    );
  }

  /// `Preparing Yalla Notlob...`
  String get splashLoading {
    return Intl.message(
      'Preparing Yalla Notlob...',
      name: 'splashLoading',
      desc: '',
      args: [],
    );
  }

  /// `Order together with ease`
  String get splashSubtitle {
    return Intl.message(
      'Order together with ease',
      name: 'splashSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Yalla Notlob`
  String get splashTitle {
    return Intl.message(
      'Yalla Notlob',
      name: 'splashTitle',
      desc: '',
      args: [],
    );
  }

  /// `Start Group Order`
  String get startGroupOrder {
    return Intl.message(
      'Start Group Order',
      name: 'startGroupOrder',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while updating the category`
  String get updateCategoryError {
    return Intl.message(
      'An error occurred while updating the category',
      name: 'updateCategoryError',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while updating the meal`
  String get updateMealError {
    return Intl.message(
      'An error occurred while updating the meal',
      name: 'updateMealError',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while updating the restaurant`
  String get updateRestaurantError {
    return Intl.message(
      'An error occurred while updating the restaurant',
      name: 'updateRestaurantError',
      desc: '',
      args: [],
    );
  }

  /// `Upload an image from your device or choose from the available images`
  String get uploadImageOrSelectExisting {
    return Intl.message(
      'Upload an image from your device or choose from the available images',
      name: 'uploadImageOrSelectExisting',
      desc: '',
      args: [],
    );
  }

  /// `members`
  String get members {
    return Intl.message('members', name: 'members', desc: '', args: []);
  }

  /// `Who is eating with you?`
  String get membersViewSubTitle {
    return Intl.message(
      'Who is eating with you?',
      name: 'membersViewSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Gather your friends and we'll take care of the rest.`
  String get membersViewDiscription {
    return Intl.message(
      'Gather your friends and we\'ll take care of the rest.',
      name: 'membersViewDiscription',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the member name`
  String get memberNameValidation {
    return Intl.message(
      'Please enter the member name',
      name: 'memberNameValidation',
      desc: '',
      args: [],
    );
  }

  /// `Enter member name`
  String get memberNameHint {
    return Intl.message(
      'Enter member name',
      name: 'memberNameHint',
      desc: '',
      args: [],
    );
  }

  /// `No members`
  String get noMembers {
    return Intl.message('No members', name: 'noMembers', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
