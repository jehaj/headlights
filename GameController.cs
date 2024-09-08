using Godot;
using System;
using System.Collections.Generic;
using System.Linq;

public partial class GameController : Node
{
	[Export]
	public float CarSpeed { get; set; } = 5f;

	[Export]
	public float MaxCarSpeed { get; set; } = 5f;
	[Export]
	public Alien alien;
	public PackedScene secondScene;
	public PackedScene thirdScene;
	private Random random = new Random();

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
        Godot.Collections.Array<Node> children = GetChildren();
        foreach (var child in children)
		{
			var childNode = (Node3D)child;
			if (childNode.Name.ToString().Contains("MovingTree") ||
				childNode.Name.ToString().Contains("MovingRock"))
			{
				float randomRotation = (float)(random.NextDouble() * 2 * Math.PI); // Random value between 0 and 2*PI (360 degrees)
				childNode.Rotation = new Vector3(0, randomRotation, 0);
			}
		}
		secondScene = GD.Load<PackedScene>("res://second.tscn");
		thirdScene = GD.Load<PackedScene>("res://third.tscn");
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		this.CarSpeed = this.CarSpeed + 2f * (float)delta;
		this.CarSpeed = Math.Clamp(this.CarSpeed, 0, MaxCarSpeed);
	}

	public void _on_alien_body_entered(Node3D body)
	{
		GD.Print("You hit the something!");
	}

	public void _on_area_3d_body_entered(Node3D body)
	{
		if (!body.IsInGroup("Obstacle")) return;
		GD.Print("You hit the rock!");
		alien.hit();
		this.CarSpeed -= 10;

	}

	public void _on_audio_stream_player_finished()
	{
		if(GetTree().Root.GetChild(0).Name.ToString() == "first") GetTree().ChangeSceneToPacked(secondScene);
		if(GetTree().Root.GetChild(0).Name.ToString() == "second") GetTree().ChangeSceneToPacked(thirdScene);
	}
}
