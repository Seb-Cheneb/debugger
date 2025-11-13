extends RefCounted


func get_class_name(object: Object) -> String:
	return object.get_script().get_path().get_file().get_basename()


func get_calling_method() -> String:
	var stack = get_stack()
	# Skip get_calling_method() and log_info()
	if stack.size() >= 3:  
		return stack[2]["function"]
	return "unknown_method"


func print_message(object: Object, message: String, is_debugging: bool, color: String) -> void:
	if not is_debugging:
		return
	print_rich(
		"[color=white]", get_class_name(object), 
		"[/color].[color=white]", get_calling_method(), 
		"[/color].[color=" + color +"] - ", message)		


func info(object: Object, message: String, is_debugging: bool = true) -> void:
	print_message(object, message, is_debugging, "green")


func warn(object: Object, message: String, is_debugging: bool = true) -> void:
	print_message(object, message, is_debugging, "yellow")


func error(object: Object, message: String, is_debugging: bool = true) -> void:
	print_message(object, message, is_debugging, "red")


func check_reference(object: Object, referenced_object: Object) -> void:
	if not referenced_object:
		print_message(object, referenced_object.name + " not set", true, "red")
