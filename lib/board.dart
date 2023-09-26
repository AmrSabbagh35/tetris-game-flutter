import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris/piece.dart';
import 'package:tetris/pixel.dart';
import 'package:tetris/values.dart';

List<List<Tetromino?>> gameBoard =
    List.generate(columnLength, (i) => List.generate(rowLength, (j) => null));

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  Piece currentPiece = Piece(type: Tetromino.L);
  int score = 0;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  startGame() {
    currentPiece.initializePiece();

    Duration frameRate = const Duration(milliseconds: 400);
    gameLoop(frameRate);
  }

  void gameOver() {
    // You can add game over logic here, such as displaying a dialog or navigating to a game over screen.
    // For example, you can show an AlertDialog with the player's score and an option to restart the game.
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Text('Score: $score'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // resetGame(); // You can implement this function to reset the game.
              },
              child: const Text('Restart'),
            ),
          ],
        );
      },
    );
  }

  gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        checkLanding();
        currentPiece.movePiece(Direction.down);
      });
    });
  }

  bool checkCollision(Direction direction) {
    for (var i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int column = (currentPiece.position[i] % rowLength);

      if (direction == Direction.left) {
        column -= 1;
      } else if (direction == Direction.right) {
        column += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }
      if (row >= columnLength || column < 0 || column >= rowLength) {
        return true;
      } else if (column > 0 && row > 0 && gameBoard[row][column] != null) {
        return true;
      }
    }
    return false;
  }

  void checkLanding() {
    if (checkCollision(Direction.down)) {
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int column = (currentPiece.position[i] % rowLength);

        if (row >= 0 && column >= 0) {
          gameBoard[row][column] = currentPiece.type;
        }
      }

      // Check for completed lines and clear them
      int clearedLines = 0;
      for (int row = columnLength - 1; row >= 0; row--) {
        bool isCompleted = true;
        for (int column = 0; column < rowLength; column++) {
          if (gameBoard[row][column] == null) {
            isCompleted = false;
            break;
          }
        }

        if (isCompleted) {
          // Clear the completed line and move all lines above it down
          for (int r = row; r > 0; r--) {
            for (int c = 0; c < rowLength; c++) {
              gameBoard[r][c] = gameBoard[r - 1][c];
            }
          }
          clearedLines++;
        }
      }

      // Update the score based on cleared lines
      if (clearedLines > 0) {
        score +=
            clearedLines * 100; // You can adjust the scoring system as needed
      }

      // Create a new piece
      createNewPiece();

      // Check for game over
      if (checkCollision(Direction.down)) {
        gameOver();
      }
    }
  }

  void createNewPiece() {
    Random rand = Random();
    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();
  }

  void moveLeft() {
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  void moveRight() {
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: rowLength),
                itemCount: rowLength * columnLength,
                itemBuilder: (context, index) {
                  int row = (index / rowLength).floor();
                  int column = (index % rowLength);
                  if (currentPiece.position.contains(index)) {
                    return Pixel(
                      color: currentPiece.type.color,
                    );
                  } else if (gameBoard[row][column] != null) {
                    return Pixel(color: Colors.blue);
                  } else {
                    return Pixel(
                      color: Colors.grey[900],
                    );
                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: moveLeft,
                    color: Colors.white,
                    icon: const Icon(Icons.arrow_back_ios)),
                IconButton(
                    onPressed: rotatePiece,
                    color: Colors.white,
                    icon: const Icon(Icons.rotate_right)),
                IconButton(
                    onPressed: moveRight,
                    color: Colors.white,
                    icon: const Icon(Icons.arrow_forward_ios)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
