class BrandModel {
  final String id;
  final String name;
  final String description;
  final String logo;
  final String banner;
  final ContactInfo contact;
  final SocialMedia socialMedia;
  final BrandStats stats;
  final List<String> categories;
  final List<Award> awards;
  final String logoUrl;
  final String website;
  final String email;
  final String phone;
  final String address;
  final List<Map<String, dynamic>> lookbook;
  final List<Map<String, dynamic>> mediaGallery;

  BrandModel({
    required this.id,
    required this.name,
    required this.description,
    required this.logo,
    required this.banner,
    required this.contact,
    required this.socialMedia,
    required this.stats,
    required this.categories,
    required this.awards,
    required this.logoUrl,
    required this.website,
    required this.email,
    required this.phone,
    required this.address,
    required this.lookbook,
    required this.mediaGallery,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      logo: json['logo'] as String,
      banner: json['banner'] as String,
      contact: ContactInfo.fromJson(json['contact'] as Map<String, dynamic>),
      socialMedia: SocialMedia.fromJson(json['socialMedia'] as Map<String, dynamic>),
      stats: BrandStats.fromJson(json['stats'] as Map<String, dynamic>),
      categories: List<String>.from(json['categories'] as List),
      awards: (json['awards'] as List)
          .map((award) => Award.fromJson(award as Map<String, dynamic>))
          .toList(),
      logoUrl: json['logoUrl'] as String,
      website: json['website'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      lookbook: (json['lookbook'] as List<dynamic>?)
          ?.map((item) => item as Map<String, dynamic>)
          .toList() ?? [],
      mediaGallery: (json['mediaGallery'] as List<dynamic>?)
          ?.map((item) => item as Map<String, dynamic>)
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'logo': logo,
      'banner': banner,
      'contact': contact.toJson(),
      'socialMedia': socialMedia.toJson(),
      'stats': stats.toJson(),
      'categories': categories,
      'awards': awards.map((award) => award.toJson()).toList(),
      'logoUrl': logoUrl,
      'website': website,
      'email': email,
      'phone': phone,
      'address': address,
      'lookbook': lookbook,
      'mediaGallery': mediaGallery,
    };
  }
}

class ContactInfo {
  final String email;
  final String phone;
  final String website;
  final String address;

  ContactInfo({
    required this.email,
    required this.phone,
    required this.website,
    required this.address,
  });

  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(
      email: json['email'] as String,
      phone: json['phone'] as String,
      website: json['website'] as String,
      address: json['address'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'website': website,
      'address': address,
    };
  }
}

class SocialMedia {
  final String instagram;
  final String facebook;
  final String twitter;

  SocialMedia({
    required this.instagram,
    required this.facebook,
    required this.twitter,
  });

  factory SocialMedia.fromJson(Map<String, dynamic> json) {
    return SocialMedia(
      instagram: json['instagram'] as String,
      facebook: json['facebook'] as String,
      twitter: json['twitter'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'instagram': instagram,
      'facebook': facebook,
      'twitter': twitter,
    };
  }
}

class BrandStats {
  final int exhibitions;
  final int products;
  final int followers;
  final double rating;

  BrandStats({
    required this.exhibitions,
    required this.products,
    required this.followers,
    required this.rating,
  });

  factory BrandStats.fromJson(Map<String, dynamic> json) {
    return BrandStats(
      exhibitions: json['exhibitions'] as int,
      products: json['products'] as int,
      followers: json['followers'] as int,
      rating: json['rating'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exhibitions': exhibitions,
      'products': products,
      'followers': followers,
      'rating': rating,
    };
  }
}

class Award {
  final String title;
  final String issuer;
  final String year;

  Award({
    required this.title,
    required this.issuer,
    required this.year,
  });

  factory Award.fromJson(Map<String, dynamic> json) {
    return Award(
      title: json['title'] as String,
      issuer: json['issuer'] as String,
      year: json['year'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'issuer': issuer,
      'year': year,
    };
  }
} 