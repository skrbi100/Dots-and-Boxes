part of demo;

/*Fairly straightforward class used to represent the indicated users box. If player 1 or player 2
* has filled the box the square color will fill with the corresponding color. This class is only used 
* in order for more effective control of the square in each Box object. */

class Square extends Sprite
{
	int x;
	int y;
	int w;
	int h;

	Square(int x, int y, int w, int h)
	{
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
		graphics.rect(x+10,y+10,w,h);
		
	}

}