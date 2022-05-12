class score_calculator{
  int calcScore(List<String> wordsOnBoard) {
    int score = 0;
    for (int i = 0; i < wordsOnBoard.length; i++) {
      if (wordsOnBoard.elementAt(i).length == 3 || wordsOnBoard.elementAt(i).length == 4) {
        score += 1;
      } else if (wordsOnBoard.elementAt(i).length == 5) {
        score += 2;
      } else if (wordsOnBoard.elementAt(i).length == 6) {
        score += 3;
      } else if (wordsOnBoard.elementAt(i).length == 7) {
        score += 5;
      } else if (wordsOnBoard.elementAt(i).length > 7) {
        score += 11;
      }
    }
    return score;
  }
}
