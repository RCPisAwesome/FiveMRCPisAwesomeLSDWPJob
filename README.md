# LSDWP Job By RCPisAwesome

## LSDWP Stands for the Los Santos Department of Water and Power
## This is a proof of concept, not a release.
There are insecurities because the server does not get sent any data meaning the client could exploit the giving of the items with no cooldown.

## Screenshots:
<a href="https://www.rcpisawesome.co.uk/dev/FiveMRCPisAwesomeLSDWPJob/1.jpg" target="_blank">**minigame**</a>|<a href="https://www.rcpisawesome.co.uk/dev/FiveMRCPisAwesomeLSDWPJob/2.jpg" target="_blank">**minigame after move mode**</a>|<a href="https://www.rcpisawesome.co.uk/dev/FiveMRCPisAwesomeLSDWPJob/3.jpg" target="_blank">**map markers**</a>|<a href="https://www.rcpisawesome.co.uk/dev/FiveMRCPisAwesomeLSDWPJob/4.jpg" target="_blank">**Vinewood with Vehicle Bays Filled**</a>
:---:|:---:|:---:|:---:
<a href="https://www.rcpisawesome.co.uk/dev/FiveMRCPisAwesomeLSDWPJob/1.jpg" target="_blank"><img alt="FiveMRCPisAwesomeLSDWPJob" src="https://www.rcpisawesome.co.uk/dev/FiveMRCPisAwesomeLSDWPJob/1.jpg"></a>|<a href="https://www.rcpisawesome.co.uk/dev/FiveMRCPisAwesomeLSDWPJob/2.jpg" target="_blank"><img alt="FiveMRCPisAwesomeLSDWPJob" src="https://www.rcpisawesome.co.uk/dev/FiveMRCPisAwesomeLSDWPJob/2.jpg"></a>|<a href="https://www.rcpisawesome.co.uk/dev/FiveMRCPisAwesomeLSDWPJob/3.jpg" target="_blank"><img alt="FiveMRCPisAwesomeLSDWPJob" src="https://www.rcpisawesome.co.uk/dev/FiveMRCPisAwesomeLSDWPJob/3.jpg"></a>|<a href="https://www.rcpisawesome.co.uk/dev/FiveMRCPisAwesomeLSDWPJob/4.jpg" target="_blank"><img alt="FiveMRCPisAwesomeLSDWPJob" src="https://www.rcpisawesome.co.uk/dev/FiveMRCPisAwesomeLSDWPJob/4.jpg"></a>

<a href="https://www.rcpisawesome.co.uk/dev/FiveMRCPisAwesomeLSDWPJob/5.jpg" target="_blank">**Vinewood**</a>|<a href="https://www.rcpisawesome.co.uk/dev/FiveMRCPisAwesomeLSDWPJob/6.jpg" target="_blank">**Zancudo Building**</a>|<a href="https://www.rcpisawesome.co.uk/dev/FiveMRCPisAwesomeLSDWPJob/7.jpg" target="_blank">**Zancudo**</a>|<a href="https://www.rcpisawesome.co.uk/dev/FiveMRCPisAwesomeLSDWPJob/8.jpg" target="_blank">**Rancho**</a>
:---:|:---:|:---:|:---:
<a href="https://www.rcpisawesome.co.uk/dev/FiveMRCPisAwesomeLSDWPJob/5.jpg" target="_blank"><img alt="FiveMRCPisAwesomeLSDWPJob" src="https://www.rcpisawesome.co.uk/dev/FiveMRCPisAwesomeLSDWPJob/5.jpg"></a>|<a href="https://www.rcpisawesome.co.uk/dev/FiveMRCPisAwesomeLSDWPJob/6.jpg" target="_blank"><img alt="FiveMRCPisAwesomeLSDWPJob" src="https://www.rcpisawesome.co.uk/dev/FiveMRCPisAwesomeLSDWPJob/6.jpg"></a>|<a href="https://www.rcpisawesome.co.uk/dev/FiveMRCPisAwesomeLSDWPJob/7.jpg" target="_blank"><img alt="FiveMRCPisAwesomeLSDWPJob" src="https://www.rcpisawesome.co.uk/dev/FiveMRCPisAwesomeLSDWPJob/7.jpg"></a>|<a href="https://www.rcpisawesome.co.uk/dev/FiveMRCPisAwesomeLSDWPJob/8.jpg" target="_blank"><img alt="FiveMRCPisAwesomeLSDWPJob" src="https://www.rcpisawesome.co.uk/dev/FiveMRCPisAwesomeLSDWPJob/8.jpg"></a>

## Walkthrough:
1. The job starts at the Vinewood LSDWP building where you sign on by walking up to the NPC, you are given one of two types of vehicle.
2. You are given a job based on the water type (see table lower down) and then a random job area of that type.
3. You will receive the area on the map, drive to it.
4. Once in the area you will be given a specific spot to head to. For island jobs you also get a jetski to head to the island's area.
5. Stay in the spot to start the minigame, the beginning points value is the defined value in Client.js added to the rounded down distance in kilometers.
6. In the minigame you have to catch the item, the progress bar appears above the item and you have to fill it.
7. During the game the spot may change, the minigame will pause and you will have to head to the new spot to resume it.
8. Each item will add or subtract points and when the points reach 0 the game ends.
9. You then return the jetski to the vehicle, if you had an island job, and return the vehicle to the front of the LSDWP building to complete the job.

## Minigame Controls:
- Hold the left mouse button to accelerate the net upwards.
- Release it to let the net accelerate downwards.
- The net will bounce off the bottom of the pool, the more downward acceration built up, the harder the net will bounce off.
- You can lessen and cancel out the bounce by holding the left mouse button.
- You can use the commands ```/dwppause``` to pause and ```/dwpplay``` to resume the minigame.
- You can also pause using the pause button that is to the right of the points scoreboard.
- Clicking the gear toggles the settings menu.
- In the settings menu there is a toggle for move mode which lets you move the minigame and the notification list around the screen.
- There are also volume sliders for each of the sounds.

## Configuration:
The script by default is a standalone script but it should be very easy to integrate. The spots are marked with comments to replace the sections that need replacing.
- Main loop for signing on replaced by targeting and phone code.
- Inventory item notifications replaced by the giving of the items.
- Replace existing item names in item list in the JavaScript file with the real names, at current they are just guesses.
- Ability to abandon the job.
- Optional:
  - Payment in cash or to the bank for completing the job.
  - Help text notifications replaced by hud text notification system.
  - Crash safety so player's dont lose progress if they disconnect.
  - Compatibility for up to 4 people in group.
  - Some kind of displayable document to show that the employee is in fact working for LSDWP.

## Configuration of Client.js:
- ```raritypercentages```: The percentage chances of getting items of that rarity, totalling 100. Numbers are in order of common to ultra rare.
- ```illegalitypercentages```: The percentage chance of the item of that rarity being an illegal one, the remainder being the legal chance. Numbers are in order of common to ultra rare.
- ```basepointamount```: the number of points at the start of minigame before the distance points are added.
- The net and progress bar are built from classes, their changeable properties are in each class constructor:
  - Net: ```bounceamount``` - The amount of bounce the net changes by each time it hits the bottom.
  - Net: ```accelerationamount``` - The amount the net's acceration added or subtracted while the left mouse button is or isn't held.
  - ProgressBar: ```fillamount``` - The amount the bar fills while the net is over the item.
  - ProgressBar: ```drainamount``` - The amount the bar drain while the net is not over the item.
- Items are first sorted by whether they are illegal or legal and then by their rarity common to ultra rare, in the table they are represented as numbers.
- Each item requires it's name in plural form as the key and a table with a points and an image key defined within it, for example, ```"tests":{"points":1, "image":"testimage"}```.
  - Points is the number subtracted from the total points upon fishing out the item, can be negative to give points too.
  - Image urls can be partial if the prefix is changed.
- An item can also have the additional keys:
  - ```Location``` is the water types in the order they are in the job coords list.
  - ```Givesitem``` is the how you give inventory items to the player, the amount is random between the minimum and maximum.
  - ```Givesmessage``` is the message you want attached to the item, shown in the notification.
  - ```Singular``` by default the singular name takes off the last letter of the name but this overrides that so that it can make sense grammatically. It can also be a negative number to take off that many letters or 0 to not change it from the default plural.
  - ```Annota``` replaces "a" with "an" in the notification when it's a single item.
  - ```Somenota``` replaces "a" with "some" in the notification when it's a single item.
  - ```Overrideamount``` overrides the number shown on the notification which otherwise would use the amount from the numbers in ```Givesitem```.
  - ```Breakimage``` breaks up the image in the notification, this simulates the item being broken down into the items it gives.

## Configuration of Client.lua:
In Client.lua the percentage chances of getting each water type is listed in the percentages table at the top, they match the order the types are in the job coords list.

Default Percentages:
Place|Type|Chance
:---:|:---:|:---:
1|pool|50%
2|water treatment|1%
3|monument|5%
4|fountain|5%
5|pond|5%
6|vespucci canal|1%
7|canal|3%
8|boat dock|1%
9|stream|3%
10|river|3%
11|lake|3%
12|sea|3%
13|marsh|3%
14|beach|5%
15|rocky beach|3%
16|concrete|1%
17|island|5%

## Configuration of Job Coords List.lua:
Job Coords List.lua is a list of all x and y coordinate integers of the vertices of every job area possible and is split into water types. It is best to use the dev tools to show the jobs to add or remove new areas.

## Failure Cases:
It is possible to fail the job by one of the following instances occurring:
- The player dies.
- The vehicle is destroyed or despawned.
- The jetski, if one, is destroyed or despawned.

## Possible Additions/Changes:
- A list of all items showing which ones have been found.
- A list of total amounts of each item found.
- Multiple items in water at once.
- The minigame difficulty scales based on illegality and rarity.

## Other Jobs From LSDWP That Could Be Added:
- Testing water for chemicals.
- Cleaning the water treatment areas more in depth.
- Cleaning water walls like around the southern docks.
- Cleaning water towers.
- Cleaning piers.
- Cleaning the yachts.
- Cleaning empty pools and maybe refilling them.
- Checking on the LSDWP sites and the site on the LS Freeway.
- Electrician job, could tie into the restoring of power to the city.

## Dev Tool Details:
- All dev tools are commands that start with dwp
- Job coords are all done as integers or the for loops take too long.
- Controls are on shown on screen for dwpnoclip and dwpdrawcustomarea
- ```dwpnoclip```: Move options can be switched between once per key press and while pressed depending on whether LMB is held. The ped is aligned to the rounded coordinates.
- ```dwpdrawcustomarea```: Used in with ```dwpnoclip```, this is how to create new jobs to add to Job Coords List.lua.
- ```dwpdrawcustomareacoordslist```: Toggles the list of coordinates on the left side of the screen with using ```dwpdrawcustomarea```.
- ```dwptptojob```: Get to a job quickly using the jobs water type and job number in the order they are in Job Coords List.lua.
- ```dwpdrawjobs```: Displays the vertices of the jobs, can use water type and job number to limit jobs shown.
- ```dwpdrawminmaxarea```: Used with ```dwpdrawjobs```, displays a box showing the minimum and maximum coordinates of displayed jobs.
- ```dwpdrawpointtext```: Used with ```dwpdrawjobs```, displays the coordinates of each vertice of displayed jobs.
- ```dwpdrawjobtext```: Used with ```dwpdrawjobs```, displays the water type and job number of displayed jobs.

## Roleplay Potential:
This job creates a brand new way of players getting rewarded for playing a fun mini game.
It gives the potential to get any items, both illegal and legal.
It also takes the players all over the map in a fun and unique way so they can get familiar with the map.
Players may have to go to pools in private residences that are owned by other players, this would give them the ability to roleplay their job fully by asking to go see their pool and maybe even charge them for the work for a little extra money. Equally the owner could refuse and the employee could try to convince them to agree, there's many avenues the roleplay could turn. They may also encounter other players while on other jobs whom they can also roleplay with.

This job could also be taken one step further by playing a character who runs the LSDWP and would manage the 3 LSDWP sites in Vinewood, Rancho and Zancudo. They would have the duty of assigning jobs to employees instead of it being a fully open job as the job could be very overpowered if farmed, given the items you can potentially receive. Alternatively the items and pay you're able to receive could depend on if you're an allowlisted employee of the LSDWP or not. Some other duties could be getting the vehicles repaired at mechanic shops. This could also allow players to buy and use their own LSWDP vehicles so they could upgrade and personalise them.

On top of all the aforementioned points there is much more potential with the illegal side of this job. Players could sell the items to the manager at a slightly better price than the existing sale spots, commonly referred to as fences. With a little modification to the code, it would be possible to give players specific job locations and receive specific items from them. This would be a good method of distributing and/or selling illegal weapons and items as the job would act as a good cover. To give this some risk, it would alert the police when an NPC sees that there is someone fishing up these items. The player would have to risk fishing up all the items in time before the police show up otherwise the items not fished out will be able to be given to them. This job could also be a way of getting gun part items which then could be sold to the manager to craft them into functioning weapons, without the employees knowing of course. These weapons could be ones that are unique to that crafting spot, which could give a trail for the police if the manager was to be investigated. They could alternatively sell these gun part items to the gun crafters that already exist instead of them using materials but I think it wouldn't hurt for them to have competition. The crafting area could be in an interior linked to a door on any of the 3 LSDWP sites. The job could also be a fun way of getting items that weren't already on the item list, legal or illegal. The manager could be used as a middleman by someone giving items for someone else who is assigned to a specific job where they would fish up those items.
