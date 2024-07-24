const raritypercentages = [50,25,15,8,2]; //percentage chance of getting each job
const illegalitypercentages = [25,25,25,15,3]; //percentage chance of getting an illegal item in that rarity, the other percentage being legal percentage
const basepointamount = 20;
const items = [
  /*illegal*/[
    /*common*/{
      "watches":{"points":1, "singular":-2, "givesitem":{"name":"watch", "min":1, "max":4}, "image":"watch_231a"},
      "2 carat gold chains":{"points":1, "givesitem":{"name":"2 carat gold chain", "min":1, "max":4}, "image":"chains_26d3-fe0f"},
      "5 carat gold chains":{"points":1, "givesitem":{"name":"5 carat gold chain", "min":1, "max":4}, "image":"chains_26d3-fe0f"},
      "8 carat gold chains":{"points":1, "givesitem":{"name":"8 carat gold chain", "min":1, "max":4}, "image":"chains_26d3-fe0f"},
      "teeth":{"points":1, "singular":"tooth", "givesitem":{"name":"human tooth", "min":1, "max":3}, "image":"tooth_1f9b7"},
      "bones":{"points":1, "givesitem":{"name":"human bone", "min":1, "max":4}, "image":"bone_1f9b4"},
      "note rolls":{"points":1, "givesitem":{"name":"roll of notes", "min":2, "max":10}, "image":"dollar-banknote_1f4b5"},
    },
    /*uncommon*/{
      "money bags":{"points":1, "givesitem":{"name":"money bag", "min":1, "max":4}, "image":"money-bag_1f4b0"},
      "10 carat gold chains":{"points":1, "givesitem":{"name":"10 carat gold chain", "min":1, "max":2}, "image":"chains_26d3-fe0f"},

      "oxycotton containers":{"points":1, "annota":true, "givesitem":{"name":"oxy", "min":1, "max":2}, "image":"clutch-bag_1f45d"},
      "oxycotton containers":{"points":1, "annota":true, "givesitem":{"name":"oxy", "min":1, "max":2}, "image":"purse_1f45b"},

      "female weed seeds":{"points":25, "givesitem":{"name":"female weed seed", "min":1, "max":3}, "image":"seedling_1f331"},

      "whales":{"points":5, "location":[8,14,15,16,17], "givesitem":{"name":"whale", "min":1, "max":1}, "image":"whale_1f40b"},
      "dolphins":{"points":5, "location":[8,14,15,16,17], "givesitem":{"name":"dolphin", "min":1, "max":1}, "image":"dolphin_1f42c"},
      "sharks":{"points":5, "location":[8,14,15,16,17], "givesitem":{"name":"shark", "min":1, "max":1}, "image":"shark_1f988"},
      "octopuses":{"points":5, "annota":true, "singular":-2, "location":[8,14,15,16,17], "givesitem":{"name":"octopus", "min":1, "max":1}, "image":"octopus_1f419"},
      "seal":{"points":5, "location":[8,14,15,16,17], "givesitem":{"name":"seal", "min":1, "max":1}, "image":"seal_1f9ad"},
    },
    /*rare*/{
      "note bands":{"points":1, "givesitem":{"name":"band of notes", "min":1, "max":5}, "image":"dollar-banknote_1f4b5"},

      "male weed seeds":{"points":15, "givesitem":{"name":"male weed seed", "min":1, "max":2}, "image":"seedling_1f331"},

      "meth bags":{"points":5, "givesitem":{"name":"2mg meth", "min":1, "max":3}, "image":"clutch-bag_1f45d"},
      "meth bags":{"points":5, "givesitem":{"name":"2mg meth", "min":1, "max":3}, "image":"purse_1f45b"},
    },
    /*veryrare*/{
      "pelts":{"points":5, "location":[9,10,11,12], "givesitem":{"name":"3 star red pelt", "min":1, "max":1}, "image":"deer_1f98c"},

      "cocaine bags":{"points":5, "givesitem":{"name":"2mg coke", "min":1, "max":3}, "image":"clutch-bag_1f45d"},
      "cocaine bags":{"points":5, "givesitem":{"name":"2mg coke", "min":1, "max":3}, "image":"purse_1f45b"},

      "crack cocaine bags":{"points":5, "givesitem":{"name":"2mg crack", "min":1, "max":3}, "image":"clutch-bag_1f45d"},
      "crack cocaine bags":{"points":5, "givesitem":{"name":"2mg crack", "min":1, "max":3}, "image":"purse_1f45b"},

      "green laptops":{"points":25, "givesitem":{"name":"green laptop", "min":1, "max":1}, "image":"laptop_1f4bb"},
    },
    /*ultrarare*/{
      "blue laptops":{"points":25, "givesitem":{"name":"blue laptop", "min":1, "max":1}, "image":"laptop_1f4bb"},
      "red laptops":{"points":25, "givesitem":{"name":"red laptop", "min":1, "max":2}, "image":"laptop_1f4bb"},
    },
  ],
  /*legal*/[
    /*common*/{
      "feathers":{"points":1, "image":"feather_1fab6"},
      "shells":{"points":1, "location":[6,8,12,14,15,16,17], "image":"spiral-shell_1f41a"},
      "newspapers":{"points":1, "image":"newspaper_1f4f0"},
      "rolled up newspapers":{"points":1, "image":"rolled-up-newspaper_1f5de-fe0f"},
      "discs":{"points":1, "image":"optical-disk_1f4bf"},
      "pencils":{"points":1, "image":"pencil_270f-fe0f"},
      "fountain pens":{"points":1, "image":"fountain-pen_1f58b-fe0f"},
      "pens":{"points":1, "image":"pen_1f58a-fe0f"},
      "paintbrushes":{"points":1, "singular":-2, "image":"paintbrush_1f58c-fe0f"},
      "crayons":{"points":1, "image":"crayon_1f58d-fe0f"},
      "briefcases":{"points":1, "image":"briefcase_1f4bc"},
      "plasters":{"points":1, "image":"adhesive-bandage_1fa79"},
      "toilet rolls":{"points":1, "image":"roll-of-paper_1f9fb"},
      "soap bars":{"points":1, "image":"soap_1f9fc"},
      "cigarettes":{"points":1, "image":"cigarette_1f6ac"},

      "footballs":{"points":1, "image":"soccer-ball_26bd"},
      "softballs":{"points":1, "image":"softball_1f94e"},
      "basketballs":{"points":1, "image":"basketball_1f3c0"},
      "volleyballs":{"points":1, "image":"volleyball_1f3d0"},
      "american footballs":{"points":1, "annota":true, "image":"american-football_1f3c8"},
      "rugby balls":{"points":1, "image":"rugby-football_1f3c9"},
      "baseballs":{"points":1, "image":"baseball_26be"},

      "snails":{"points":1, "image":"snail_1f40c"},
      "ants":{"points":1, "annota":true, "image":"ant_1f41c"},
      "cockroaches":{"points":1, "singular":-2, "image":"cockroach_1fab3"},
      "spiders":{"points":1, "image":"spider_1f577-fe0f"},
      "mosquitoes":{"points":1, "singular":-2, "image":"mosquito_1f99f"},
      "flies":{"points":1, "singular":"fly", "image":"fly_1fab0"},

      "butterflys":{"points":1, "image":"butterfly_1f98b"},
      "bugs":{"points":1, "image":"bug_1f41b"},
      "bees":{"points":1, "image":"honeybee_1f41d"},
      "beetles":{"points":1, "image":"beetle_1fab2"},
      "ladybirds":{"points":1, "image":"lady-beetle_1f41e"},
      "crickets":{"points":1, "image":"cricket_1f997"},
      "worms":{"points":1, "image":"worm_1fab1"},

      "cherry flowers":{"points":1, "image":"cherry-blossom_1f338"},
      "white flowers":{"points":1, "image":"white-flower_1f4ae"},
      "rosette flowers":{"points":1, "image":"rosette_1f3f5-fe0f"},
      "rose flowers":{"points":1, "image":"rose_1f339"},
      "dead rose flowers":{"points":1, "image":"wilted-flower_1f940"},
      "hibiscus flowers":{"points":1, "image":"hibiscus_1f33a"},
      "sunflowers":{"points":1, "image":"sunflower_1f33b"},
      "daisy flowers":{"points":1, "image":"blossom_1f33c"},
      "tulip flowers":{"points":1, "image":"tulip_1f337"},
      "leaves":{"points":1, "singular":0, "somenota":true, "image":"herb_1f33f"},
      "clovers":{"points":1, "image":"shamrock_2618-fe0f"},
      "dead leaves":{"points":1, "singular":0, "somenota":true, "image":"fallen-leaf_1f342"},

      "doughnuts":{"points":1, "givesitem":{"name":"donut", "min":1, "max":3}, "image":"doughnut_1f369"},
      "cookies":{"points":1, "givesitem":{"name":"cookie", "min":1, "max":3}, "image":"cookie_1f36a"},
      "hamburgers":{"points":1, "givesitem":{"name":"hamburger", "min":1, "max":3}, "image":"hamburger_1f354"},
      "french fry packs":{"points":1, "givesitem":{"name":"french fries", "min":1, "max":3}, "image":"french-fries_1f35f"},
      "sandwiches":{"points":1, "singular":-2, "givesitem":{"name":"sandwich", "min":1, "max":3}, "image":"sandwich_1f96a"},
      "tacos":{"points":1, "givesitem":{"name":"taco", "min":1, "max":3}, "image":"taco_1f32e"},
      "burritos":{"points":1, "givesitem":{"name":"burrito", "min":1, "max":3}, "image":"burrito_1f32f"},
      "creampies":{"points":1, "givesitem":{"name":"cream pie", "min":1, "max":3}, "image":"pie_1f967"},
      "drinks":{"points":1, "givesitem":{"name":"soft drink", "min":1, "max":3}, "image":"cup-with-straw_1f964"},

      "lollipops":{"points":-5, "givesmessage":"Ooo a piece of candy", "image":"lollipop_1f36d"},
      "candies":{"points":-5, "singular":"candy", "givesmessage":"Ooo a piece of candy", "image":"candy_1f36c"},
    },
    /*uncommon*/{
      "keys":{"points":1, "breakimage":true, "givesitem":{"name":"steel", "min":1, "max":4}, "image":"key_1f511"},
      "old keys":{"points":1, "breakimage":true, "annota":true, "givesitem":{"name":"steel", "min":1, "max":4}, "image":"old-key_1f5dd-fe0f"},
      "wrenches":{"points":1, "breakimage":true, "singular":-2, "givesitem":{"name":"steel", "min":1, "max":4}, "image":"wrench_1f527"},
      "screwdrivers":{"points":1, "breakimage":true, "givesitem":{"name":"steel", "min":1, "max":4}, "image":"screwdriver_1fa9b"},
      "nuts and bolts":{"points":1, "breakimage":true, "singular":"nut and a bolt", "givesitem":{"name":"steel", "min":1, "max":4}, "image":"nut-and-bolt_1f529"},
      "gears":{"points":1, "breakimage":true, "givesitem":{"name":"steel", "min":1, "max":4}, "image":"gear_2699-fe0f"},
      "magnets":{"points":1, "breakimage":true, "givesitem":{"name":"steel", "min":1, "max":4}, "image":"magnet_1f9f2"},
      "safety pins":{"points":1, "breakimage":true, "givesitem":{"name":"steel", "min":1, "max":4}, "image":"safety-pin_1f9f7"},
      "pair of scissors":{"points":1, "breakimage":true, "givesitem":{"name":"steel", "min":1, "max":4}, "image":"scissors_2702-fe0f"},
      "padlocks":{"points":1, "breakimage":true, "givesitem":{"name":"steel", "min":1, "max":4}, "image":"locked_1f512"},
      "unlocked padlocks":{"points":1, "breakimage":true, "annota":true, "givesitem":{"name":"steel", "min":1, "max":4}, "image":"unlocked_1f513"},
      "padlocks and keys":{"points":1, "breakimage":true, "singular":"padlock and key", "givesitem":{"name":"steel", "min":1, "max":4}, "image":"locked-with-key_1f510"},

      "cans":{"points":1, "breakimage":true, "givesitem":{"name":"aluminium", "min":1, "max":4}, "image":"canned-food_1f96b"},
      "scooters":{"points":1, "breakimage":true, "overrideamount":{"min":1, "max":1}, "givesitem":{"name":"aluminium", "min":3, "max":6}, "image":"kick-scooter_1f6f4"},
      "trolleys":{"points":1, "breakimage":true, "overrideamount":{"min":1, "max":1}, "givesitem":{"name":"aluminium", "min":3, "max":6}, "image":"shopping-cart_1f6d2"},
      "canes":{"points":1, "breakimage":true, "overrideamount":{"min":1, "max":1}, "givesitem":{"name":"aluminium", "min":3, "max":5}, "image":"white-cane_1f9af"},
      "rubbish bins":{"points":1, "breakimage":true, "overrideamount":{"min":1, "max":1}, "givesitem":{"name":"aluminium", "min":3, "max":5}, "image":"wastebasket_1f5d1-fe0f"},
      "badminton rackets":{"points":1, "breakimage":true, "givesitem":{"name":"aluminium", "min":1, "max":4}, "image":"badminton_1f3f8"},
      "tennis rackets":{"points":1, "breakimage":true, "givesitem":{"name":"aluminium", "min":1, "max":4}, "image":"tennis_1f3be"},

      "saxophones":{"points":1, "breakimage":true, "overrideamount":{"min":1, "max":1}, "givesitem":{"name":"copper", "min":2, "max":5}, "image":"saxophone_1f3b7"},
      "trumpets":{"points":1, "breakimage":true, "overrideamount":{"min":1, "max":1}, "givesitem":{"name":"copper", "min":2, "max":5}, "image":"trumpet_1f3ba"},
      "horns":{"points":1, "breakimage":true, "overrideamount":{"min":1, "max":1}, "givesitem":{"name":"copper", "min":2, "max":5}, "image":"postal-horn_1f4ef"},

      "thermometers":{"points":1, "breakimage":true, "givesitem":{"name":"glass", "min":1, "max":1}, "image":"thermometer_1f321-fe0f"},
      "light bulbs":{"points":1, "breakimage":true, "givesitem":{"name":"glass", "min":1, "max":1}, "image":"light-bulb_1f4a1"},
      "magnifying glasses":{"points":1, "breakimage":true, "singular":-2, "givesitem":{"name":"glass", "min":1, "max":1}, "image":"magnifying-glass-tilted-left_1f50d"},

      "cameras":{"points":1, "breakimage":true, "givesitem":{"name":"electronics", "min":1, "max":4}, "image":"camera_1f4f7"},
      "pagers":{"points":1, "breakimage":true, "givesitem":{"name":"electronics", "min":1, "max":2}, "image":"pager_1f4df"},
      "headphones":{"points":1, "breakimage":true, "singular":0, "somenota":true, "givesitem":{"name":"electronics", "min":1, "max":1}, "image":"headphone_1f3a7"},
      "flashlights":{"points":1, "breakimage":true, "givesitem":{"name":"electronics", "min":1, "max":1}, "image":"flashlight_1f526"},
      "cables":{"points":1, "givesitem":{"name":"electronics", "min":1, "max":1}, "image":"electric-plug_1f50c"},
      "speaker radios":{"points":1, "breakimage":true, "givesitem":{"name":"electronics", "min":1, "max":4}, "image":"radio_1f4fb"},

      "plungers":{"points":1, "breakimage":true, "givesitem":{"name":"rubber", "min":1, "max":1}, "image":"plunger_1faa0"},
      "balloons":{"points":1, "givesitem":{"name":"rubber", "min":1, "max":4}, "image":"balloon_1f388"},
      "table tennis bats":{"points":1, "breakimage":true, "givesitem":{"name":"rubber", "min":1, "max":2}, "image":"ping-pong_1f3d3"},

      "razors":{"points":1, "breakimage":true, "givesitem":{"name":"plastic", "min":1, "max":4}, "image":"razor_1fa92"},
      "lotion bottles":{"points":1, "breakimage":true, "givesitem":{"name":"plastic", "min":1, "max":4}, "image":"lotion-bottle_1f9f4"},
      "toothbrushes":{"points":1, "breakimage":true, "singular":-2, "givesitem":{"name":"plastic", "min":1, "max":4}, "image":"toothbrush_1faa5"},

      "glasses":{"points":1, "singular":0, "somenota":true, "givesitem":{"name":"glasses", "min":1, "max":1}, "image":"glasses_1f453"},
      "sunglasses":{"points":1, "singular":0, "somenota":true, "givesitem":{"name":"glasses", "min":1, "max":1}, "image":"sunglasses_1f576-fe0f"},
      "trainers":{"points":1, "givesitem":{"name":"shoes", "min":1, "max":1}, "image":"running-shoe_1f45f"},
      "boots":{"points":1, "givesitem":{"name":"shoes", "min":1, "max":1}, "image":"hiking-boot_1f97e"},
      "masks":{"points":1, "givesitem":{"name":"mask", "min":1, "max":1}, "image":"goggles_1f97d"},
      "hats":{"points":1, "givesitem":{"name":"hat", "min":1, "max":1}, "image":"billed-cap_1f9e2"},
      "diving masks":{"points":1, "givesitem":{"name":"mask", "min":1, "max":1}, "image":"diving-mask_1f93f"},

      "phones":{"points":1, "givesitem":{"name":"phone", "min":1, "max":3}, "image":"mobile-phone_1f4f1"},
      "receipts":{"points":1, "givesitem":{"name":"receipt", "min":1, "max":5}, "image":"receipt_1f9fe"},
    },
    /*rare*/{
      "umbrellas":{"points":1, "annota":true, "givesitem":{"name":"umbrella", "min":1, "max":1}, "image":"closed-umbrella_1f302"},
      "umbrellas":{"points":1, "annota":true, "givesitem":{"name":"umbrella", "min":1, "max":1}, "image":"umbrella_2602-fe0f"},

      "flower bouquets":{"points":1, "givesitem":{"name":"bouquet", "min":1, "max":1}, "image":"bouquet_1f490"},

      "pelts":{"points":5, "location":[9,10,11,12], "givesitem":{"name":"3 star pelt", "min":1, "max":2}, "image":"deer_1f98c"},

      "fish":{"points":1, "location":[5,10,12,14,15,16,17], "givesitem":{"name":"fish", "min":1, "max":5}, "image":"fish_1f41f"},
      "tropical fish":{"points":1, "location":[14,15,16,17], "givesitem":{"name":"fish", "min":1, "max":5}, "image":"tropical-fish_1f420"},
      "crabs":{"points":1, "location":[14,15,16,17],"image":"crab_1f980"},
      "lobsters":{"points":1, "location":[14,15,16,17],"image":"lobster_1f99e"},
      "prawns":{"points":1, "location":[14,15,16,17],"image":"shrimp_1f990"},
      "squids":{"points":1, "location":[14,15,16,17],"image":"squid_1f991"},

      "recyclable materials":{"points":1, "givesitem":{"name":"recycled materials", "min":15, "max":40}, "image":"recycling-symbol_267b-fe0f"},

      "fortune cookies":{"points":-10, "givesmessage":"If you work enough, you will find something of great worth", "image":"fortune-cookie_1f960"},
    },
    /*veryrare*/{
      "pufferfish":{"points":-2, "location":[14,15,16,17], "givesitem":{"name":"fish", "min":1, "max":10}, "image":"blowfish_1f421"},
      "four leaf clovers":{"points":-13, "givesmessage":"Maybe Anto Murphy was here", "image":"four-leaf-clover_1f340"},

      "tickets":{"points":1, "givesitem":{"name":"raffleticket", "min":1, "max":4}, "image":"admission-tickets_1f39f-fe0f"},
      "tickets":{"points":1, "givesitem":{"name":"raffleticket", "min":1, "max":4}, "image":"ticket_1f3ab"},

      "gemstones":{"points":1, "givesitem":{"name":"gemstone", "min":1, "max":3},"image":"gem-stone_1f48e"},
    },
    /*ultrarare*/{
      "rings":{"points":15, "givesitem":{"name":"ring", "min":1, "max":1},"image":"ring_1f48d"},

      "mapleleaves":{"points":-15, "singular":"mapleleaf", "givesmessage":"Maybe Doug Canada was here", "image":"maple-leaf_1f341"},
      "salt bottles":{"points":-15, "givesmessage":"If Found Please Return Me To Redd Ditt", "image":"salt_1f9c2"},
      "police cars":{"points":-15, "givesmessage":"Ziggy must've been driving", "image":"police-car_1f693"},
      "taxis":{"points":-15, "givesmessage":"Abdul needs to work on his driving", "image":"taxi_1f695"},
      "mopeds":{"points":-15, "givesmessage":"Hope this didn't belong to Andi Jones", "image":"motor-scooter_1f6f5"},
      "bicycles":{"points":-15, "givesmessage":"Did Bogg drown?", "image":"bicycle_1f6b2"},
      "helicopters":{"points":-15, "givesmessage":"Snow must've been flying", "image":"helicopter_1f681"},
      "ufos":{"points":-15, "givesmessage":"If Found Please DON'T Return to Ford Zancudo, we'll have you deported", "image":"flying-saucer_1f6f8"},
      "clocks":{"points":-15, "givesmessage":"Wake up. You're in a dream. This world is all in your head.", "image":"alarm-clock_23f0"},
      "waters":{"points":-15, "somenota":true, "givesmessage":"you caught water... good job I guess?", "image":"water-wave_1f30a"},
      "magic 8 balls":{"points":-15, "givesmessage":"Whatever question you asked, the answer is dissappointing", "image":"pool-8-ball_1f3b1"},
      "dice":{"points":-15, "singular":"die", "givesmessage":"Did Roland Nelson drown?", "image":"game-die_1f3b2"},
      "teddy bears":{"points":-15, "givesmessage":"This isn't the Teddy Four Tee is looking for", "image":"teddy-bear_1f9f8"},
      "controllers":{"points":-15, "givesmessage":"Eddie must've lost this, he can use it to steer his car", "image":"video-game_1f3ae"},
      "puzzle pieces":{"points":-15, "givesmessage":"Your puzzle is complete, but what puzzle?", "image":"puzzle-piece_1f9e9"},
      "chess pawns":{"points":-15, "givesmessage":"You caught yourself?", "image":"chess-pawn_265f-fe0f"},
      "joker cards":{"points":-15, "givesmessage":"Jack must've been here", "image":"joker_1f0cf"},
      "sandals":{"points":-15, "givesmessage":"Dundee must've been here", "image":"thong-sandal_1fa74"},
      "balls of yarn":{"points":-15, "singular":"ball of yarn", "givesmessage":"Meowfurryon must've been here", "image":"yarn_1f9f6"},
      "olives":{"points":-15, "singular":0, "somenota":true, "givesmessage":"These Olives are from Olive Garden, Vinny must've been here", "image":"olive_1fad2"},
      "scarfs":{"points":-15, "givesmessage":"Yuno must've been here", "image":"scarf_1f9e3"},
      "boomerangs":{"points":-15, "givesmessage":"Eugene Zuckerberg must've been here. I've heard he would throw it himself and then throw it himself and then throw it himself", "image":"boomerang_1fa83"},
      "motorcycles":{"points":-15, "givesmessage":"Probably Rudi Rinsen's bike", "image":"motorcycle_1f3cd-fe0f"},
      "tractors":{"points":-15, "givesmessage":"Probably Judd's tractor", "image":"tractor_1f69c"},
      "small aeroplanes":{"points":-15, "givesmessage":"Bryce must've been flying", "image":"small-airplane_1f6e9-fe0f"},
      "aeroplanes":{"points":-15, "annota":true, "givesmessage":"Tony must've been flying", "image":"airplane_2708-fe0f"},

      "pet rocks":{"points":15, "givesitem":{"name":"pet rock", "min":1, "max":1}, "image":"rock_1faa8"},
      "pet chickens":{"points":15, "givesitem":{"name":"pet chicken", "min":1, "max":1}, "image":"rooster_1f413"},
      "pet turtles":{"points":15, "givesitem":{"name":"pet turtle", "min":1, "max":1}, "image":"turtle_1f422"},

      "popcorn boxes":{"points":-15, "singular":-2, "givesitem":{"name":"popcorn", "min":1, "max":1},"givesmessage":"Must be some drama happening somewhere", "image":"popcorn_1f37f"},
      "wheelchairs":{"points":25, "givesitem":{"name":"wheelchair", "min":1, "max":1}, "givesmessage":"Did Igor drown?", "image":"manual-wheelchair_1f9bd"},
      "frisbees":{"points":25, "givesitem":{"name":"frisbee", "min":1, "max":1},"givesmessage":"Maybe Eugene Zuckerberg will buy this? I've heard he would throw it to Edna and she would throw it back to him", "image":"flying-disc_1f94f"},
    },
  ]
];

var raritypercentagesindexed = [];
for (let percentage = 0; percentage < raritypercentages.length; percentage++){
  for (let percent = 0; percent < raritypercentages[percentage]; percent++){
    raritypercentagesindexed.push(percentage);
  }
}

var playgame = false;
(function(){
  class Net {
    constructor(){
      this.net = document.getElementById("net");
      this.height = this.net.clientHeight;
      this.maxy = game.clientHeight * -1 + 100; //80 is px height of net + 20 for outline and padding
      this.miny = 0;
      this.y = Math.random() * -300;
      this.bounce = 0;
      this.acceleration = 0;

      this.bounceamount = 0.8;
      this.accelerationamount = 0.02;
    }
    reset(){
      this.y = Math.random() * -300;
      this.bounce = 0;
      this.acceleration = 0;
    }
    update(){
      this.bounce += this.acceleration;
      this.y += this.bounce;
      net.acceleration = 0;
      if (this.y > this.miny){
        this.y = 0;
        this.bounce *= this.bounceamount;
        this.bounce *= -1 * this.bounceamount;
      }
      if (net.y < this.maxy){
        net.y = this.maxy;
        net.bounce = 0;
      }else{
        if (mouseclicked){
          this.acceleration -= this.accelerationamount;
        }else{
          this.acceleration += this.accelerationamount;
        }
      }
      this.net.style.transform = "translateY("+this.y+"px)";

      var nety = this.y, netheight = this.height, itemy = item.y, itemheight = item.height;
      if (((itemy < nety) && (itemy > nety - netheight)) || ((itemy - itemheight) < nety && (itemy - itemheight) > (nety - netheight))){
        progressbar.fill();
      }else{
        progressbar.drain();
      }
    }
  }
  class Item {
    constructor(){
      this.item = document.getElementById("item");
      this.height = this.item.clientHeight;
      this.y = Math.ceil(Math.random() * (game.clientHeight - this.height)) * -1;
      this.movey = null;
      this.movetime = null;
    }
    reset(){
      this.y = Math.ceil(Math.random() * (game.clientHeight - this.height)) * -1;
      this.movey = null;
      this.movetime = null;
    }
    update(){
      if (!this.movey || this.movetime < 0){
        var movey = Math.ceil(Math.random() * (game.clientHeight - this.height)) * -1;
        this.movey = movey;
        var movetime = Math.abs(this.y - movey);
        this.movetime = movetime;
        var randomspeed = Math.random() + Math.random();
        while (randomspeed < 0.4){
          randomspeed = Math.random() + Math.random();
        }
        this.speed = randomspeed;
      };
      if (this.movey < this.y){
        this.y -= this.speed;
      }else{
        this.y += this.speed;
      }
      this.item.style.transform = "translateY("+this.y+"px)";
      this.movetime -= this.speed;
    }
  }
  class ProgressBar {
    constructor(){
      this.progress = 0;
      this.progressvalue = document.getElementById("progress");
      this.progressbar = document.querySelector("#progressbar span");
      //data storage for returning item
      this.name = null;
      this.legality = null;
      this.rarity = null;
      this.location = null;

      this.fillamount = 0.5;
      this.drainamount = 0.2;
    }
    reset(){
      this.progress = 0;
      $("#progressbar").css("animation", "hidethis 0.1s ease-out forwards");
    }
    drain(){
      if (this.progress > 0){
        this.progress -= this.drainamount;
        audioprogressdown.play();
      }
      if (this.progress < 0){
        this.progress = 0;
        $("#progressbar").css("animation", "hidethis 0.2s ease-out forwards");
      } 

    }
    fill(){
      $("#progressbar").css("animation", "showthis 0.2s ease-in forwards");
      if (this.progress < 100) this.progress += this.fillamount;
      if (this.progress >= 100){
        audiosuccess.play();
        endGame();
      }else{
        audioprogressup.play();
      }
    }
    update(){
      this.progressvalue.innerHTML = Math.round(this.progress);
      this.progressbar.style.width = this.progress+"%";
    }
  }

  class Notification {
    constructor(autoclosetime, closable){
      this.autoclosetime = autoclosetime;
      this.closable = closable;
    }
    add(html, closehtml, callback = null){
      var html = html || "";

      var notificationlist = document.querySelector("#notificationlist"),
      notificationbox = document.createElement("div"),
      notification = document.createElement("div");

      if (typeof html == "object"){
        notification.appendChild(html);
      }else{
        notification.innerHTML = html;
      }

      notificationbox.classList.add("notificationbox");
      notificationbox.appendChild(notification);

      if (this.closable){
        var notificationclose = document.createElement("div"), closehtml = closehtml || "<p>close</p>";
        notificationclose.classList.add("notificationclose");
        notificationclose.innerHTML = closehtml;
        if (closehtml.length > 0) notification.classList.add("notificationmargin");

        notificationclose.addEventListener("click", (event) => {
          event.preventDefault();
          if (notificationbox.classList.contains("notificationhide")) return;
          this.hide(notificationbox, callback);
        });
        notificationbox.appendChild(notificationclose);
      }

      notificationlist.appendChild(notificationbox);

      notificationbox.setAttribute("data", this.autoclosetime);
      if (this.autoclosetime > 0){
        this.msgboxTimeout = setTimeout(() => {
          this.hide(notificationbox, callback);
        }, this.autoclosetime);
      }

      while (notificationlist.getBoundingClientRect().bottom > window.innerHeight){
        var children = notificationlist.childNodes, removefirst = true;
        for (var i = 0; i < children.length; i++){
          if (children[i].getAttribute("data") != 0){
            children[i].remove();
            removefirst = false;
            break;
          }
        }
        if (removefirst) children[0].remove();
      }
    }

    hide(notificationbox, callback){
      if (notificationbox !== null) notificationbox.classList.add("notificationhide"); // If the Message Box is not yet closed
      notificationbox.addEventListener("transitionend", () => {
        if (notificationbox !== null) {
          notificationbox.remove();
          clearTimeout(this.msgboxTimeout);
          if (callback !== null) callback(); // If the callback parameter is not null
        }
      });
    }
  }

  const itemimg = document.getElementById("itemimg");
  function newItem(forcelegality, forcerarity){
    var legality = 1, raritychance = Math.floor(Math.random() * 100), legalitychance = Math.floor(Math.random() * 100);
    var rarity = raritypercentagesindexed[raritychance];
    if (legalitychance <= illegalitypercentages[rarity]) legality = 0;

    if (forcelegality != null) legality = forcelegality;
    if (forcerarity != null) rarity = forcerarity;

    var itemlist = items[legality][rarity];
    var itemnamesfromlist = Object.keys(itemlist);
    var numofitems = itemnamesfromlist.length -1;//-1 because indexing starts at 0
    var randomitem = Math.floor(Math.random() * numofitems);
    var newitemname = itemnamesfromlist[randomitem];
    var newitem = itemlist[newitemname];
    var doesnewitemhave = Object.keys(newitem);
    var allowedlocation = true;
    if (doesnewitemhave.includes("location")){
      if (!((newitem["location"]).includes(item.location))){
        newItem(legality, rarity);
        allowedlocation = false;
      }
      //if item list has no items without a specified location or a matching location this would loop forever
    }
    if (allowedlocation){
      var url = newitem["image"];
      if (url.includes(".")){
        itemimg.src = url;
      }else{
        //URL can be changed here to add a prefix and suffix
        itemimg.src = "" + url + ".png";
      }
        
      item.name = newitemname;
      item.legality = legality;
      item.rarity = rarity;
    }
  }


  // Game
  const game = document.getElementById("pool");
  let mouseclicked = false;

  const net = new Net();
  const progressbar = new ProgressBar();
  const item = new Item();

  const audioprogressup = new Audio("./audio/progressup.wav");
  audioprogressup.volume = 0.1;
  const audioprogressdown = new Audio("./audio/progressdown.wav");
  audioprogressdown.volume = 0.1;
  const audiosuccess = new Audio("./audio/success.wav");
  audiosuccess.volume = 0.1;

  var holdtime = 0, clicktime = 0, movemode = false, settings = false;
  $('input[type="number"]').each(function() {
    $('<button class="inputdown">&#8722;</button><button class="inputup">&#43;</button>').insertAfter(this);
  });

  $(".slider").on("input propertychange change click",function(){
    var value = $(this).val(), parent = $(this).parent().attr("id");
    $(this).prev().prev().prev().val(value);
    eval("audio"+parent+".volume = "+(parseInt(value)/100));
  });
  $(".sliderinput").on("input keydown change",function(){
    $(this).next().next().next().val($(this).val()).click();
  });
  $(".inputdown, .inputup").mousedown(function(){ 
    holdtime = setTimeout(function(buttoninput){
      clicktime = setInterval(function(buttoninput){
        $(buttoninput).click();
      }, 100, buttoninput);
    }, 1000, this);
  }).bind("mouseup mouseleave", function(){
    clearTimeout(holdtime);
    clearInterval(clicktime);
  });
  $(".inputdown").click(function(){
    var p = $(this).prev(), s = parseFloat(p.attr("step")), v = parseFloat(p.val()), min = parseFloat(p.attr("min")), nv = v-s;
    if (min > nv) nv = min;
    p.val(nv).trigger("change");
  });
  $(".inputup").click(function(){
    var p = $(this).prev().prev(), s = parseFloat(p.attr("step")), v = parseFloat(p.val()), max = parseFloat(p.attr("max")), nv = v+s;
    if (max < nv) nv = max;
    p.val(nv).trigger("change");
  });

  $("#movemode").click(function(){
    movemode = !movemode;
    if (movemode){
      $(this).css({"background-color": "rgb(0, 255, 0)"});
      $("#minigame, #notificationlist").draggable({disabled: false, cancel:false, scroll: false, containment: "window"});
      $("body").css({"user-select": "all"});
    }else{
      $(this).css({"background-color": "rgb(255, 0, 0)"});
      $("#minigame, #notificationlist").draggable({disabled: true});
      $("body").css({"user-select": "none"});
    }
  });

  $("#pause").click(function(){
    $.post(window.ResourceName + "pausegame");
    playgame = false;
    $("#notificationlist").empty();
    $("#minigame").css("animation", "hidethis 0.5s ease-out forwards");
  });

  $("#settingsicon").click(function(){
    settings = !settings;
    if (settings){
      $("#settings").css("animation", "showthis 0.5s ease-in forwards");
    }else{
      $("#settings").css("animation", "hidethis 0.5s ease-out forwards");
    }
  });

  const notificationlist = document.getElementById("notificationlist");
  function displayNotification(html, itemimagesrc, breakitemimage){
    var notification = document.createElement("div");
    notification.innerHTML = html;

    if (itemimagesrc){
      var image = new Image();
      image.src = itemimagesrc;
      image.onload = function(){
        if (breakitemimage){
          var container = document.createElement("div");
          container.appendChild(image);
          container.setAttribute("data", true);
          container.classList.add("breakitemimagecontainer");

          notification.appendChild(container);
        }else{
          notification.appendChild(image);
        }
      };
    }
    new Notification(8000, false).add(notification);
  }

  function endGame(){
    playgame = false;
    var itemname = item.name;
    var newitem = items[item.legality][item.rarity][itemname];
    var doesnewitemhave = Object.keys(newitem), breakitemimage, newitemnotification = "you caught ", newitemgivesitemquantity = 1;

    if (doesnewitemhave.includes("givesitem")){
      var newitemgivesitemname = newitem["givesitem"]["name"], min = newitem["givesitem"]["min"], max = newitem["givesitem"]["max"];
      newitemgivesitemquantity = Math.floor(Math.random() * (max - min + 1)) + min;

      $.post((window.ResourceName + "givesitem"), JSON.stringify({
        givesitem: newitemgivesitemname,
        givesitemquantity: newitemgivesitemquantity
      }));

      if (doesnewitemhave.includes("overrideamount")){
        min = newitem["overrideamount"]["min"];
        max = newitem["overrideamount"]["max"];
        newitemgivesitemquantity = Math.floor(Math.random() * (max - min + 1)) + min;
      }
    }
    if (newitemgivesitemquantity == 1){
      var newitemprefix = "a ";
      if (doesnewitemhave.includes("annota")){
        newitemprefix = "an ";
      }else if (doesnewitemhave.includes("somenota")){
        newitemprefix = "some ";
      }
      if (doesnewitemhave.includes("singular")){
        var singular = newitem["singular"];
        if (Number.isInteger(singular)){
          newitemnotification += newitemprefix + itemname.substring(0, itemname.length + singular);
        }else{
          newitemnotification += newitemprefix + singular;
        }
      }else{
        newitemnotification += newitemprefix + itemname.substring(0, itemname.length -1);
      }
    }else{
        newitemnotification += newitemgivesitemquantity + " " + itemname;
    }

    if (doesnewitemhave.includes("breakimage")) breakitemimage = true;

    var pointmessage;
    var totalpoints = parseInt($("#points").text());
    if (doesnewitemhave.includes("points")){
      var itempoints = parseInt(newitem["points"]);
      if (itempoints < 0) pointmessage = "I'm feeling lucky, I'm going to clean more";
      totalpoints -= (itempoints * newitemgivesitemquantity);
    }

    var itemimgsrc = itemimg.src;
    setTimeout(()=>{
      displayNotification("<h1>"+ newitemnotification +"!</h1>", itemimgsrc, breakitemimage);

      if (doesnewitemhave.includes("givesmessage")) displayNotification("<p>The item has a note attached to it:</p><h1>"+ newitem["givesmessage"] +"</h1>");
      if (pointmessage) displayNotification("<p>"+ pointmessage +"!</p>");
    }, 500);

    itemimg.src = "";
    if (totalpoints <= 0){
      $.post(window.ResourceName + "endgame");
      $("#minigame").css("animation", "hidethis 1s ease-out forwards");
      setTimeout(()=>{
        displayNotification("<h1>Water Is All Clean!</h1>"+
          '<img src="https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/google/274/test-tube_1f9ea.png" alt="">'+
          '<img src="https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/google/274/petri-dish_1f9eb.png" alt="">');
      }, 500);
      playgame = false;
      mouseclicked = false;
    }else{
      $("#points").text(totalpoints);
      newItem();
      resetGame();
      playgame = true;
    }
  }

  function resetGame(){
    progressbar.reset();
    item.reset();
    net.reset();
  }

  function runGame(){
    if (playgame){
      net.update();
      progressbar.update();
      item.update();
    }
    requestAnimationFrame(runGame);
  }

  runGame();

  window.addEventListener("mousedown", function(){
    if (!mouseclicked) mouseclicked = true;
  });
  window.addEventListener("mouseup", function(){
    if (mouseclicked) mouseclicked = false;
  });
  window.addEventListener("message", function(event){
    if (event.data.resourcename){
      window.ResourceName = "https://" + event.data.resourcename + "/";
    }
    if (event.data.location){
      $("#points").text(basepointamount + event.data.distance);
      item.location = event.data.location;
      newItem();
      resetGame();
      mouseclicked = false;
      $("#minigame").css("animation", "showthis 0.5s ease-in forwards");
      playgame = true;
    }
    if (event.data.paused){
      mouseclicked = false;
      if (event.data.paused == "true"){
        playgame = false;
        $("#notificationlist").empty();
        $("#minigame").css("animation", "hidethis 0.5s ease-out forwards");
      }else{
        playgame = true;
        $("#minigame").css("animation", "showthis 0.5s ease-in forwards");
      }
    }
  });
})();

// Bubbles
(function(){
  let bubbles = {};
  let bubblesCreated = 0;
  const canvas = document.getElementById("bubbles");
  canvas.width = canvas.clientWidth * 2;
  canvas.height = canvas.clientHeight * 2;
  const context = canvas.getContext("2d");

  function animatedBubbles(){
    if (playgame){
      context.clearRect(0, 0, canvas.width, canvas.height); //clears canvas
      Object.keys(bubbles).forEach(bubble => bubbles[bubble].draw());
    }
    requestAnimationFrame(animatedBubbles);
  }
  class Bubble {
    constructor() {
      this.index = Object.keys(bubbles).length;
      this.radius = Math.random() * (6 - 2) + 2;
      this.y = canvas.height + this.radius;
      this.x = canvas.width * Math.random() - this.radius;
      this.sin = this.style > 0.5 ? 0 : 5;
      this.style = Math.random();
      this.childAdded = false;
      this.speed = 1;
      this.sway = Math.random() * (0.03 - 0.01) + 0.01;
      this.swayDistance = Math.random() * (canvas.width - canvas.width / 2) + canvas.width / 2;
    }
    draw(){
      context.beginPath();
      context.strokeStyle = "#e6f7ff";
      context.lineWidth = 4;
      context.arc(this.x + this.radius, this.y + this.radius, this.radius, 0, 2 * Math.PI);
      context.stroke();
      this.x = Math.sin(this.sin) * this.swayDistance + this.swayDistance - this.radius;
      this.sin += this.sway;
      this.y -= this.speed;
      if (this.y + this.radius < 0) delete bubbles[this.index];
      if (this.y < canvas.height * Math.random()){
        if (!this.childAdded){
          bubbles[bubblesCreated] = new Bubble();
          bubblesCreated++;
          this.childAdded = true;
        }
      }
    }
  }
  bubbles[bubblesCreated] = new Bubble();
  bubblesCreated++;
  animatedBubbles();
})();

(function(){
  var image = new Image();
  function animatedImage(){
    var containers = document.getElementsByClassName("breakitemimagecontainer");
    for (var i = 0; i < containers.length; i++){
      if (containers[i].getAttribute("data")){
        var triangulated = triangulate(120, 60);//image size, half size (center)
        playing = shatter(triangulated[0],triangulated[1], containers[i], 60);//vertices, indices, container, half size (center)
      }
    }
    requestAnimationFrame(animatedImage);
  }

  function triangulate(size, halfsize){
    var vertices = [];
    var rings = [50, 150, 300, 1200];
    var count = 10;
    vertices.push([halfsize, halfsize]);
    rings.forEach(function(radius){
      var variance = radius * 0.25;
      for (var i = 0; i < count; i++){
        var x = Math.cos((i / count) * (Math.PI * 2)) * radius + halfsize + randomRange(-variance, variance);
        var y = Math.sin((i / count) * (Math.PI * 2)) * radius + halfsize + randomRange(-variance, variance);
        vertices.push([x, y]);
      }
    });
    vertices.forEach(function(v){
      var xv = v[0], yv = v[1];
      v[0] = xv < 0 ? 0 : (xv > size ? size : xv);
      v[1] = yv < 0 ? 0 : (yv > size ? size : yv);
    });
    return [vertices, triangulateVertices(vertices)];
  }

  function triangulateVertices(vertices){
    var epsilon = 1.0 / 1048576.0;
    var n = vertices.length, i, j, indices, st, open, closed, edges, dx, dy, a, b, c;
    vertices = vertices.slice();
    indices = new Array(n); //vertex array sorted by x-position
    for (i = n; i--;) indices[i] = i;
    indices.sort(function(i, j){
      return vertices[j][0] - vertices[i][0];
    });
    st = supertriangle(vertices);
    vertices.push(st[0], st[1], st[2]);
    open = [circumcircle(vertices, n, n + 1, n + 2, epsilon)];
    closed = [];
    edges = [];
    for (i = indices.length; i--; edges.length = 0){
      c = indices[i];
      for (j = open.length; j--;){
       dx = vertices[c][0] - open[j].x;
       if (dx > 0.0 && dx * dx > open[j].r){
        closed.push(open[j]);
        open.splice(j, 1);
        continue;
      }
      dy = vertices[c][1] - open[j].y;
      if (dx * dx + dy * dy - open[j].r > epsilon) continue;
      edges.push(open[j].i, open[j].j, open[j].j, open[j].k, open[j].k, open[j].i);
      open.splice(j, 1);
    }

    dedup(edges);
    
    for (j = edges.length; j; ){
      b = edges[--j];
      a = edges[--j];
      open.push(circumcircle(vertices, a, b, c, epsilon));
    }
  }
  for (i = open.length; i--;) closed.push(open[i]);
  open.length = 0;
  for (i = closed.length; i--; ) if (closed[i].i < n && closed[i].j < n && closed[i].k < n) open.push(closed[i].i, closed[i].j, closed[i].k);
  return open;
}

function dedup(edges){
  var i, j, a, b, m, n;
  for (j = edges.length; j;){
    b = edges[--j];
    a = edges[--j];
    for (i = j; i;){
      n = edges[--i];
      m = edges[--i];
      if ((a === m && b === n) || (a === n && b === m)){
        edges.splice(j, 2);
        edges.splice(i, 2);
        break;
      }
    }
  }
}

function supertriangle(vertices){
  var xmin = Number.POSITIVE_INFINITY, ymin = Number.POSITIVE_INFINITY, xmax = Number.NEGATIVE_INFINITY, ymax = Number.NEGATIVE_INFINITY,
  i, dx, dy, dmax, xmid, ymid;
  for (i = vertices.length; i--;){
    if(vertices[i][0] < xmin) xmin = vertices[i][0];
    if(vertices[i][0] > xmax) xmax = vertices[i][0];
    if(vertices[i][1] < ymin) ymin = vertices[i][1];
    if(vertices[i][1] > ymax) ymax = vertices[i][1];
  }
  dx = xmax - xmin;
  dy = ymax - ymin;
  dmax = Math.max(dx, dy);
  xmid = xmin + dx * 0.5;
  ymid = ymin + dy * 0.5;
  return [[xmid - 20 * dmax, ymid - dmax], [xmid, ymid + 20 * dmax], [xmid + 20 * dmax, ymid - dmax]];
}

function circumcircle(vertices, i, j, k, epsilon){
  var x1 = vertices[i][0], y1 = vertices[i][1], x2 = vertices[j][0], y2 = vertices[j][1], x3 = vertices[k][0], y3 = vertices[k][1],
  fabsy1y2 = Math.abs(y1 - y2), fabsy2y3 = Math.abs(y2 - y3),
  xc, yc;
  if(fabsy1y2 < epsilon && fabsy2y3 < epsilon) throw new Error("Coincident points!");
  if(fabsy1y2 < epsilon) {
    var m2  = -((x3 - x2) / (y3 - y2)), mx2 = (x2 + x3) / 2.0, my2 = (y2 + y3) / 2.0;
    xc  = (x2 + x1) / 2.0;
    yc  = m2 * (xc - mx2) + my2;
  }else if(fabsy2y3 < epsilon) {
    var m1  = -((x2 - x1) / (y2 - y1)), mx1 = (x1 + x2) / 2.0, my1 = (y1 + y2) / 2.0;
    xc  = (x3 + x2) / 2.0;
    yc  = m1 * (xc - mx1) + my1;
  }else{
    var m1  = -((x2 - x1) / (y2 - y1)), m2  = -((x3 - x2) / (y3 - y2)), 
    mx1 = (x1 + x2) / 2.0, mx2 = (x2 + x3) / 2.0, my1 = (y1 + y2) / 2.0, my2 = (y2 + y3) / 2.0;
    xc  = (m1 * mx1 - m2 * mx2 + my2 - my1) / (m1 - m2);
    yc  = (fabsy1y2 > fabsy2y3) ? m1 * (xc - mx1) + my1 : m2 * (xc - mx2) + my2;
  }
  var dx = x2 - xc, dy = y2 - yc;
  return {i: i, j: j, k: k, x: xc, y: yc, r: dx * dx + dy * dy};
}

function randomRange(min, max) {
  return min + (max - min) * Math.random();
}

function shatter(vertices, indices, container, halfsize){
  setTimeout(()=>{
    var fragments = [];
    image.src = container.firstElementChild.src;
    image.onload = function(){
      for (var i = 0; i < indices.length; i += 3){
        var x1 = vertices[indices[i]][0], y1 = vertices[indices[i]][1],
        x2 = vertices[indices[i + 1]][0], y2 = vertices[indices[i + 1]][1],
        x3 = vertices[indices[i + 2]][0], y3 = vertices[indices[i + 2]][1];
        var fragment = new Fragment(x1,y1,x2,y2,x3,y3);
        container.appendChild(fragment.canvas);
        fragments.push(fragment);
      }
      container.removeChild(container.firstElementChild);
      container.removeAttribute("data");
      setTimeout(()=>{
        fragments.forEach(function(fragment){
          var x = fragment.x, y = fragment.y;
          var posx = false, posy = false;
          if (x > halfsize) posx = true;
          if (y > halfsize) posy = true;
          var newx, newy;
          if (posx){
            newx = x + randomRange(0, 20.0);
          }else{
            newx = x - randomRange(0, 20.0);
          }
          if (posy){
            newy = y + randomRange(0, 20.0);
          }else{
            newy = y - randomRange(0, 20.0);
          }
          var speedx = Math.abs(x - newx), speedy = Math.abs(y - newy);
          var greatest = speedx > speedy ? speedx : speedy;
          var speedmodifier = randomRange(0.001,0.006);
          var speed = greatest/speedmodifier;
          $(fragment.canvas).animate({left: newx, top: newy}, speed);
        });
      }, 300);
    }
  }, 1000);
}

class Fragment {
  constructor(x1,y1,x2,y2,x3,y3){
    var minx = Math.min(x1, x2, x3), maxx = Math.max(x1, x2, x3), miny = Math.min(y1, y2, y3), maxy = Math.max(y1, y2, y3);
    var boxw = maxx - minx, boxh = maxy - miny;
    var x = minx, y = miny;
    this.x = x;
    this.y = y;

    this.canvas = document.createElement("canvas");
    this.canvas.width = boxw;
    this.canvas.height = boxh;
    this.canvas.style.width = boxw + "px";
    this.canvas.style.height = boxh + "px";
    this.canvas.style.left = x + "px";
    this.canvas.style.top = y + "px";

    this.ctx = this.canvas.getContext("2d");
    this.ctx.translate(-x, -y);
    this.ctx.beginPath();
    this.ctx.moveTo(x1, y1);
    this.ctx.lineTo(x2, y2);
    this.ctx.lineTo(x3, y3);
    this.ctx.closePath();
    this.ctx.clip();
    this.ctx.drawImage(image, 0, 0);
  }
}
  animatedImage();
})();
