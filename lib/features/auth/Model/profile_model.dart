class ModeleProfile {
  String? code;
  String? message;
  Payload? payload;

  ModeleProfile({this.code, this.message, this.payload});

  ModeleProfile.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    payload =
    json['payload'] != null ? new Payload.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.payload != null) {
      data['payload'] = this.payload!.toJson();
    }
    return data;
  }
}

class Payload {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? pictureUrl;
  String? gender;
  String? longitude;
  String? latitude;

  Payload(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.pictureUrl,
        this.gender,
        this.longitude,
        this.latitude});

  Payload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    pictureUrl = json['picture_url'];
    gender = json['gender'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['picture_url'] = this.pictureUrl;
    data['gender'] = this.gender;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }
}