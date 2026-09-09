enum AppRoutePaths {
  welcome(path: '/', navigationPath: '/'),
  login(path: '/auth', navigationPath: '/auth'),
  selectOutlet(path: '/auth/select-outlet', navigationPath: 'select-outlet'),
  home(path: '/app', navigationPath: '/app');

  final String path;
  final String navigationPath;

  const AppRoutePaths({required this.path, required this.navigationPath});
}
