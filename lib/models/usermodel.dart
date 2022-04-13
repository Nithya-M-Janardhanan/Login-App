// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UsersList {
  List<UserModel>? userList;
  UsersList({this.userList});

  factory UsersList.fromJson(List<dynamic> json) =>
      UsersList(userList: json.map((e) => UserModel.fromJson(e)).toList());
}

class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.profileImage,
     required this.address,
    // required this.street,
    //required this.list,
    required this.phone,
    required this.website,
    required this.company,
  });

  int id;
  String name;
  String username;
  String email;
  String profileImage;
   Address address;
  // String street;
  //List<String> list;
  String? phone;
  String website;
  Company? company;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"]??'',
    name: json["name"]??'',
    username: json["username"]??'',
    email: json["email"]??'',
    profileImage: json["profile_image"]??'',
     address: Address.fromJson(json["address"]),
    //street: jsonEncode(json['address''street']),
    //   street: jsonEncode(json["address"]),
    phone: json["phone"]??'',
    website: json["website"]??'',
    company: json["company"] == null ? null : Company.fromJson(json["company"]));
    //company: Company.fromJson(json["company"]));


  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "username": username,
    "email": email,
    "profile_image": profileImage,
    "address": address,
    // "street": street,
    "phone": phone,
    "website": website,
    //"company": company == null ? null : company!.toJson(),
    "company": company
  };
}

class Address {
  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  String street;
  String suite;
  String city;
  String zipcode;
  //Geo geo;
  String geo;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    street: json["street"],
    suite: json["suite"],
    city: json["city"],
    zipcode: json["zipcode"],
    //geo: Geo.fromJson(json["geo"]),
    geo: jsonEncode(json["geo"])
  );

  Map<String, dynamic> toJson() => {
    "street": street,
    "suite": suite,
    "city": city,
    "zipcode": zipcode,
    //"geo": geo.toJson(),
    "geo": geo
  };
}

class Geo {
  Geo({
    required this.lat,
    required this.lng,
  });

  String lat;
  String lng;

  factory Geo.fromJson(Map<String, dynamic> json) => Geo(
    lat: json["lat"],
    lng: json["lng"],
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}

class Company {
  Company({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  String name;
  String catchPhrase;
  String bs;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    name: json["name"],
    catchPhrase: json["catchPhrase"],
    bs: json["bs"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "catchPhrase": catchPhrase,
    "bs": bs,
  };
}
