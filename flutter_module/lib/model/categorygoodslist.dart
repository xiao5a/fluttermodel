class CategoryGoodsListModel {
  String code;
  String message;
  List<GoodsListData> goodsListData;

  CategoryGoodsListModel({this.code, this.message, this.goodsListData});

  CategoryGoodsListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      goodsListData = new List<GoodsListData>();
      json['data'].forEach((v) {
        goodsListData.add(new GoodsListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.goodsListData != null) {
      data['data'] = this.goodsListData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GoodsListData {
  String image;
  double oriPrice;
  double presentPrice;
  String goodsName;
  String goodsId;

  GoodsListData(
      {this.image,
        this.oriPrice,
        this.presentPrice,
        this.goodsName,
        this.goodsId});

  GoodsListData.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    oriPrice = json['oriPrice'];
    presentPrice = json['presentPrice'];
    goodsName = json['goodsName'];
    goodsId = json['goodsId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['oriPrice'] = this.oriPrice;
    data['presentPrice'] = this.presentPrice;
    data['goodsName'] = this.goodsName;
    data['goodsId'] = this.goodsId;
    return data;
  }
}

