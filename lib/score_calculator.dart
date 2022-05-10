

class score_calculator{
  int getMaxScore(List<String> wordsOnBoard) {
    int maxScore = 0;
    for (int i = 0; i < wordsOnBoard.length; i++) {
      if (wordsOnBoard.elementAt(i).length == 3 || wordsOnBoard.elementAt(i).length == 4) {
        maxScore += 1;
      } else if (wordsOnBoard.elementAt(i).length == 5) {
        maxScore += 2;
      } else if (wordsOnBoard.elementAt(i).length == 6) {
        maxScore += 3;
      } else if (wordsOnBoard.elementAt(i).length == 7) {
        maxScore += 5;
      } else if (wordsOnBoard.elementAt(i).length > 7) {
        maxScore += 11;
      }
    }
    return maxScore;
  }


}


