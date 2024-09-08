using Godot;
using System;

public partial class MovingRock : Node3D
{
	private float mySpeed;
	[Export]
	private float speed_delta=1f;
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _PhysicsProcess(double delta)
	{
		this.mySpeed = ((GameController) this.GetParent()).CarSpeed;
		this.Position += Vector3.Left * mySpeed * (float) delta*speed_delta;
	}
}
