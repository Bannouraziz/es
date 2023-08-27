import 'package:cloud_firestore/cloud_firestore.dart';

class VotingHistoryManager {
  late CollectionReference _votingHistoryCollection;

  VotingHistoryManager({required CollectionReference collectionReference}) {
    _votingHistoryCollection = collectionReference;
  }

  Future<bool> hasVoted(String surveyId, String userId) async {
    DocumentSnapshot historySnapshot =
        await _votingHistoryCollection.doc(userId).get();

    if (historySnapshot.exists) {
      Map<String, dynamic> historyData =
          historySnapshot.data() as Map<String, dynamic>;
      return historyData.containsKey(surveyId);
    }

    return false;
  }

  Future<void> setVoted(String surveyId, String userId) async {
    await _votingHistoryCollection.doc(userId).set({
      surveyId: true,
    }, SetOptions(merge: true));
  }

  static Future<VotingHistoryManager> create() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('voting_history');
    return VotingHistoryManager(collectionReference: collectionReference);
  }
}
