@tool extends EditorPlugin

# ------------------------------------------------------------------------------
# Build-in methods
# ------------------------------------------------------------------------------

func _enter_tree() -> void:
	self.add_custom_type("LoadingSpinner", "TextureProgressBar", preload("loading_spinner.gd"), preload("icon.png"))

func _exit_tree() -> void:
	self.remove_custom_type("LoadingSpinner")
