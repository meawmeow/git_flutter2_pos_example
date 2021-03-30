class FoodModel {
  String foodname;
  int price;
  int count;
  FoodModel(this.foodname, this.price, this.count);

  FoodModel.clone(FoodModel source)
      : this.foodname = source.foodname,
        this.price = source.price,
        this.count = source.count;
}
