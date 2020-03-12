extends Spatial

var controller : ARVRController = null


export var jump_speed = 5

export(vr.AXIS) var move_left_right = vr.AXIS.LEFT_JOYSTICK_X;
export(vr.AXIS) var move_forward_back = vr.AXIS.LEFT_JOYSTICK_Y;


func _ready():
	controller = get_parent()


func _physics_process(dt):
#	if is_on_floor():
	if controller._button_just_pressed(vr.CONTROLLER_BUTTON.INDEX_TRIGGER):
		print('TRYING TO JUMP')
		
		var dx = vr.get_controller_axis(move_left_right)
		var dy = vr.get_controller_axis(move_forward_back)
		
		var view_direction = -vr.vrCamera.global_transform.basis.z
		var strafe_direction = vr.vrCamera.global_transform.basis.x
		
		view_direction.y = 0.0
		strafe_direction.y = 0.0
		view_direction = view_direction.normalized()
		strafe_direction = strafe_direction.normalized()
		
		var move = Vector2(dx, dy).normalized() * jump_speed
		
		var actual_velocity = (view_direction * move.y + strafe_direction * move.x)
		
		vr.vrOrigin.translation += actual_velocity * dt


