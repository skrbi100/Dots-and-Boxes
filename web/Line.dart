part of demo;

/*The line object is a simple extension from the Sprite class and includes some relatively basic functionality. 
*  The line object has one click event where a boolean value represents if it is a clicked or not.  Additionally,
* the click event modifies the property of the line to change the color and thickness of the line to indicate it has 
* been clicked to the user. */
class Line extends Sprite
{
	int x;
	int y;
	int type;
	bool isClicked = false;

	Line(int xPos, int yPos, int type)
	{
		this.x = xPos;
		this.y = yPos;
		this.type = type;

		if(type == 1)
		{
			
			graphics.beginPath();
			graphics.moveTo(x, y);
			graphics.lineTo(x+275, yPos);
			graphics.closePath();
			graphics.strokeColor(Color.LightGray,20);
			addEventListener(MouseEvent.CLICK, fillLine);	
			
		}
		else if(type == 2)
		{
			graphics.beginPath();
			graphics.moveTo(x, y);
			graphics.lineTo(x, y+275);
			graphics.closePath();
			graphics.strokeColor(Color.LightGray,20);
			addEventListener(MouseEvent.CLICK, fillLine);
			
		}
	}

	fillLine(MouseEvent event)
	{
		graphics.strokeColor(Color.Black,22);//Changes visual representation of the line
		isClicked = true;
		mouseEnabled = false;

	}
}