class Barber {
  final String id;
  final String name;
  final String image;
  final double stars;
  final int noOfRaters;
  final bool isFavorite;
  final String discription;
  Barber(
      {this.discription,
      this.name,
      this.id,
      this.image,
      this.stars,
      this.noOfRaters,
      this.isFavorite = false});
}

List<Barber> barbers = [
  Barber(
    name: 'Hossam Hassan',
    image: 'assets/images/3.jpg',
    stars: 5,
    noOfRaters: 20,
    discription: 'This is one of best salons in egypt',
    isFavorite: true,
  ),
  Barber(
      name: 'Ali Ali', image: 'assets/images/2.jpg', stars: 3, noOfRaters: 10),
  Barber(
      name: 'Ahmed hossam',
      image: 'assets/images/1.jpg',
      stars: 2,
      noOfRaters: 25,
      isFavorite: false,
      discription: 'This is one of best salons in egypt'),
  Barber(
      name: 'Fady',
      image: 'assets/images/4.jpg',
      stars: 5,
      isFavorite: true,
      noOfRaters: 16,
      discription: 'This is one of best salons in egypt'),
  Barber(
      name: 'Shoukry sayed',
      image: 'assets/images/5.jpg',
      stars: 4,
      isFavorite: true,
      noOfRaters: 17,
      discription: 'This is one of best salons in egypt'),
  Barber(
      name: 'Fatma',
      isFavorite: true,
      image: 'assets/images/1.jpg',
      stars: 5,
      noOfRaters: 30,
      discription: 'This is one of best salons in egypt'),
  Barber(
      name: 'Soaad',
      image: 'assets/images/2.jpg',
      stars: 1,
      noOfRaters: 55,
      discription: 'This is one of best salons in egypt'),
];
