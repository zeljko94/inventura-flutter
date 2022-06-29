


class AuthService {

  AuthService();

  AuthService.fromAuthService();

  Future<bool> isUserLoggedIn() {
    return Future.delayed(Duration.zero, () async {
      return true;
    });
  }

  Future<String> requestPass(String email) async {
    return Future.delayed(Duration.zero, () async {
      return 'PASS';
    });
  }

  Future<ConfirmPassResponse> confirmPass(email) async {
    return Future.delayed(Duration.zero, () async {
      return ConfirmPassResponse(errors: null, messages: ['Ok'], token: 'asdasdasdsadsadasd');
    });
  }
}



class ConfirmPassResponse {
  List<String>? errors;
  List<String>? messages;
  String? token;

  ConfirmPassResponse({this.errors, this.messages, this.token});

  factory ConfirmPassResponse.fromJson(Map<String, dynamic> json) {
    var jsonErrors = json['errors'];
    List<String> errorsList =
        jsonErrors != null ? jsonErrors.cast<String>() : [];

    var jsonMessages = json['messages'];
    List<String> messageList =
        jsonMessages != null ? jsonMessages.cast<String>() : [];

    return ConfirmPassResponse(
        errors: errorsList, messages: messageList, token: json['token']);
  }
}