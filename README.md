# laser_sight
Implementation of a laser sight in the Godot Engine.  Created using v3.1 release.

- Purpose - Show how to creat a laser sight in the godot engine using a custom shader.

- Requirements - Godot Engine v3.1 or equiavalent is installed. Two textures created as shown in the Diagram_Texture.tscn.

- Limitations - N/A

- Project Contents:
  - /Laser - Has the laser texture, shaders, laser scene, etc.

  - /Misc: Has a single pixel texture used to just add a visual to a wall.

  - /Player.tscn and Player.gd - code for a simple player that will spawn the laser.

  - /Diagram_Texture.tscn - Has instructions on how to make the laser textures. Note: Make sure the "right" sprite has 'flip_H' enabled.

  - /Game.tscn - Scene that will run when 'Play' his pressed.

 - Usage:
   1. Press 'Play' (F5).
   2. Move the player using the arrow keys ("ui_*" mappings).  
   3. Press LMB to toggle the laser on/off.
 
- Acknowledgment - Idea for making the texture images this way came from the tutorial at: https://gamedevelopment.tutsplus.com/tutorials/how-to-generate-shockingly-good-2d-lightning-effects--gamedev-2681
