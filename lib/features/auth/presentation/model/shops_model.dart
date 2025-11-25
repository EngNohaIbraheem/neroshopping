class ShopModel {
  String? code;
  Pagination? pagination;
  List<Payload>? payload;

  ShopModel({this.code, this.pagination, this.payload});

  ShopModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    if (json['payload'] != null) {
      payload = <Payload>[];
      json['payload'].forEach((v) {
        payload!.add(new Payload.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.payload != null) {
      data['payload'] = this.payload!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pagination {
  int? page;
  int? nextPage;
  int? lastPage;
  int? resultCount;

  Pagination({this.page, this.nextPage, this.lastPage, this.resultCount});

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    nextPage = json['next_page'];
    lastPage = json['last_page'];
    resultCount = json['result_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['next_page'] = this.nextPage;
    data['last_page'] = this.lastPage;
    data['result_count'] = this.resultCount;
    return data;
  }
}

class ShopsModel {
  String? id;
  String? name;
  String? description;
  // int? workerNo;
  // String? cityId;
  // String? street;
  // String? address1;
  // String? address2;
  String? pictureUrl;
  // int? rate;
  // int? totalRates;
  // int? isOpen;
  int? isFavorited;
  // String? longitude;
  // String? latitude;
  // Null? distance;
  // String? whatsapp;
  // String? facebook;
  // String? instagram;

  ShopsModel(
      {this.id,
      this.name,
      this.description,
      // this.workerNo,
      // this.cityId,
      // this.street,
      // this.address1,
      // this.address2,
      this.pictureUrl,
      // this.rate,
      // this.totalRates,
      // this.isOpen,
      this.isFavorited,
      // this.longitude,
      // this.latitude,
      // this.distance,
      // this.whatsapp,
      // this.facebook,
      // this.instagram
  });

  ShopsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    // workerNo = json['worker_no'];
    // cityId = json['city_id'];
    // street = json['street'];
    // address1 = json['address_1'];
    // address2 = json['address_2'];
    pictureUrl = json['picture_url'];
    // rate = json['rate'];
    // totalRates = json['total_rates'];
    // isOpen = json['is_open'];
    isFavorited = json['is_favorited'];
    // longitude = json['longitude'];
    // latitude = json['latitude'];
    // distance = json['distance'];
    // whatsapp = json['whatsapp'];
    // facebook = json['facebook'];
    // instagram = json['instagram'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    // data['worker_no'] = this.workerNo;
    // data['city_id'] = this.cityId;
    // data['street'] = this.street;
    // data['address_1'] = this.address1;
    // data['address_2'] = this.address2;
    data['picture_url'] = this.pictureUrl;
    // data['rate'] = this.rate;
    // data['total_rates'] = this.totalRates;
    // data['is_open'] = this.isOpen;
    // data['is_favorited'] = this.isFavorited;
    // data['longitude'] = this.longitude;
    // data['latitude'] = this.latitude;
    // data['distance'] = this.distance;
    // data['whatsapp'] = this.whatsapp;
    // data['facebook'] = this.facebook;
    // data['instagram'] = this.instagram;
    return data;
  }
}

class ShopModels {
  String? code;
  List<ShopModel>?payload;
  ShopModels({this.code, this.payload});

  ShopModels.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['payload'] != null) {
      json['payload'].forEach((v) {
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.payload != null) {
      data['payload'] = this.payload!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Payload {
  String? id;
  String? name;
  String? description;
  // int? workerNo;
  // String? cityId;
  // String? street;
  // String? address1;
  // String? address2;
  String? pictureUrl;
  // int? rate;
  // int? totalRates;
  // int? isOpen;
  int? isFavorited;
  // String? longitude;
  // String? latitude;
  // Null? distance;
  // String? whatsapp;
  // String? facebook;
  // String? instagram;

  Payload(
      {this.id,
      this.name,
      this.description,
      // this.workerNo,
      // this.cityId,
      // this.street,
      // this.address1,
      // this.address2,
      this.pictureUrl,
      // this.rate,
      // this.totalRates,
      // this.isOpen,
      this.isFavorited,
      // this.longitude,
      // this.latitude,
      // this.distance,
      // this.whatsapp,
      // this.facebook,
      // this.instagram
      });

  Payload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    // workerNo = json['worker_no'];
    // cityId = json['city_id'];
    // street = json['street'];
    // address1 = json['address_1'];
    // address2 = json['address_2'];
    pictureUrl = json['picture_url'];
    // rate = json['rate'];
    // totalRates = json['total_rates'];
    // isOpen = json['is_open'];
    isFavorited = json['is_favorited'];
    // longitude = json['longitude'];
    // latitude = json['latitude'];
    // distance = json['distance'];
    // whatsapp = json['whatsapp'];
    // facebook = json['facebook'];
    // instagram = json['instagram'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    // data['worker_no'] = this.workerNo;
    // data['city_id'] = this.cityId;
    // data['street'] = this.street;
    // data['address_1'] = this.address1;
    // data['address_2'] = this.address2;
    // data['picture_url'] = this.pictureUrl;
    // data['rate'] = this.rate;
    // data['total_rates'] = this.totalRates;
    // data['is_open'] = this.isOpen;
    data['is_favorited'] = this.isFavorited;
    // data['longitude'] = this.longitude;
    // data['latitude'] = this.latitude;
    // data['distance'] = this.distance;
    // data['whatsapp'] = this.whatsapp;
    // data['facebook'] = this.facebook;
    // data['instagram'] = this.instagram;
    return data;
  }
}
