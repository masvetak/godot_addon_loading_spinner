@tool class_name LoadingSpinner extends TextureProgressBar

const LOADING_SPINNER_TEXTURE = preload("res://addons/godot_addon_loading_spinner/textures/loading.png")

@export var active: bool = true:
	set(new_value):
		active = new_value
		_update_active()
@export var color: Color = Color.WHITE:
	set(new_value):
		color = new_value
		_update_color()

var tween: Tween = null

# ------------------------------------------------------------------------------
# Build-in methods
# ------------------------------------------------------------------------------

func _ready() -> void:
	_update()

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_EDITOR_PRE_SAVE:
			_update_initial_data()

# ------------------------------------------------------------------------------
# Private methods
# ------------------------------------------------------------------------------

func _tween_start() -> void:
	if tween != null: tween.kill()
	tween = get_tree().create_tween().set_loops(0)
	tween.tween_property(self, "radial_initial_angle", 360.0, 1.0).as_relative()

func _tween_stop() -> void:
	tween.stop()
	tween.kill()

func _update_initial_data() -> void:
	if not self.is_inside_tree(): return
	
	self.fill_mode = FillMode.FILL_CLOCKWISE
	self.radial_initial_angle = 0
	self.radial_fill_degrees = 45
	self.value = 100

func _update_active() -> void:
	if not self.is_inside_tree(): return
	
	if active: _tween_start()
	else: _tween_stop()

func _update_color() -> void:
	if not self.is_inside_tree(): return
	
	self.tint_under = Color("00000000")
	self.tint_over = Color("00000000")
	self.tint_progress = color

func _update_textures() -> void:
	if not self.is_inside_tree(): return
	
	self.texture_under = LOADING_SPINNER_TEXTURE
	self.texture_over = LOADING_SPINNER_TEXTURE
	self.texture_progress = LOADING_SPINNER_TEXTURE

func _update() -> void:
	_update_initial_data()
	_update_active()
	_update_color()
	_update_textures()
