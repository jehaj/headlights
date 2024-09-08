using Godot;
using System;

public partial class Alien : RigidBody3D
{
	[Export]
	private RayCast3D rayCast;
	[Export]
	private AnimatedSprite3D sprite;
	[Export]
	private Node3D camera3D;
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _PhysicsProcess(double delta)
	{
		string animation = rayCast.IsColliding() && sprite.Animation != "hit" ? "stand" : "jump";
		sprite.Animation = animation;

		Vector3 direction = this.Position - camera3D.Position;
		direction = direction.Normalized();
		Node3D col = (Node3D) this.GetNode("Area3D");
		col.LookAt(direction+this.Position);
	}

	public void hit() {
		GD.Print("I hit sometjing");
		sprite.Animation = "hit";
	}

	public void _on_animated_sprite_3d_animation_finished() {
		if (sprite.Animation == "hit") {
			sprite.Animation = "stand";	
		}
	}
}
