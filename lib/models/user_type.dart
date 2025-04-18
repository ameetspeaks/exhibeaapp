enum UserType {
  exhibitor,
  brand,
  shopper;

  String get displayName {
    switch (this) {
      case UserType.exhibitor:
        return 'Exhibitor';
      case UserType.brand:
        return 'Brand';
      case UserType.shopper:
        return 'Shopper';
    }
  }

  String get defaultEmail {
    switch (this) {
      case UserType.exhibitor:
        return 'exhibitor@test.com';
      case UserType.brand:
        return 'brand@test.com';
      case UserType.shopper:
        return 'shopper@test.com';
    }
  }

  String get defaultPassword {
    return 'password123';
  }

  String get dashboardRoute {
    switch (this) {
      case UserType.exhibitor:
        return '/exhibitor/dashboard';
      case UserType.brand:
        return '/brand/dashboard';
      case UserType.shopper:
        return '/shopper/dashboard';
    }
  }
} 