class MessageModel {
  final String id;
  final String senderId;
  final String receiverId;
  final String? content;
  final String? imageUrl;
  final String? documentUrl;
  final DateTime timestamp;
  final bool isRead;
  final String type;

  MessageModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    this.content,
    this.imageUrl,
    this.documentUrl,
    required this.timestamp,
    required this.isRead,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
      'imageUrl': imageUrl,
      'documentUrl': documentUrl,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'type': type,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] ?? '',
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      content: map['content'],
      imageUrl: map['imageUrl'],
      documentUrl: map['documentUrl'],
      timestamp: DateTime.parse(map['timestamp']),
      isRead: map['isRead'] ?? false,
      type: map['type'] ?? 'text',
    );
  }

  MessageModel copyWith({
    String? id,
    String? senderId,
    String? receiverId,
    String? content,
    String? imageUrl,
    String? documentUrl,
    DateTime? timestamp,
    bool? isRead,
    String? type,
  }) {
    return MessageModel(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      documentUrl: documentUrl ?? this.documentUrl,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      type: type ?? this.type,
    );
  }
} 