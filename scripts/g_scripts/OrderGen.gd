extends Node2D

static var next_id := 0

# UI References
@onready var o_num = $"order-text/OrderNumber"
@onready var c_name = $"order-text/CustomerName"
@onready var p_name = $"order-text/PlantType"
@onready var req_items = $"order-text/SpecialRequests"
@onready var t_due = $"order-text/TimeDue"
@onready var t_dolla = $"order-text/TotalCost"

var plants: Array[Plant] = []
var treatments: Array[Treat] = []

func _ready() -> void:
	# Load our database of items when the component enters the world
	load_treat()
	load_plant()

# THIS IS THE BRIDGE FUNCTION CALLED BY CUSTOMER.GD
func assign_order_items(character_id: String) -> void:
	# Generate an order specifically for this customer
	var order = create_order(character_id)
	
	# Update the visual labels on your game object
	o_num.text = order.order_num
	c_name.text = order.cust
	p_name.text = order.p_type.name
	
	req_items.text = "\n".join(order.treatmnt.mat)
	
	# Displays how many minutes the player has to complete it
	t_due.text = str(order.time_due) + " min" 
	t_dolla.text = "$%.2f" % order.t_cost

func create_order(customer_name: String) -> Orders:
	var ord = Orders.new()

	ord.order_num = "%03d" % next_id
	next_id += 1

	# NO LONGER RANDOM: Uses the actual spawning customer's name!
	ord.cust = customer_name

	# Keeps the plant and treatment randomized (or you could customize this later!)
	ord.p_type = plants.pick_random()
	ord.treatmnt = treatments.pick_random()
	
	ord.time_due = calc_due_time(ord)
	ord.t_cost = total_amount(ord)
	
	return ord

func total_amount(ord: Orders) -> float:
	var markup = 0.15
	var markup_T = (ord.p_type.cost + ord.treatmnt.cost) * markup
	var total_money = ord.p_type.cost + ord.treatmnt.cost + markup_T
	return total_money
	
func calc_due_time(ord: Orders) -> int:
	var package_time = 5
	var total_time = (ord.p_type.grow_time + ord.treatmnt.proc_time + package_time)
	return total_time

func load_plant():
	var plant_data = [ #is it uniform time, how do we measure the difficulty
		{"name": "Plant A", "time": 20, "cost": 10},
		{"name": "Plant B", "time": 25, "cost": 20},
		{"name": "Plant C", "time": 30, "cost": 30},
		{"name": "Plant D", "time": 45, "cost": 45},
		{"name": "Plant E", "time": 60, "cost": 50}
	]
	for data in plant_data:
		var p = Plant.new()
		p.name = data.name
		p.grow_time = data.time
		p.cost = data.cost
		plants.append(p)
	
func load_treat():
	var treat_data = [
		{"name": "Treatment A", "time": 10, "cost": 5},
		{"name": "Treatment B", "time": 20, "cost": 10},
		{"name": "Treatment C", "time": 30, "cost": 20},
		{"name": "Treatment D", "time": 40, "cost": 50},
		{"name": "Treatment E", "time": 50, "cost": 100}
	]
	for data in treat_data:
		var t = Treat.new()
		t.name = data.name
		t.proc_time = data.time
		t.mat = ["Apply Soil Tonic", "Prune Dead Leaves", "Water Thoroughly"] # Added clean placeholder materials
		t.cost = data.cost
		treatments.append(t)
