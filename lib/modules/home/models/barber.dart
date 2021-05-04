class Barber {
  String id;
  String name;
  String image;
  String cover;
  double rate;
  int noOfRaters;
  bool isFavorite;
  String discription;
  Barber(
      {this.discription,
      this.cover,
      this.name,
      this.id,
      this.image,
      this.rate,
      this.noOfRaters,
      this.isFavorite = false});
}
