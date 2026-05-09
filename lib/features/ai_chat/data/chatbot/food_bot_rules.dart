class FoodBotRule {
  const FoodBotRule({
    required this.keywords,
    required this.response,
  });

  final List<String> keywords;
  final String response;

  bool matches(String textLower) {
    return keywords.any(textLower.contains);
  }
}

class FoodBotRules {
  static const String nonFoodReply =
      'I can help with food questions only (calories, healthy meals, suggestions).';

  static const String fallbackReply =
      'Tell me the food name and what you want to know (calories / healthy or not / suggestion).';

  static const List<String> allowedKeywords = [
    'food',
    'eat',
    'calorie',
    'calories',
    'healthy',
    'diet',
    'protein',
    'carb',
    'fat',
    'سعر',
    'سعرات',
    'كالوري',
    'كالوريز',
    'قيمة غذائية',
    'قيم غذائية',
    'القيم الغذائية',
    'دهون',
    'كارب',
    'كربوهيدرات',
    'بروتين',
    'ألياف',
    'سكر',
    'صوديوم',
    'صحي',
    'غير صحي',
    'دايت',
    'رجيم',
    'pizza',
    'burger',
    'koshary',
    'shawarma',
    'salad',
    'meal',
    'lunch',
    'dinner',
    'breakfast',
  ];

  static const List<FoodBotRule> rules = [
    FoodBotRule(
      keywords: ['calor', 'calorie'],
      response:
          'Calories depend on portion size. Tell me the food name and portion (small/medium/large) and I will estimate.',
    ),
    FoodBotRule(
      keywords: ['healthy', 'diet'],
      response:
          'Healthy choices: grilled chicken, salad, lean proteins, avoid sugary drinks, and control portion size.',
    ),
    FoodBotRule(
      keywords: ['pizza'],
      response:
          'Pizza tip: choose thin crust, add veggies, and limit extra cheese for a lighter option.',
    ),
    FoodBotRule(
      keywords: ['burger'],
      response:
          'Burger tip: choose grilled patty, skip extra sauces, and replace fries with salad when possible.',
    ),
    FoodBotRule(
      keywords: ['koshary'],
      response:
          'Koshary is tasty but usually high in carbs. Try a smaller portion and go easy on sauces.',
    ),
    FoodBotRule(
      keywords: ['suggest', 'meal'],
      response:
          'Suggestion: grilled chicken + rice + salad, or tuna sandwich + fruit, or yogurt + nuts.',
    ),
  ];

  static bool isFoodQuestion(String text) {
    final t = text.toLowerCase();
    return allowedKeywords.any(t.contains);
  }

  static String reply(String text) {
    final t = text.toLowerCase();

    if (!isFoodQuestion(t)) {
      return nonFoodReply;
    }

    for (final rule in rules) {
      if (rule.matches(t)) return rule.response;
    }

    return fallbackReply;
  }
}
