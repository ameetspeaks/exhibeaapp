class Exhibition {
  final String id;
  final String name;
  final String description;
  final String venue;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final String imageUrl;
  final int totalStalls;
  final int availableStalls;
  final double pricePerStall;

  Exhibition({
    required this.id,
    required this.name,
    required this.description,
    required this.venue,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.imageUrl,
    required this.totalStalls,
    required this.availableStalls,
    required this.pricePerStall,
  });
} 