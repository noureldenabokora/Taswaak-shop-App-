class ChangeFavoriteModel {
  bool? status;
  String? message;

  ChangeFavoriteModel.FromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
