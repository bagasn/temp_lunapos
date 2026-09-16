enum AppRoutePaths {
  welcome(path: '/', navigationPath: '/'),
  login(path: '/auth', navigationPath: '/auth'),
  selectOutlet(path: '/auth/select-outlet', navigationPath: 'select-outlet'),
  loginPos(path: '/auth/pos-user', navigationPath: 'pos-user'),
  loginPosInputPin(path: '/auth/pos-user/pin', navigationPath: 'pin'),
  home(path: '/app', navigationPath: '/app');

  final String path;
  final String navigationPath;

  const AppRoutePaths({required this.path, required this.navigationPath});
}
