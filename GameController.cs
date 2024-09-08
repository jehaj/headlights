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
	public List<PackedScene> packedScenes = new();
	[Export]
	public Alien alien;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		for (int i = 0; i < bodies.Length; i++)
		{
			string scenePath = bodies[i];
			packedScenes.Add(GD.Load<PackedScene>(scenePath));
		}
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		this.CarSpeed = this.CarSpeed + 0.01f;
		this.CarSpeed = Math.Clamp(this.CarSpeed, 0, MaxCarSpeed);
	}

	public void _on_alien_body_entered(Node3D body) {
		GD.Print("You hit the something!");
	}

	public void _on_area_3d_body_entered(Node3D body) {
		if (!body.IsInGroup("Obstacle")) return;
		GD.Print("You hit the rock!");
		alien.hit();
		this.CarSpeed -= 2;

	}

	public void _on_timer_timeout() {
		GD.Print("Spawning child");
		Node3D instance = (Node3D) packedScenes[0].Instantiate();
		instance.Position = new Vector3(45, 0, -25);
		this.AddChild(instance);
	}
}
