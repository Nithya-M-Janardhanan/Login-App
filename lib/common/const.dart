class Const{
  static const String googleUser = 'googleLogin';
  static const String facebookUser = 'facebookLogin';
  static const String otherUser = 'defaultLogin';
}
enum LoadState {
  loading,
  loaded,
  error,
  networkError,
}