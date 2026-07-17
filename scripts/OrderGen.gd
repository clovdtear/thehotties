extends Node2D

static var next_id := 0

@onready var o_num = $"order-text/OrderNumber"
@onready var c_name = $"order-text/CustomerName"
@onready var p_name =  $"order-text/PlantType"
@onready var req_items = $"order-text/SpecialRequests"
@onready var t_due = $"order-text/TimeDue"
@onready var t_dolla = $"order-text/TotalCost"

var names = [
	"Lilith",
	"Margrette",
	"Bartholemu",
	"Sabrina",
	"example_5",
	"example_6",
	"example_7",
	"example_8",
	"example_9",
	"example_10",
	"example_11"
]

var plants: Array[Plant] = []
var treatments: Array[Treat] = []

func load_plant():
	var a = Plant.new()
	a.name = "Plant A"
	a.grow_time = 20
	a.cost = 10
	plants.append(a)
	
	var b = Plant.new()
	b.name = "Plant B"
	b.grow_time = 25
	b.cost = 20
	plants.append(b)
	
	var c = Plant.new()
	c.name = "Plant C"
	c.grow_time = 30
	c.cost = 30
	plants.append(c)
	
	var d = Plant.new()
	d.name = "Plant D"
	d.grow_time = 45
	d.cost = 45
	plants.append(d)
	
	var e = Plant.new()
	e.name = "Plant E"
	e.grow_time = 60
	e.cost = 50
	plants.append(e)
	
func load_treat(): #ammend a cost
	var a = Treat.new()
	a.name = "Treatment A"
	a.proc_time = 10
	a.mat = ["","",""]
	a.cost = 5
	treatments.append(a)
	
	var b = Treat.new()
	b.name = "Treatment B"
	b.proc_time = 20
	b.mat = ["","",""]
	b.cost = 10
	treatments.append(b)
	
	var c = Treat.new()
	c.name = "Treatment C"
	c.proc_time = 30
	c.mat = ["","",""]
	c.cost = 20
	treatments.append(c)
	
	var d = Treat.new()
	d.name = "Treatment D"
	d.proc_time = 40
	d.mat = ["","",""]
	d.cost = 50
	treatments.append(d)
	
	var e = Treat.new()
	e.name = "Treatment E"
	e.proc_time = 50
	e.mat = ["","",""]
	e.cost = 100
	treatments.append(e)
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	print("READY!!!!!!")
	load_treat()
	load_plant()
	
	var order = create_order()
	
	o_num.text = order.order_num
	c_name.text = order.cust
	p_name.text = order.p_type.name
	
	#var add_txt = ""
	
	#for item in order.treatmnt.mat:
	#		add_txt += item + "\n"
	#req_items.text = add_txt #I Need to make this into a loop to loops out contents
	req_items.text = "\n".join(order.treatmnt.mat)
	
	t_due.text = str(order.time_due) + " min" # later I will calculate min based off game clock with formatting function
	
	t_dolla.text = "%.2f" % order.t_cost
	

func create_order() -> Orders:
	var ord = Orders.new()

	ord.order_num = "%03d" % next_id
	next_id += 1

	ord.cust = names.pick_random()

	ord.p_type = plants.pick_random()
	
	ord.treatmnt = treatments.pick_random()
	
	ord.time_due = calc_due_time(ord) #This needs to be depedning on the plantType and Treatment severity
	
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

#func calc_due_time() -> int:
	#var start_time = 8.75 * 60 # opens 8:00 AM what nearest time? (depending on difficulty of treatment?)
	#var end_time = 20 * 60 # 8:00 PM
	
	#return randi_range(start_time,end_time)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
