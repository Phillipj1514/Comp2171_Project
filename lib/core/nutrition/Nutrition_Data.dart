class Nutrition_Data{
  int calorie = 0;
  double fat = 0;
  double carbohydrates = 0;
  double sugar = 0;
  double protein = 0;

  // CONSTRUCTOR
  Nutrition_Data({this.calorie = 0, this.fat = 0, this.carbohydrates = 0, this.sugar = 0,this.protein =0});

  // GETTERS
  
  /// get calorie value
  int getCalorie() => this.calorie;

  /// get fat value
  double getFat() => this.fat;

  /// get carbohydrates value
  double getCarbohydrates() => this.carbohydrates;

  /// get sugar value
  double getSugar() => this.sugar;

  /// get fat value
  double getProtein() => this.protein;

  // SETTERS

  /// Set the caloric value
  void setCalorie(int calorie) => this.calorie = calorie;

  /// Set the fat value
  void setFat(double fat) => this.fat = fat;

  /// Set the carbohydrates value
  void setCarbohydrates(double carbohydrates) => this.carbohydrates = carbohydrates;

  /// Set the sugar value
  void setSugar(double sugar) => this.sugar = sugar;

  /// Set the protein value
  void setProtein(double protein) => this.protein = protein;

  /// Set all the values
  void setAll(int calorie, double fat, double carbohydrates, double sugar, double protein){
    this.calorie = calorie;
    this.fat = fat;
    this.carbohydrates = carbohydrates;
    this.sugar = sugar;
    this.protein = protein;
  }

}