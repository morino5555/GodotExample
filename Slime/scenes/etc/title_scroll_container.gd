extends ScrollContainer

@onready var title_discription: RichTextLabel = $TitleDiscription

func _ready() -> void:
	title_discription.text = "むかし、むかし、あるところに、おじいさんとおばあさんがありました。\n" \
	+ "まいにち、おじいさんは山へしば刈かりに、おばあさんは川へ洗濯に行きました。\n" \
	+ "　ある日、おばあさんが、川のそばで、せっせと洗濯をしていますと、川上から、大きな桃が一つ、\n" \
	+ "「ドンブラコッコ、スッコッコ。\n" \
	+ "ドンブラコッコ、スッコッコ。」\n" \
	+ "と流ながれて来きました。"
