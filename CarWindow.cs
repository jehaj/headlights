using Godot;
using System;
using System.Numerics;

public partial class CarWindow : AnimatableBody3D
{
	private int direction = 0;
    [Export]
    private float minPos;
    [Export]
    private float maxPos;


    [Export]
	private float speed { get; set; } = 5f;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _PhysicsProcess(double delta)
	{
		direction = Convert.ToInt32(Input.IsActionPressed("up")) - Convert.ToInt32(Input.IsActionPressed("down"));
		if ((this.Position.Y < minPos && direction < 0) || 
		    (this.Position.Y > maxPos && direction > 0)) return;
		this.Position += Godot.Vector3.Up * direction * speed * (float)delta;
	}
}
