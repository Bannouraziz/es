class Survey {
  final String question;
  String imagePath;
  String imageUrl = '';
  final List<String> options;
  bool hasVoted;

  Survey({
    required this.question,
    required this.imagePath,
    required this.options,
    this.hasVoted = false,
  });

  void setVotingStatus(bool voted) {
    hasVoted = voted;
  }

  bool getVotingStatus() {
    return hasVoted;
  }
}
