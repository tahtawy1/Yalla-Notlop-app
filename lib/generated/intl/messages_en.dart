// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "addCategory": MessageLookupByLibrary.simpleMessage("Add Category"),
    "addCategoryError": MessageLookupByLibrary.simpleMessage(
      "An error occurred while adding the category",
    ),
    "addMeal": MessageLookupByLibrary.simpleMessage("Add Meal"),
    "addMealError": MessageLookupByLibrary.simpleMessage(
      "An error occurred while adding the meal",
    ),
    "addMeals": MessageLookupByLibrary.simpleMessage("Add Meals"),
    "addRestaurant": MessageLookupByLibrary.simpleMessage("Add Restaurant"),
    "addRestaurantError": MessageLookupByLibrary.simpleMessage(
      "An error occurred while adding the restaurant",
    ),
    "addRestaurantSubtitle": MessageLookupByLibrary.simpleMessage(
      "Add a new restaurant to \'Yalla Notlob\' and start organizing group orders with your friends.",
    ),
    "addRestaurantTitle": MessageLookupByLibrary.simpleMessage(
      "Expand the Menu",
    ),
    "allCuisines": MessageLookupByLibrary.simpleMessage("All Cuisines"),
    "appName": MessageLookupByLibrary.simpleMessage("Yalla Notlob"),
    "bakeryCategory": MessageLookupByLibrary.simpleMessage("Bakery & Pastries"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cancelOperation": MessageLookupByLibrary.simpleMessage("Cancel Operation"),
    "cannotDeleteCategoryWithRestaurants": MessageLookupByLibrary.simpleMessage(
      "Cannot delete the category because restaurants are linked to it",
    ),
    "categories": MessageLookupByLibrary.simpleMessage("Categories"),
    "categoryAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "A category with this name already exists",
    ),
    "categoryDeletedSuccess": MessageLookupByLibrary.simpleMessage(
      "Category deleted successfully",
    ),
    "categoryNameHint": MessageLookupByLibrary.simpleMessage(
      "Enter category name",
    ),
    "categoryNameLabel": MessageLookupByLibrary.simpleMessage("Category Name"),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteCategoryError": MessageLookupByLibrary.simpleMessage(
      "An error occurred while deleting the category",
    ),
    "deleteMealError": MessageLookupByLibrary.simpleMessage(
      "An error occurred while deleting the meal",
    ),
    "deleteRestaurantConfirmation": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to delete this restaurant? This action cannot be undone.",
    ),
    "deleteRestaurantError": MessageLookupByLibrary.simpleMessage(
      "An error occurred while deleting the restaurant",
    ),
    "deleteRestaurantPermanently": MessageLookupByLibrary.simpleMessage(
      "Delete Restaurant Permanently",
    ),
    "deleteRestaurantTitle": MessageLookupByLibrary.simpleMessage(
      "Delete Restaurant",
    ),
    "deleteRestaurantWarning": MessageLookupByLibrary.simpleMessage(
      "This action will permanently delete all restaurant-related data.",
    ),
    "editRestaurantName": MessageLookupByLibrary.simpleMessage(
      "Edit Restaurant Name",
    ),
    "enterNameValidation": MessageLookupByLibrary.simpleMessage(
      "Please enter a name",
    ),
    "fastFoodCategory": MessageLookupByLibrary.simpleMessage("Fast Food"),
    "fetchCategoriesError": MessageLookupByLibrary.simpleMessage(
      "An error occurred while fetching categories",
    ),
    "fetchMealsError": MessageLookupByLibrary.simpleMessage(
      "An error occurred while fetching meals",
    ),
    "fetchRestaurantsError": MessageLookupByLibrary.simpleMessage(
      "An error occurred while fetching restaurants",
    ),
    "friends": MessageLookupByLibrary.simpleMessage("Your Friends"),
    "genericError": MessageLookupByLibrary.simpleMessage("An error occurred"),
    "history": MessageLookupByLibrary.simpleMessage("History"),
    "home": MessageLookupByLibrary.simpleMessage("Home"),
    "homeSubtitle": MessageLookupByLibrary.simpleMessage(
      "Choose a restaurant to start your group order.",
    ),
    "homeTitle": MessageLookupByLibrary.simpleMessage("Food for the Gathering"),
    "invalidPriceValidation": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid price",
    ),
    "mealCount": MessageLookupByLibrary.simpleMessage("Meal"),
    "mealNameHint": MessageLookupByLibrary.simpleMessage("Enter meal name"),
    "mealNameLabel": MessageLookupByLibrary.simpleMessage("Meal Name"),
    "mealPriceHint": MessageLookupByLibrary.simpleMessage("Enter price"),
    "mealPriceLabel": MessageLookupByLibrary.simpleMessage("Price"),
    "mealPriceRequired": MessageLookupByLibrary.simpleMessage(
      "Please enter the price",
    ),
    "mealPriceSuffix": MessageLookupByLibrary.simpleMessage("EGP"),
    "meals": MessageLookupByLibrary.simpleMessage("Meals"),
    "mealsListTitle": MessageLookupByLibrary.simpleMessage("Meals List"),
    "minimumOrderFallback": MessageLookupByLibrary.simpleMessage(
      "Minimum order 5 EGP",
    ),
    "noCategory": MessageLookupByLibrary.simpleMessage("No Category"),
    "noImageSelected": MessageLookupByLibrary.simpleMessage(
      "No image selected",
    ),
    "noRestaurantsAvailable": MessageLookupByLibrary.simpleMessage(
      "No restaurants available",
    ),
    "orderNow": MessageLookupByLibrary.simpleMessage("Order Now"),
    "orders": MessageLookupByLibrary.simpleMessage("Orders"),
    "pickImageError": MessageLookupByLibrary.simpleMessage(
      "An error occurred while selecting the image",
    ),
    "pizzaCategory": MessageLookupByLibrary.simpleMessage("Pizza & Pasta"),
    "restaurantAddedSuccess": MessageLookupByLibrary.simpleMessage(
      "Restaurant added successfully ✓",
    ),
    "restaurantDeletedSuccess": MessageLookupByLibrary.simpleMessage(
      "Restaurant deleted successfully",
    ),
    "restaurantImage": MessageLookupByLibrary.simpleMessage("Restaurant Image"),
    "restaurantImageAdded": MessageLookupByLibrary.simpleMessage(
      "Image added successfully",
    ),
    "restaurantManagement": MessageLookupByLibrary.simpleMessage(
      "Restaurant Management",
    ),
    "restaurantNameExample": MessageLookupByLibrary.simpleMessage(
      "Example: Al Safha Restaurant",
    ),
    "restaurantNameHint": MessageLookupByLibrary.simpleMessage(
      "Enter restaurant name",
    ),
    "restaurantNameLabel": MessageLookupByLibrary.simpleMessage(
      "Restaurant Name",
    ),
    "restaurantNameValidation": MessageLookupByLibrary.simpleMessage(
      "Please enter the restaurant name",
    ),
    "restaurantUpdatedSuccess": MessageLookupByLibrary.simpleMessage(
      "Restaurant updated successfully",
    ),
    "restaurantUploadHint": MessageLookupByLibrary.simpleMessage(
      "Tap to add an image",
    ),
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("Save Changes"),
    "saveRestaurant": MessageLookupByLibrary.simpleMessage("Save Restaurant"),
    "selectCategoryValidation": MessageLookupByLibrary.simpleMessage(
      "Please select a category",
    ),
    "splashLoading": MessageLookupByLibrary.simpleMessage(
      "Preparing Yalla Notlob...",
    ),
    "splashSubtitle": MessageLookupByLibrary.simpleMessage(
      "Order together with ease",
    ),
    "splashTitle": MessageLookupByLibrary.simpleMessage("Yalla Notlob"),
    "startGroupOrder": MessageLookupByLibrary.simpleMessage(
      "Start Group Order",
    ),
    "updateCategoryError": MessageLookupByLibrary.simpleMessage(
      "An error occurred while updating the category",
    ),
    "updateMealError": MessageLookupByLibrary.simpleMessage(
      "An error occurred while updating the meal",
    ),
    "updateRestaurantError": MessageLookupByLibrary.simpleMessage(
      "An error occurred while updating the restaurant",
    ),
    "uploadImageOrSelectExisting": MessageLookupByLibrary.simpleMessage(
      "Upload an image from your device or choose from the available images",
    ),
    "uploadedImagePriorityWarning": MessageLookupByLibrary.simpleMessage(
      "Priority will be given to the uploaded image!",
    ),
  };
}
