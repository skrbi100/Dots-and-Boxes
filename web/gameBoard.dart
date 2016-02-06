 part of demo;

 /*The gameboard class is where the rendering and gamePlay predominantly takes place. The constructor creates all 16 boxes 
 * using a for loop that uses if else logic to indicate when a line is to be shared between two boxes.  Additionally, a click
 * event is included so that whenever a click on one of the 16 boxes is done a for loop checks whether any of the Box objects
 * has all 4 lines clicked. All the boxes are stored in a list for this check to take place.  Additionally, in this click event
 * the board calls a function to check if all 16 boxes have been filled and indicates to the players who has won and if they would
 * like to play again.  */


class gameBoard extends Sprite
{
	int xPos = 100;
	int yPos = -200;
	var circle = new Shape();
	var prevLine;
	var boardList = [];
	var squares = [];
	var lines = [];
	bool player = true;
	int playerOne = 0;
	int playerTwo = 0;
	bool boxFilled = true;
	int count = 0;
	bool gameOver = false;
	var element = html.document.querySelector('body');
	
	gameBoard()
	{	
		//render boxes
		for(int i = 0;i<4;i++)
		{
			if(i < 1)
			{
				Line l1 = new Line(xPos,yPos,1);
				Line l2 = new Line(xPos, yPos,2);
				Line l3 = new Line(xPos,yPos+275,1);
				Line l4 = new Line(xPos+275, yPos, 2);
				Square sqr = new Square(xPos,yPos,265,265);
				Box box = new Box(l1,l2,l3,l4,sqr);
				addChild(box);
				boardList.add(box);
				lines.add(l4);
				prevLine = l3;
				
			}
			else
			{
				Line l1 = prevLine;
				Line l2 = new Line(xPos,yPos,2);
				Line l3 = new Line(xPos,yPos+275,1);
				Line l4 = new Line(xPos+275,yPos,2);
				Square sqr = new Square(xPos,yPos,265,265);
				Box box = new Box(l1,l2,l3,l4,sqr);
				addChild(box);
				boardList.add(box);
				lines.add(l4);
				prevLine = l3;

			}
			yPos+=275;
		}
		xPos += 275;
		yPos = -200;	
		lines = generateCol(xPos,yPos, lines);
		xPos += 275;
		yPos = -200;	
		lines = generateCol(xPos,yPos, lines);
		xPos += 275;
		yPos = -200;	
		lines = generateCol(xPos,yPos, lines);
		
		xPos = 100;
		yPos =-200;
		for(int i = 0; i < 5;i++)
		{	
			for(int j = 0; j< 5;j++)
			{
				//render dots
				addChild(generateDots(xPos,yPos,25));
				xPos+=275;
			}
			xPos=100;
			yPos+=275;
		}
		addEventListener(MouseEvent.CLICK, react);
	}
	
	//This mouse event is how the board updates and allows for continous play
	react(MouseEvent event)
	{	
		for(Box box in boardList)
		{
			if(box.isBox() && !box.isTaken)
			{
				if(player)//the boolean value player switches on each click even to indicate which players turn it is
				{
					box.square.graphics.fillColor(Color.Firebrick);
					playerTwo++;//increments score to keep track of who is winning
				}
				else
				{
					box.square.graphics.fillColor(Color.SteelBlue);
					playerOne++;
				}
				box.isTaken = true;
				boxFilled = true;
			}
		}
			
		//These control statements change the background of the webpage based on whose turn it is.
		if(!boxFilled)
		{
			if(player)
			{
				element.classes.toggle('gameBoard-Red');
				player = false;
			}
			else
			{ 
				element.classes.toggle('gameBoard-Blue');
				player = true;
			}
		}
		boxFilled = false;
		

		//The boardFilled function is called each time to check whether all 16 boxes are filled.
		if(boardFilled())
		{
			var playAgain = js.context.callMethod('confirm',[whoWon()]);
			if(playAgain)
			{
				gameOver = true;
			}
		}
	
	}
	
	/*The way in which the board is generated is through adding 4 boxes in a column fashion.
	* This is the best method to allow for the sharing of line 3 between boxes and line 4 between
	* columns. Here is what the objects look like conceptually, 
	* 
	*   *-----line1-----*-----line1-----*
	*   |  				|				|
	* 	|				|				|
	* 	|		1	  line4     3     line4
	* 	|				|				|
	* 	|				|				|
	* 	*-----line3-----*-----line3-----*
	* 	|				|				|
	* 	|				|				|
	* 	|		2	  line4     4     line4
	* 	|				|				|
	* 	|				|				|
	* 	*-----line3-----*-----line3-----*
	* 
	The function below implments the logic where boxes 1 and 2 are rendered the first time it is called
	* and the subsequent time boxes 3 and 4 are generated sharing the lines indicated */
	List generateCol(int x, int y,var lines)
	{	
		var newLines = [];
		for(int i = 0;i<4;i++)
		{
			if(i < 1)
			{
				Line l1 = new Line(x,y,1);
				Line l2 = lines[i];
				Line l3 = new Line(x,y+275,1);
				Line l4 = new Line(x+275,y,2);
				Square sqr = new Square(x,y,265,265);
				Box box = new Box(l1,l2,l3,l4,sqr);
				addChild(box);
				boardList.add(box);
				prevLine = l3;
				newLines.add(l4);
				
			}
			else
			{
				Line l1 = prevLine;
				Line l2 = lines[i];
				Line l3 = new Line(x,y+275,1);
				Line l4 = new Line(x+275,y,2);
				Square sqr = new Square(x,y,265,265);
				Box box = new Box(l1,l2,l3,l4,sqr);
				addChild(box);
				boardList.add(box);
				prevLine = l3;
				newLines.add(l4);

			}
			y+=275;
		}
		return newLines;
	}
	
	//creates the dots that indicate the size of the board
	Shape generateDots(int x, int y, int size)
	{
		circle.graphics.circle(x,y,size);
		circle.graphics.fillColor(Color.Black);
		return circle;
	}

	bool boardFilled()
	{
		for(Box box in boardList)
		{
			if(!box.isTaken)
			{
				return false;
			}
		}
		return true;
		
	}
	//alerts the players to who has won the game based on score differences
	String whoWon()
	{
		if(playerTwo < playerOne)
		{
			return "Player 1 has Won! \nPlayer 1: " + playerOne.toString() + "\nPlayer 2: " + playerTwo.toString() + '\nWould you like to play again?';
		}
		else if(playerOne == playerTwo)
		{
			return "Player 1 and 2 have tied! \nPlayer 1: " + playerOne.toString() + "\nPlayer 2: " + playerTwo.toString()+ '\nWould you like to play again?';
		}
		else
			return "Player 2 has Won! \nPlayer 2: " + playerTwo.toString() + "\nPlayer 1: " + playerOne.toString()+ '\nWould you like to play again?';
	}
	
}