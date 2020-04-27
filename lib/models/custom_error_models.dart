class CustomErrorModels {
  
  final String message;
  final String code;

  CustomErrorModels({this.message, this.code});

  @override
  String toString() {
    return message;
  }


}