library demo;

import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';
import 'dart:js' as js;

part 'gameBoard.dart';
part 'Line.dart';
part 'Square.dart';
part 'Box.dart';
part 'Game.dart';


void main() 
{
	Game game = new Game();
	game.playGame();
}


