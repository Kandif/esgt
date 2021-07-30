# Easy Scene Godot Transition
Simple scirpt for Godot transitions beetwen scenes. Color or image.

## esgt Using:

You need just to copy file and autoload this as Singleton.
![Image AUTOLOAD](https://github.com/Kandif/esgt/blob/main/autoload.png?raw=true)

Then when you want to change your scene use:
```GDscript
  ESGT.change_scene("path_to_scene")
```

You can change some atributes:
duration in seconds:
```GDscript
  ESGT.set_transition_time(3)
```
kind of transition:
```GDscript
  ESGT.set_transition("left_to-right")
```
set default transiting by image:
```GDscript
  ESGT.set_image(preload("res://image.jpg"))
```
or set default color of transiting:
```GDscript
  ESGT.set_color(Color.BLUE)
```

You also can once time set tranition during change:
```GDscript
  ESGT.change_scene("res://Scene.tscc",2,"left-to-right")
```

