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

  /// `Add a new restaurant to the 'Yalla Notlob' app and start organizing group orders with your friends.`
  String get addRestaurantSubtitle {
    return Intl.message(
      'Add a new restaurant to the \'Yalla Notlob\' app and start organizing group orders with your friends.',
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

  /// `This category cannot be deleted because it has linked restaurants`
  String get cannotDeleteCategoryWithRestaurants {
    return Intl.message(
      'This category cannot be deleted because it has linked restaurants',
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

  /// `Fast Food`
  String get fastFoodCategory {
    return Intl.message(
      'Fast Food',
      name: 'fastFoodCategory',
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

  /// `Category deleted successfully`
  String get categoryDeletedSuccess {
    return Intl.message(
      'Category deleted successfully',
      name: 'categoryDeletedSuccess',
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

  /// `Permanently Delete Restaurant`
  String get deleteRestaurantPermanently {
    return Intl.message(
      'Permanently Delete Restaurant',
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

  /// `This action will permanently remove all restaurant data.`
  String get deleteRestaurantWarning {
    return Intl.message(
      'This action will permanently remove all restaurant data.',
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

  /// `An unexpected error occurred`
  String get genericError {
    return Intl.message(
      'An unexpected error occurred',
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

  /// `Choose a restaurant to start your group order`
  String get homeSubtitle {
    return Intl.message(
      'Choose a restaurant to start your group order',
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

  /// `Meal`
  String get meal {
    return Intl.message('Meal', name: 'meal', desc: '', args: []);
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

  /// `Minimum order is 5 EGP`
  String get minimumOrderFallback {
    return Intl.message(
      'Minimum order is 5 EGP',
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

  /// `Uploaded image will take priority`
  String get uploadedImagePriorityWarning {
    return Intl.message(
      'Uploaded image will take priority',
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

  /// `Upload an image from your device or choose from available images`
  String get uploadImageOrSelectExisting {
    return Intl.message(
      'Upload an image from your device or choose from available images',
      name: 'uploadImageOrSelectExisting',
      desc: '',
      args: [],
    );
  }

  /// `Members`
  String get members {
    return Intl.message('Members', name: 'members', desc: '', args: []);
  }

  /// `Who will join your meal?`
  String get membersViewSubTitle {
    return Intl.message(
      'Who will join your meal?',
      name: 'membersViewSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Gather your friends and we’ll take care of the rest.`
  String get membersViewDiscription {
    return Intl.message(
      'Gather your friends and we’ll take care of the rest.',
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

  /// `Shuffle`
  String get shuffle {
    return Intl.message('Shuffle', name: 'shuffle', desc: '', args: []);
  }

  /// `Pass the phone`
  String get passButtonTitle {
    return Intl.message(
      'Pass the phone',
      name: 'passButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `You need at least 2 members to continue`
  String get noEnoughMembersWarning {
    return Intl.message(
      'You need at least 2 members to continue',
      name: 'noEnoughMembersWarning',
      desc: '',
      args: [],
    );
  }

  /// `Choose Restaurant`
  String get chooseRestaurantTitle {
    return Intl.message(
      'Choose Restaurant',
      name: 'chooseRestaurantTitle',
      desc: '',
      args: [],
    );
  }

  /// `Let’s order food`
  String get chooseRestaurantTitle2 {
    return Intl.message(
      'Let’s order food',
      name: 'chooseRestaurantTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Select a restaurant to get started`
  String get chooseRestaurantSubTitle {
    return Intl.message(
      'Select a restaurant to get started',
      name: 'chooseRestaurantSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Please select a restaurant`
  String get selectRestaurantValidation {
    return Intl.message(
      'Please select a restaurant',
      name: 'selectRestaurantValidation',
      desc: '',
      args: [],
    );
  }

  /// `Your turn`
  String get yourTurn {
    return Intl.message('Your turn', name: 'yourTurn', desc: '', args: []);
  }

  /// `Choose your favorite meals from the list`
  String get chooseYourFavMeals {
    return Intl.message(
      'Choose your favorite meals from the list',
      name: 'chooseYourFavMeals',
      desc: '',
      args: [],
    );
  }

  /// `Full Payment`
  String get payFullCostBtnTitle {
    return Intl.message(
      'Full Payment',
      name: 'payFullCostBtnTitle',
      desc: '',
      args: [],
    );
  }

  /// `Custom Amount`
  String get payCustomCostBtnTitle {
    return Intl.message(
      'Custom Amount',
      name: 'payCustomCostBtnTitle',
      desc: '',
      args: [],
    );
  }

  /// `No Payment (Guest)`
  String get payZeroCostBtnTitle {
    return Intl.message(
      'No Payment (Guest)',
      name: 'payZeroCostBtnTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your Order Total`
  String get totalYourOrder {
    return Intl.message(
      'Your Order Total',
      name: 'totalYourOrder',
      desc: '',
      args: [],
    );
  }

  /// `Please select meals`
  String get chooseMealsValidation {
    return Intl.message(
      'Please select meals',
      name: 'chooseMealsValidation',
      desc: '',
      args: [],
    );
  }

  /// `Please choose a payment method`
  String get choosePayOptionValidation {
    return Intl.message(
      'Please choose a payment method',
      name: 'choosePayOptionValidation',
      desc: '',
      args: [],
    );
  }

  /// `Order confirmed!`
  String get order_confirmed {
    return Intl.message(
      'Order confirmed!',
      name: 'order_confirmed',
      desc: '',
      args: [],
    );
  }

  /// `Your order is being prepared in the kitchen.`
  String get kitchen_preparing {
    return Intl.message(
      'Your order is being prepared in the kitchen.',
      name: 'kitchen_preparing',
      desc: '',
      args: [],
    );
  }

  /// `Kitchen Order`
  String get kitchen_order {
    return Intl.message(
      'Kitchen Order',
      name: 'kitchen_order',
      desc: '',
      args: [],
    );
  }

  /// `Grouped`
  String get grouped {
    return Intl.message('Grouped', name: 'grouped', desc: '', args: []);
  }

  /// `No orders`
  String get no_orders {
    return Intl.message('No orders', name: 'no_orders', desc: '', args: []);
  }

  /// `Per Person Details`
  String get per_person_details {
    return Intl.message(
      'Per Person Details',
      name: 'per_person_details',
      desc: '',
      args: [],
    );
  }

  /// `Share Order`
  String get share_order {
    return Intl.message('Share Order', name: 'share_order', desc: '', args: []);
  }

  /// `Preparing...`
  String get sharing_loading {
    return Intl.message(
      'Preparing...',
      name: 'sharing_loading',
      desc: '',
      args: [],
    );
  }

  /// `Back to Home`
  String get back_home {
    return Intl.message('Back to Home', name: 'back_home', desc: '', args: []);
  }

  /// `Paid`
  String get paid {
    return Intl.message('Paid', name: 'paid', desc: '', args: []);
  }

  /// `Collected`
  String get collected {
    return Intl.message('Collected', name: 'collected', desc: '', args: []);
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `Settled`
  String get settled {
    return Intl.message('Settled', name: 'settled', desc: '', args: []);
  }

  /// `Owes`
  String get owes {
    return Intl.message('Owes', name: 'owes', desc: '', args: []);
  }

  /// `Overpaid`
  String get overpaid {
    return Intl.message('Overpaid', name: 'overpaid', desc: '', args: []);
  }

  /// `An error occurred while adding the member`
  String get memberAddError {
    return Intl.message(
      'An error occurred while adding the member',
      name: 'memberAddError',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while deleting the member`
  String get memberDeleteError {
    return Intl.message(
      'An error occurred while deleting the member',
      name: 'memberDeleteError',
      desc: '',
      args: [],
    );
  }

  /// `No members found`
  String get memberGetEmpty {
    return Intl.message(
      'No members found',
      name: 'memberGetEmpty',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while fetching members`
  String get memberGetError {
    return Intl.message(
      'An error occurred while fetching members',
      name: 'memberGetError',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while updating member data`
  String get memberUpdateError {
    return Intl.message(
      'An error occurred while updating member data',
      name: 'memberUpdateError',
      desc: '',
      args: [],
    );
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
