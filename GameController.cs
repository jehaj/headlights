using Godot;
using System;
using System.Collections.Generic;

public partial class GameController : Node
{
	[Export]
	public float CarSpeed { get; set; } = 5f;
	
	[Export]
	public float MaxCarSpeed { get; set; } = 5f;
	[Export]
	public string[] bodies = new string[0];
	[Export]
	public Alien alien;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		for (int i = 0; i < bodies.Length; i++)
		{
			string scenePath = bodies[i];
		}
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		this.CarSpeed = this.CarSpeed + 2f * (float) delta;
		this.CarSpeed = Math.Clamp(this.CarSpeed, 0, MaxCarSpeed);
	}

	public void _on_alien_body_entered(Node3D body) {
		GD.Print("You hit the something!");
	}

	public void _on_area_3d_body_entered(Node3D body) {
		if (!body.IsInGroup("Obstacle")) return;
		GD.Print("You hit the rock!");
		alien.hit();
		this.CarSpeed -= 10;

	}
}
