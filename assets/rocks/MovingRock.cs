using Godot;
using System;

public partial class MovingRock : Node3D
{
	private float mySpeed;
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		this.mySpeed = ((GameController) this.GetParent()).CarSpeed;
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _PhysicsProcess(double delta)
	{
		this.Position += Vector3.Left * mySpeed * (float) delta;
	}
}
