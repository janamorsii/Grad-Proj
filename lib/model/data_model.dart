//choosing and declare the needed variales from the api
class DataModel{
  String name;
  String img;
  String description;
  String location;
  int price;
  int people;
  int stars;
  DataModel({
    required this.name,
    required this.img,
    required this.description,
    required this.location,
    required this.price,
    required this.people,
    required this.stars,


  });

  //declare a new methof to decode from json to map
  factory DataModel.fromJson(Map<String,dynamic> json){ //sends information to json variable to hold the information of the api 
    return DataModel(
    name: json["name"], 
    img: json["img"], 
    description: json["description"], 
    location: json["location"], 
    price: json["price"], 
    people: json["people"], 
    stars: json["stars"]
    );
  }
}