class User {
  String firstName;
  String lastName;
  String Weight;
  String Height;
  String Drink;
  bool isMale;

  User({
    this.firstName,
    this.lastName,
    this.isMale,
    this.Weight,
    this.Height,
    this.Drink,
  });

  User.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        isMale = json['isMale'],
        Weight = json['Weight'],
        Height = json['Height'],
        Drink = json['Drink'];

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'isMale': isMale,
        'Weight': Weight,
        'Height': Height,
        'Drink': Drink,
      };
}
