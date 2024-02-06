extends Panel

@onready var new_folder = $NewFolder
@onready var folders = $Folders
@onready var check_box = $CheckBox
@onready var main = $"../.."
@onready var change_folder = $ChangeFolder
@onready var rename_menu = $".."

func _ready():
	check_box.connect("toggled",func(toggle):
		new_folder.visible = toggle
		folders.visible = !toggle
		)
	change_folder.connect("button_down",func():
		if !check_box.button_pressed:
			FindSongs.save_cfg(Globals.hovering["true_name"],"playlist",folders.get_item_text(folders.selected))
		else:
			var file_exists := DirAccess.dir_exists_absolute(str("user://songs/",new_folder.text))
			if file_exists:
				FindSongs.save_cfg(Globals.hovering["true_name"],"playlist",new_folder.text)
			else:
				var dir_access = DirAccess.open("user://songs/")
				dir_access.make_dir(new_folder.text)
				update_playlist()
		rename_menu.change_visible(false)
		)
	new_folder.connect("text_changed",func(text):
		var file_exists := DirAccess.dir_exists_absolute(str("user://songs/",text))
		if file_exists:
			change_folder.text = "change folder"
		else:
			change_folder.text = "create folder"
		)
	await get_tree().create_timer(0.5).timeout
	update_playlist()

func update_playlist():
	folders.item_count = 0
	folders.add_item("none")
	for i in main.all_playlists:
		folders.add_item(i)
	FileDialog


