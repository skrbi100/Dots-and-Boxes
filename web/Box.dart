part of demo;

/*The Box class implments the two more basic Line and Square objects.  Each Box object is made up of 4 lines and one square.  This allows for 
* easy checking of when the boxes are clicked since it is handled by a simple gettter call to each line object.  If all the four lines are clicked
* a boolean is returned indicating that the click event on the gameboard caused a completed box. */

class Box extends Sprite
{
	Line line1;
	Line line2;
	Line line3;
	Line line4;
	Square square;
	bool isTaken = false;

	Box(Line l1, Line l2, Line l3, Line l4,Square sqr)
	{
		this.line1 = l1;
		this.line2 = l2;
		this.line3 = l3;
		this.line4 = l4;
		this.square = sqr;
		addChild(l1);
		addChild(l2);
		addChild(l3);
		addChild(l4);
		addChild(sqr);
	}


	bool isBox()
	{
		if(line1.isClicked == true && line2.isClicked == true && line3.isClicked == true && line4.isClicked == true)
		{
			return true;
		}
		else
			return false;

	}
}