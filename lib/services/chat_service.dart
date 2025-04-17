import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:exhibae/models/message_model.dart';
import 'dart:io';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Get chat messages between two users
  Stream<List<MessageModel>> getMessages(String senderId, String receiverId) {
    return _firestore
        .collection('chats')
        .doc(_getChatId(senderId, receiverId))
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => MessageModel.fromMap(doc.data())).toList());
  }

  // Send a text message
  Future<void> sendTextMessage({
    required String senderId,
    required String receiverId,
    required String content,
  }) async {
    try {
      final message = MessageModel(
        id: '',
        senderId: senderId,
        receiverId: receiverId,
        content: content,
        timestamp: DateTime.now(),
        isRead: false,
        type: 'text',
      );

      await _firestore
          .collection('chats')
          .doc(_getChatId(senderId, receiverId))
          .collection('messages')
          .add(message.toMap());
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  // Send an image message
  Future<void> sendImageMessage({
    required String senderId,
    required String receiverId,
    required String imagePath,
  }) async {
    try {
      final imageUrl = await _uploadImage(senderId, receiverId, imagePath);
      
      final message = MessageModel(
        id: '',
        senderId: senderId,
        receiverId: receiverId,
        imageUrl: imageUrl,
        timestamp: DateTime.now(),
        isRead: false,
        type: 'image',
      );

      await _firestore
          .collection('chats')
          .doc(_getChatId(senderId, receiverId))
          .collection('messages')
          .add(message.toMap());
    } catch (e) {
      throw Exception('Failed to send image message: $e');
    }
  }

  // Send a document message
  Future<void> sendDocumentMessage({
    required String senderId,
    required String receiverId,
    required String documentPath,
  }) async {
    try {
      final documentUrl = await _uploadDocument(senderId, receiverId, documentPath);
      
      final message = MessageModel(
        id: '',
        senderId: senderId,
        receiverId: receiverId,
        documentUrl: documentUrl,
        timestamp: DateTime.now(),
        isRead: false,
        type: 'document',
      );

      await _firestore
          .collection('chats')
          .doc(_getChatId(senderId, receiverId))
          .collection('messages')
          .add(message.toMap());
    } catch (e) {
      throw Exception('Failed to send document message: $e');
    }
  }

  // Mark messages as read
  Future<void> markMessagesAsRead(String senderId, String receiverId) async {
    try {
      final messages = await _firestore
          .collection('chats')
          .doc(_getChatId(senderId, receiverId))
          .collection('messages')
          .where('receiverId', isEqualTo: receiverId)
          .where('isRead', isEqualTo: false)
          .get();

      for (var doc in messages.docs) {
        await doc.reference.update({'isRead': true});
      }
    } catch (e) {
      throw Exception('Failed to mark messages as read: $e');
    }
  }

  // Get unread message count
  Stream<int> getUnreadMessageCount(String userId) {
    return _firestore
        .collectionGroup('messages')
        .where('receiverId', isEqualTo: userId)
        .where('isRead', isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  // Helper method to get chat ID
  String _getChatId(String senderId, String receiverId) {
    return senderId.hashCode <= receiverId.hashCode
        ? '$senderId-$receiverId'
        : '$receiverId-$senderId';
  }

  // Helper method to upload image
  Future<String> _uploadImage(String senderId, String receiverId, String imagePath) async {
    try {
      final ref = _storage.ref().child(
          'chats/${_getChatId(senderId, receiverId)}/images/${DateTime.now().millisecondsSinceEpoch}');
      final uploadTask = await ref.putFile(File(imagePath));
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  // Helper method to upload document
  Future<String> _uploadDocument(String senderId, String receiverId, String documentPath) async {
    try {
      final ref = _storage.ref().child(
          'chats/${_getChatId(senderId, receiverId)}/documents/${DateTime.now().millisecondsSinceEpoch}');
      final uploadTask = await ref.putFile(File(documentPath));
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      throw Exception('Failed to upload document: $e');
    }
  }
} 