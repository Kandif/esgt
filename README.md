# Easy Scene Godot Transition
Simple scirpt for Godot's transitions beetwen scenes. Color or image.

## esgt Using:

You just need to copy file and autoload this as Singleton.
![Image AUTOLOAD](https://github.com/Kandif/esgt/blob/main/autoload.png?raw=true)

Then when you want to change your scene use:
```GDscript
  ESGT.change_scene("path_to_scene")
```

### You can change some atributes:
duration in seconds:
```GDscript
  ESGT.set_transition_time(3)
```
kind of transition:
```GDscript
  ESGT.set_transition("left_to-right")
```
Acutally there is a few kinds of transitions: "fade","left-to-right","right-to-left","up-to-down","down-to-up"
Fade is default


set default transiting by image:
```GDscript
  ESGT.set_image(preload("res://image.jpg"))
```
or set default color of transiting:
```GDscript
  ESGT.set_color(Color.BLUE)
```

You also can once time set tranition during scene change:
```GDscript
  ESGT.change_scene("res://Scene.tscc",2,"left-to-right")
```

