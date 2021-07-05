local speed = 1.0
local noclip = false
RegisterCommand("dwpnoclip", function()
	noclip = not noclip
	if noclip then
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local x,y,z = math.floor(x) * 1.0, math.floor(y) * 1.0, math.floor(z) * 1.0
		SetEntityCoordsNoOffset(ped,x,y,z, false, false, false)
		FreezeEntityPosition(PlayerPedId(),true)
		local movemode, movemodetext
		CreateThread( function()
			while noclip do 
				Wait(0)
				local ped = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(ped))
				x,y,z = math.floor(x) * 1.0, math.floor(y) * 1.0, math.floor(z) * 1.0
				ClearPedTasksImmediately(ped,false,false)
				SetEntityHeading(ped,180.0)
				if IsControlPressed(0, 24) then -- LMB
					movemode, movemodetext = IsControlPressed, "While Pressed"
					if movemode(0,15) then --Scroll Up
						speed = speed + 1.0
					elseif movemode(0,16) then --Scroll Down
						speed = speed - 1.0
					end
				else
					movemode, movemodetext = IsControlJustPressed, "Once Per Press"
					speed = 1.0
				end
				if speed < 1.0 then
					speed = 1.0
				end
				if movemode(0,32) then --W MoveUpOnly
					SetEntityCoordsNoOffset(ped,x,y+speed,z, false, false, false)
				end
				if movemode(0,33) then --S MoveDownOnly
					SetEntityCoordsNoOffset(ped,x,y-speed,z, false, false, false)
				end
				if movemode(0,34) then --A MoveLeftOnly
					SetEntityCoordsNoOffset(ped,x-speed,y,z, false, false, false)
				end
				if movemode(0,35) then --D MoveRightOnly
					SetEntityCoordsNoOffset(ped,x+speed,y,z, false, false, false)
				end
				if movemode(0,21) then --Shift Sprint
					SetEntityCoordsNoOffset(ped,x,y,z-speed, false, false, false)
				end
				if movemode(0,22) then --Spacebar Jump
					SetEntityCoordsNoOffset(ped,x,y,z+speed, false, false, false)
				end
				DrawRect(0.5, 1.0, 0.5, 0.1, 40, 40, 40, 255)
				DrawText("Speed - " .. speed .. ", Change Movement - Hold LMB, Movement - " .. movemodetext,0.5,0.96)
				DrawText("W/A/S/D - Move, Spacebar - Up, Shift - Down, Scroll Up - Increase Speed 1.0, Scroll Down - Decrease Speed 1.0",0.5,0.98)
			end
		end)
	else
		FreezeEntityPosition(PlayerPedId(),false)
	end
end, false)



local drawcustomareacoordslist = true
local drawcustomarea = false
local customarea = {}
local customareacoordid = 0

RegisterCommand("dwpdrawcustomareacoordslist", function()
	drawcustomareacoordslist = not drawcustomareacoordslist
end, false)
RegisterCommand("dwpdrawcustomarea", function()
	drawcustomarea = not drawcustomarea
	if drawcustomarea then
		customarea = {}
		CreateThread( function()
			while drawcustomarea do
				Wait(0)
				local ped = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(ped))
				DrawLine(x, y, z, x, y, -100.0, 255, 0, 0, 255)
				local x,y,z = math.floor(x), math.floor(y), math.floor(z)

				local numberofpoints = #customarea
				if numberofpoints == 0 then
					customareacoordid = 0
				else
					if IsControlJustPressed(0,10) then --Page Up
						customareacoordid = customareacoordid + 1
						if customareacoordid > numberofpoints then
							customareacoordid = numberofpoints
						end
					elseif IsControlJustPressed(0,11) then --Page Down
						customareacoordid = customareacoordid - 1
						if customareacoordid < 1 then
							customareacoordid = 1
						end
					elseif IsControlPressed(0, 58) then --G - edit selected point id
						local newx, newy = customarea[customareacoordid][1], customarea[customareacoordid][2]
						if IsControlJustPressed(0,174) then --[[arrow left--]] newx = newx - 1 end
						if IsControlJustPressed(0,175) then --[[arrow right--]] newx = newx + 1 end
						if IsControlJustPressed(0,172) then --[[arrow up--]] newy = newy + 1 end
						if IsControlJustPressed(0,173) then --[[arrow down--]] newy = newy - 1 end
						customarea[customareacoordid] = {newx,newy}
					elseif IsControlJustPressed(0, 74) then --H - delete selected point id
						table.remove(customarea, customareacoordid)
						customareacoordid = numberofpoints - 1
					elseif IsControlJustPressed(0, 26) then --C
						local printlist = ""
						for id,coords in ipairs(customarea) do
							printlist = printlist..'{'..coords[1]..','..coords[2]..'}, '
						end
						print(printlist)
					end
				end
				if IsControlJustPressed(0, 23) then --[[F - create coord at position--]]
					customarea[#customarea + 1] = {x,y}
					customareacoordid = #customarea
				end

				if drawcustomareacoordslist then
					local displayx, displayy = 0.05, 0.04
					for id,coords in ipairs(customarea) do
						DrawText(id..": "..coords[1]..", "..coords[2], displayx, displayy)
						DrawRect(displayx, displayy + 0.01, 0.09, 0.02, 40, 40, 40, 255)
						displayy = displayy + 0.02
						if id % 40 == 0 then
							displayx, displayy = displayx + 0.09, 0.04
						end
					end
				end

				DrawRect(0.5, 0.88, 0.5, 0.1, 40, 40, 40, 255)
				DrawText("number of points: ".. tostring(#customarea),0.5,0.84)
				DrawText("selected point id: ".. customareacoordid,0.5,0.86)
				DrawText("F - create point at position | page up/down - change selected point id",0.5,0.88)
				DrawText("G + arrows - change selected point position | H - delete selected point | C - print points list",0.5,0.90)
			end
		end)

		CreateThread(function()
			while drawcustomarea do
				Wait(0)
				local tablelength = #customarea
				if tablelength > 1 then
					for id,coords in ipairs(customarea) do
						local x1,y1,x2,y2
						if id == tablelength then
							x1,y1,x2,y2 = coords[1], coords[2], customarea[1][1], customarea[1][2]
						else
							x1,y1,x2,y2 = coords[1], coords[2], customarea[id+1][1], customarea[id+1][2]
						end
						DrawPolyWall(x1,y1,x2,y2, 0, 180, 0, 180)

						x1,y1,x2,y2 = x1 * 1.0,y1 * 1.0,x2 * 1.0,y2 * 1.0
						local retval, z1 = GetGroundZFor_3dCoord(x1, y1, 500.0, false)
						local retval, z2 = GetGroundZFor_3dCoord(x2, y2, 500.0, false)
						local z = z2 + 40.0
						if z1 > z2 then
							z = z1 + 20.0
						end
						Draw3DText("id: "..id.."|"..x1..", "..y1,x1,y1,x1,y1, 0,0,0,180, z)
						DrawLine(x1,y1, -100.0, x1,y1, 1000.0, 255, 0, 0, 255)
					end
				elseif tablelength == 1 then
					local x1,y1 = customarea[1][1], customarea[1][2]
					DrawLine(x1,y1, -100.0, x1,y1, 1000.0, 255, 0, 0, 255)
				end
			end
		end)
	end
end, false)


RegisterCommand("dwptptojob", function(source, args)
	local zfound, z = false, 0.0
	local watertype, jobnumber = tonumber(args[1]), tonumber(args[2])
	if jobcoordslist[watertype] then
		if jobcoordslist[watertype][jobnumber] then
			local job = jobcoordslist[watertype][jobnumber]
			local xmin, ymin, xmax, ymax, vertices = GetJobCoordDetails(job)
			local x,y = xmin * 1.0, ymin * 1.0
			SetEntityCoordsNoOffset(PlayerPedId(), x,y, 500.0, false, false, false)
			Wait(300)
			while (z == 0.0) do
				zfound, z = GetGroundZFor_3dCoord(x,y, 500.0, false)
				Wait(0)
			end
			SetEntityCoordsNoOffset(PlayerPedId(), x,y, math.ceil(z) + 1.0, false, false, false)
		else
			print("job number doesnt exist", jobnumber)
		end
	else
		print("water type number doesnt exist", watertype)
	end	
end, false)



function DrawText(text,x,y)
	SetTextFont(7)
	SetTextScale(0.35, 0.35)
	SetTextColour(255,255,255,255)--r,g,b,a
	SetTextCentre(true)--true,false
	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(x, y)
end


local drawjobs = false
local drawwalltext = false
local drawarea = false
local drawareatext = false

function DrawPolyWall(x1,y1,x2,y2,r,g,b,a)
	local x1,y1,x2,y2 = x1 * 1.0, y1 * 1.0, x2 * 1.0, y2 * 1.0
	local bottomleft = vector3(x1, y1, -10.0)
	local topleft = vector3(x1, y1, 500.0)
	local bottomright = vector3(x2, y2, -10.0)
	local topright = vector3(x2, y2, 500.0)

	DrawPoly(bottomleft,topleft,bottomright,r,g,b,a)
	DrawPoly(topleft,topright,bottomright,r,g,b,a)
	DrawPoly(bottomright,topright,topleft,r,g,b,a)
	DrawPoly(bottomright,topleft,bottomleft,r,g,b,a)
end

function Draw3DText(text, x1,y1,x2,y2,r,g,b,a,z1)
	local x = ((x1 + x2) / 2) * 1.0
	local y = ((y1 + y2) / 2) * 1.0
	local z = z1 or 200.0
	local onscreen,screenx,screeny = GetScreenCoordFromWorldCoord(x,y,z)
	if onscreen then
		SetTextScale(0.35, 0.35)
		SetTextFont(0)
		SetTextProportional(0)
		SetTextColour(r,g,b,a)
		SetTextCentre(true)--true,false
		BeginTextCommandDisplayText("STRING")
		AddTextComponentSubstringPlayerName(text)
		EndTextCommandDisplayText(screenx,screeny)
	end
end

function RGB(alpha)
	local r,g,b = math.random(0,255),math.random(0,255),math.random(0,255)
	while (r < 100 and g < 100 and b < 100) and (r > 200 and g > 200 and b > 200) do
		Wait(0)
		r,g,b = math.random(0,255),math.random(0,255),math.random(0,255)
	end
	return r,g,b,alpha
end


RegisterCommand("dwpdrawminmaxarea", function()
	drawarea = not drawarea
end, false)
RegisterCommand("dwpdrawpointtext", function()
	drawwalltext = not drawwalltext
end, false)
RegisterCommand("dwpdrawjobtext", function()
	drawareatext = not drawareatext
end, false)


RegisterCommand("dwpdrawjobs", function(source,args)
	local limitwatertype = tonumber(args[1])
	local limitjobnumber = tonumber(args[2])

	if limitwatertype then
		drawjobs = true
		local watertype = jobcoordslist[limitwatertype]
		if watertype then
			if limitjobnumber then
				local job = watertype[limitjobnumber]
				if job then
					DrawJob(job, limitwatertype, limitjobnumber)
				else
					print("job number doesnt exist")
				end
			else
				for jobnumber,job in pairs(watertype) do
					DrawJob(job, limitwatertype, jobnumber)
				end
			end
		else
			print("water type number doesnt exist")
		end
	else
		drawjobs = not drawjobs
		if drawjobs then
			for watertype,coordslist in pairs(jobcoordslist) do
				for jobnumber,job in pairs(coordslist) do
					DrawJob(job, watertype, jobnumber)
				end
			end
		end
	end
end, false)

function DrawJob(job, watertype, jobnumber)
	local xmin, ymin, xmax, ymax, vertices, ispolygon, z = GetJobCoordDetails(job)

	if not ispolygon then
		local x1, y1, x2, y2 = vertices[1], vertices[2], vertices[3], vertices[4]
		local r,g,b,a = RGB(180)
		local r2,g2,b2,a2 = RGB(255)
		local dx1, dy1, dx2, dy2 = x1 * 1.0, y1 * 1.0, x2 * 1.0, y2 * 1.0
		CreateThread(function()
			while drawjobs do
				Wait(0)
				DrawBox(dx1, dy1, 1000.0, dx2, dy2, -100.0, r, g, b, a)
				DrawLine(dx1, dy1, -100.0, dx2, dy2, 1000.0, 255, 0, 0, 255)
				DrawLine(dx1, dy1, -100.0, dx2, dy2, 1000.0, 0, 0, 255, 255)
				if drawwalltext then
					Draw3DText("Box".."\n"..watertype.." | "..jobnumber.."\n"..x1..", "..y1.."\n"..x2..", "..y2, x1, y1, x2, y2,r2,g2,b2,a2)
				end
				if drawareatext then
					Draw3DText("~o~"..watertype.." | "..jobnumber, xmin, ymin, xmax, ymax,0,0,0,255)
				end
				if drawarea then
					DrawBox(xmin * 1.0, ymin * 1.0, 1000.0, xmax * 1.0, ymax * 1.0, -100.0, 0, 0, 0, 180)
				end
			end
		end)
	else
		local tablelength = #job
		local tableoffset = 1
		if job[1]["z"] then
			tableoffset = 2
			tablelength = tablelength - 1
		end
		CreateThread(function()
			while drawjobs do
				Wait(0)
				if drawareatext then
					Draw3DText("~o~"..watertype.." | "..jobnumber, xmin, ymin, xmax, ymax,0,0,0,255)
				end
				if drawarea then
					DrawBox(xmin * 1.0, ymin * 1.0, 1000.0, xmax * 1.0, ymax * 1.0, -100.0, 0, 0, 0, 180)
				end
			end
		end)
		for i=tableoffset, tablelength do
			local x1,y1,x2,y2
			if i == tablelength then
				x1,y1,x2,y2 = job[i][1], job[i][2], job[tableoffset][1], job[tableoffset][2]
			else
				x1,y1,x2,y2 = job[i][1], job[i][2], job[i+1][1], job[i+1][2]
			end
			local r,g,b,a = RGB(180)
			local r2,g2,b2,a2 = RGB(255)
			CreateThread(function()
				while drawjobs do
					Wait(0)
					DrawLine(x1 * 1.0, y1 * 1.0, -100.0, x1 * 1.0, y1 * 1.0, 1000.0, 255, 0, 0, 255)
					DrawPolyWall(x1,y1,x2,y2,r,g,b,a)
					if drawwalltext then
						Draw3DText("PolyWall".."\n"..watertype.." | "..jobnumber.." | "..i.."\n"..x1..", "..y1.."\n"..x2..", "..y2, x1, y1, x2, y2,r2,g2,b2,a2)
					end
				end
			end)
		end
	end
end