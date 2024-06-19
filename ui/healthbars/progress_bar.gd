extends ProgressBar

var fill_stylebox: StyleBoxFlat
const health_bar_colours = preload("res://ui/healthbars/health_bar_colours.tres")

func _ready():
	fill_stylebox = get_theme_stylebox("fill")

func _on_value_changed(new_value):
	fill_stylebox.bg_color = health_bar_colours.gradient.sample(1 - (new_value / max_value))
