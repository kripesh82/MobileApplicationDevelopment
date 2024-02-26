class BillingModel {
  String? name;
  String? address;
  String? phone;
  String? city;
  final Map<String, dynamic> data;

  BillingModel({
    this.address,
    this.name,
    this.phone,
    this.city,
  }) : data = {
          'name': name,
          'phone': phone,
          'address': address,
          'city': city,
        };

  operator [](String key) => data[key];

  static BillingModel fromJson(Map<String, dynamic> json) {
    return BillingModel(
        address: json['address'],
        city: json['city'],
        name: json['name'],
        phone: json['phone']);
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': data['phone'],
      'name': data['name'],
      'address': data['address'],
      'city': data['city'],
    };
  }
}
