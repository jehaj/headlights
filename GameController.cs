using Godot;
using System;

public partial class GameController : Node
{
	[Export]
	public float CarSpeed { get; set; } = 5f;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}

	public void _on_alien_body_entered(Node3D body) {
		GD.Print("You hit the rock!");
	}
}
