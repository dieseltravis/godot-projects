using Godot;
using System;

public class Turtle : Area2D
{
	private const int DefaultSpeed = 50;

	public Vector2 direction = Vector2.Left;

	private Vector2 _initialPos;
	private float _speed = DefaultSpeed;
	private Random rnd = new Random();

	public override void _Ready()
	{
		_initialPos = Position;
		Reset();
	}

	public override void _Process(float delta)
	{
		_speed += delta * 2;
		Position += _speed * delta * direction;
	}

	public void Reset()
	{
		var x = (float)(rnd.NextDouble() * 2 - 1);
		var y = (float)(rnd.NextDouble() * 2 - 1);
		Console.Out.Write("x: {0}, y: {1}", x, y);
		direction = new Vector2(x, y).Normalized();
		Position = _initialPos;
		_speed = DefaultSpeed;
	}

	public void Bounce(string dir)
	{
		if (dir == "x") { 
			direction = new Vector2(-direction.x, direction.y);
		} else if (dir == "y") {
			direction = new Vector2(direction.x, -direction.y);				
		}
	}
}
