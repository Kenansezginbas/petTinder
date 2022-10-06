class PostModel {
  String? imageURL;
  String? postDesc;
  String? user;

  PostModel({this.imageURL, this.postDesc, this.user});

  PostModel.fromJson(Map<String, dynamic> json) {
    imageURL = json['ImageURL'];
    postDesc = json['PostDesc'];
    user = json['User'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ImageURL'] = this.imageURL;
    data['PostDesc'] = this.postDesc;
    data['User'] = this.user;
    return data;
  }
}