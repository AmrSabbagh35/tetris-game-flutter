import 'package:tetris/board.dart';
import 'package:tetris/values.dart';

class Piece {
  Tetromino type;
  Piece({required this.type});

  List<int> position = [];

  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        position = [
          -26, // Initial position of the L piece
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.J:
        position = [
          -25, // Initial position of the J piece
          -15,
          -5,
          -6,
        ];
        break;
      case Tetromino.I:
        position = [
          -4, // Initial position of the I piece
          -5,
          -6,
          -7,
        ];
        break;
      case Tetromino.O:
        position = [
          -15, // Initial position of the O piece
          -16,
          -5,
          -6,
        ];
        break;
      case Tetromino.S:
        position = [
          -15, // Initial position of the S piece
          -14,
          -6,
          -5,
        ];
        break;
      case Tetromino.Z:
        position = [
          -17, // Initial position of the Z piece
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.T:
        position = [
          -26, // Initial position of the T piece
          -16,
          -6,
          -15,
        ];
        break;
      default:
    }
  }

  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] +=
              rowLength; // Move each position down by the length of a row
        }
        break;
      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1; // Move each position to the right by 1
        }
        break;
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1; // Move each position to the left by 1
        }
        break;
      default:
    }
  }

  int rotationstate = 0;

  void rotatePiece() {
    List<int> newPosition = [];

    switch (type) {
      case Tetromino.L:
        // Rotation logic for L piece
        switch (rotationstate) {
          case 0:
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationstate = (rotationstate + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationstate = (rotationstate + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationstate = (rotationstate + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationstate = (rotationstate + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.J:
        // Rotation logic for J piece
        switch (rotationstate) {
          case 0:
            newPosition = [
              position[1] - rowLength, // Position above the center
              position[1], // Center position
              position[1] + rowLength, // Position below the center
              position[1] + rowLength - 1, // Position to the left of the center
            ];
            /* Shape after rotation:
         0
         0
         0 0
      */
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationstate = (rotationstate + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] -
                  rowLength -
                  1, // Position to the left and above the center
              position[1], // Center position
              position[1] - 1, // Position to the left of the center
              position[1] + 1, // Position to the right of the center
            ];
            /* Shape after rotation:
         0 0 0
         0
      */
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationstate = (rotationstate + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] + rowLength, // Position below the center
              position[1], // Center position
              position[1] - rowLength, // Position above the center
              position[1] -
                  rowLength +
                  1, // Position to the right of the center
            ];
            /* Shape after rotation:
         0 0
           0
           0
      */
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationstate = (rotationstate + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] + 1, // Position to the right of the center
              position[1], // Center position
              position[1] - 1, // Position to the left of the center
              position[1] +
                  rowLength +
                  1, // Position to the right and below the center
            ];
            /* Shape after rotation:
         0
         0 0 0
      */
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationstate = (rotationstate + 1) % 4;
            }
            break;
        }
        break;

      case Tetromino.I:
        // Rotation logic for I piece
        switch (rotationstate) {
          case 0:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationstate = (rotationstate + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + 2 * rowLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationstate = (rotationstate + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationstate = (rotationstate + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + 2 * rowLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationstate = (rotationstate + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.O:
        break;
      case Tetromino.S:
        // Rotation logic for S piece
        switch (rotationstate) {
          case 0:
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationstate = (rotationstate + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationstate = (rotationstate + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationstate = (rotationstate + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationstate = (rotationstate + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.Z:
        // Rotation logic for Z piece
        switch (rotationstate) {
          case 0:
            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationstate = (rotationstate + 1) % 4;
            }
            break;

          case 1:
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationstate = (rotationstate + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[0] - rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationstate = (rotationstate + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationstate = (rotationstate + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.T:
        // Rotation logic for T piece
        switch (rotationstate) {
          case 0:
            newPosition = [
              position[2] - rowLength,
              position[2],
              position[2] + 1,
              position[2] + rowLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationstate = (rotationstate + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationstate = (rotationstate + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] - rowLength,
              position[1] - 1,
              position[1],
              position[1] + rowLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationstate = (rotationstate + 1) % 4;
            }

            break;
          case 3:
            newPosition = [
              position[2] - rowLength,
              position[2] - 1,
              position[2],
              position[2] + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationstate = (rotationstate + 1) % 4;
            }
            break;
        }
        break;
      default:
        // Handle any additional tetromino shapes here
        // ...
        break;
    }

    if (piecePositionIsValid(newPosition)) {
      position = newPosition; // Update the piece's position
      rotationstate = (rotationstate + 1) % 4; // Update the rotation state
    }
  }

  bool isPositionValid(int position) {
    int row = (position / rowLength).floor();
    int column = (position % rowLength);

    if (row < 0 || column < 0 || gameBoard[row][column] != null) {
      return false; // Check if the position is valid (within the board boundaries and not occupied by another piece)
    } else {
      return true;
    }
  }

  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for (int pos in piecePosition) {
      if (!isPositionValid(pos)) {
        return false; // If any of the positions is invalid, return false
      }
      int col = pos % rowLength;

      if (col == 0) {
        firstColOccupied =
            true; // Check if the first column is occupied by the piece
      }
      if (col == rowLength - 1) {
        lastColOccupied =
            true; // Check if the last column is occupied by the piece
      }
    }
    return !(firstColOccupied &&
        lastColOccupied); // Return true if neither the first nor the last column is occupied by the piece
  }
}
