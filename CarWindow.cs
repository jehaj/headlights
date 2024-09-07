using Godot;
using System;

public partial class CarWindow : Sprite2D
{
    private Color targetColor = new Color(1, 0, 0); // Red color
    private double transitionSpeed = 0.3f;
	public override void _Ready()
	{
		
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		Color currentColor = Modulate;
        Modulate = currentColor.Lerp(targetColor, (float) (transitionSpeed * delta));
	}
}
