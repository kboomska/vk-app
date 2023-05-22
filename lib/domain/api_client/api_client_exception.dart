enum ApiClientExceptionType { network, authCancel, accessToken, captcha, other }

class ApiClientException implements Exception {
  ApiClientExceptionType type;

  ApiClientException(this.type);
}
