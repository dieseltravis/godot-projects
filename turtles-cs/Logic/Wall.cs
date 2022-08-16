using Godot;

public class Wall : Area2D
{
	[Export]
	private string _bounceParam = "";

	public void OnAreaEntered(Area2D area)
	{
		//TODO: turtle
		if (area is Turtle turt)
		{
			// Turtle went hit the side of the screen, bounce it.
			//turt.direction = (turt.direction + new Vector2(0, _bounceDirection)).Normalized();
			turt.Bounce(_bounceParam);
			/*
			if (this.name == "LeftWall" || this.name == "RightWall") {
				turt.Bounce("x");
			} else if (this.name == "TopWall" || this.name == "BottomWall") {
				turt.Bounce("y");
			}
			*/
		}
	}
}
