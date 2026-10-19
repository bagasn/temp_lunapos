enum AppRoutePaths {
  setting(path: '/app/setting', navigationPath: 'setting'),

  home(path: '/app', navigationPath: '/app'),

  loginPosInputPin(path: '/auth/pos-user/pin', navigationPath: 'pin'),
  loginPos(path: '/auth/pos-user', navigationPath: 'pos-user'),
  selectOutlet(path: '/auth/select-outlet', navigationPath: 'select-outlet'),
  login(path: '/auth', navigationPath: '/auth'),
  welcome(path: '/', navigationPath: '/');

  final String path;
  final String navigationPath;

  const AppRoutePaths({required this.path, required this.navigationPath});
}
