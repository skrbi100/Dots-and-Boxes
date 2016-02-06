part of demo;

/* The class Game will initialize the html canvas and use the Stage object provided in StageXL to render graphics. The class is used primarily to 
initialize the board as well as check if the game is over and reinitialize a new game*/

class Game
{
	var canvas;
	var stage;
	var renderLoop;
	gameBoard board;

	Game()
	{
		canvas = html.querySelector('#stage');
		setCanvasFullScreen(canvas);
		StageXL.stageOptions.renderEngine = RenderEngine.Canvas2D;
		stage = new Stage(canvas);
		renderLoop = new RenderLoop();
		renderLoop.addStage(stage);
		stage.addEventListener(MouseEvent.CLICK, checkGameOver);
	}

	void playGame()
	{
		board = new gameBoard();
		stage.addChildAt(board,0);
	}

	checkGameOver(MouseEvent event)
	{
		if(board.gameOver)
		{
			stage.removeChildAt(0);
			playGame();	
		}
	}

	void clearStage()/*the StageXL library works in the same way as Flash ActionScript, 
	so all objects that are displayed are children of the Stage. When the game is over they are all removed using this function.*/
	{
		while(stage.numChildren > 0)
		{
			stage.removeChildAt(0);
		}
	}

	void setCanvasFullScreen(canv)//Sets the dimensions of the graphics rendering window, this particular one centers it on the page
	{
		var w = html.window;
		int _width = w.innerWidth as int;
		int _height = w.innerHeight as int;
		canv.setAttribute('width', '$_width');
		canv.setAttribute('height', '$_height');
	}
}