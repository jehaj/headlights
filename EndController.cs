using Godot;
using System;

public partial class EndController : Node
{
	// Called when the node enters the scene tree for the first time.

	[Export]
	private Node3D sprite3D;
	public override void _Ready()
	{
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}

	public void _on_timer_timeout() {
		sprite3D.Visible = true;
	}
}
