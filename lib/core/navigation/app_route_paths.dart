enum AppRoutePaths {
  splash(path: '/boot', navigationPath: '/boot'),
  login(path: '/auth', navigationPath: '/auth'),
  selectOutlet(path: '/auth/select-outlet', navigationPath: 'select-outlet'),
  home(path: '/', navigationPath: '/');

  final String path;
  final String navigationPath;

  const AppRoutePaths({required this.path, required this.navigationPath});
}
