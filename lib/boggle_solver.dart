import 'package:retrieval/trie.dart';
import 'dart:io';

//Class that takes in a list of 16 strings creates a boggle board with a list of words in the board
class BoggleSolver{
  Trie _trie = Trie();
  Set<String> _wordsOnBoard = {};
  final List<List<String>> _board = []; //dice in order from left to right, top to bottom
  BoggleSolver(List<String> diceValues) {
    assert(diceValues.length == 16);

    //TODO: create a trie with a dictionary
    //add dice to board
    for (int i = 0; i < 4; i++) {
      _board.add([]);
      for (int j = 0; j < 4; i++) {
        _board[i].add(diceValues[(4 * i) + j]);
      }
    }

    //solve the board
    _solve();
  }
  
  void _solve() {
    Set<String> empty = {};
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        _recursiveSolver(i,j,"", empty);
      }
    }
  }

  void _recursiveSolver(int row, int col, String currentWord, Set<String> diceUsed){
    //Recursive alorithm for find words in boggle board
    String diceKey = row.toString() + ':' + col.toString();
    //Base Case 1: row or col is out of bounds of board
    if (row > 3 || row < 0 || col > 3 || col < 0)
    {
      //do nothing and return
    }
    //Base Case 2: die has already been used in the word
    else if (diceUsed.contains(diceKey)){
      //do nothing and return
    }
    else
    {
      currentWord += _board[row][col];
      if (_trie.find(currentWord).isEmpty) {
        //only continue if words can start with current dice
      }
      else {
        if (_trie.has(currentWord)) {
          _wordsOnBoard.add(currentWord);
        }
        diceUsed.add(diceKey);
        _recursiveSolver(row - 1, col, currentWord, diceUsed); //north
        _recursiveSolver(row - 1, col + 1, currentWord, diceUsed); //northeast
        _recursiveSolver(row, col + 1, currentWord, diceUsed); //east
        _recursiveSolver(row + 1, col + 1, currentWord, diceUsed); //southeast
        _recursiveSolver(row + 1, col, currentWord, diceUsed); //south
        _recursiveSolver(row + 1, col - 1, currentWord, diceUsed); //southwest
        _recursiveSolver(row, col - 1, currentWord, diceUsed); //west
        _recursiveSolver(row - 1, col, currentWord, diceUsed); //northwest
      }
    }
  }

}