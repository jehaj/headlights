using Godot;
using System;

public partial class Alien : RigidBody3D
{
	[Export]
	private RayCast3D rayCast;
	[Export]
	private AnimatedSprite3D sprite;
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _PhysicsProcess(double delta)
	{
		string animation = rayCast.IsColliding() ? "stand" : "jump";
		sprite.Animation = animation;
	}
}
