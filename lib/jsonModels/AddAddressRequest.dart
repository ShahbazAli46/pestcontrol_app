class AddAddressRequest {
  String? userId;
  String? address;
  String? city;
  String? lat;
  String? lang;
  String? country;
  String? state;
  String? area;

  AddAddressRequest(
      {this.userId,
        this.address,
        this.city,
        this.lat,
        this.lang,
        this.country,
        this.state,
        this.area});

  AddAddressRequest.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    address = json['address'];
    city = json['city'];
    lat = json['lat'];
    lang = json['lang'];
    country = json['country'];
    state = json['state'];
    area = json['area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['address'] = this.address;
    data['city'] = this.city;
    data['lat'] = this.lat;
    data['lang'] = this.lang;
    data['country'] = this.country;
    data['state'] = this.state;
    data['area'] = this.area;
    return data;
  }
}
