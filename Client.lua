local r = math.random
local ped = PlayerPedId()
local inminigame, minigamepaused, minigamewaspaused, signedon, jobfailed, phonetext, helptext, firstsignon

local percentages = {50,1,5,5,5,1,3,1,3,3,3,3,3,5,3,1,5} -- percentages of getting each water type in order of job coords list
local percentage = {}

CreateThread(function()
	for watertype, percent in ipairs(percentages) do
		for i = 1, percent, 1 do
			table.insert(percentage, watertype)
		end
	end
	while not NetworkIsPlayerActive(PlayerId()) do
        Wait(0)
    end
    Wait(1000)
	local jx, jy, jz = 735.5, 130.5, 79.71
	local jobped = CreateJobPed(jx, jy, jz)
	local jobblip = CreateStartBlip(jx, jy)
    SendNUIMessage({resourcename = GetCurrentResourceName()})
	--CODE NEEDED HERE: USING EYE TO SEE THE PED AND LET THEM SIGN INTO JOB
	--THIS NEXT CODE IS IN PLACE OF THE PHONE/JOB FUNCTIONALITY
	--------------------------------------------------
	while true do
		Wait(0)
		ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		if not signedon and Vdist(x,y,z,jx,jy,jz) < 2.5 then
			signedon = true
			jobfailed, helptext = false, false

			CreateThread(function()
				while signedon do
					Wait(0)
					if helptext then
						DrawText(helptext, 0.8, 0.06)
						local length = #helptext
						DrawRect(0.8, 0.07, (length / 100) - (length / 250), 0.03, 40, 40, 40, 255)
					end
				end
			end)
			
			phonetext = "Fetching Vehicle"
			CreateThread(function()
				while phonetext do
					Wait(0)
					DrawText(phonetext,0.9,0.81)
					DrawRect(0.9, 0.9, 0.14, 0.2, 40, 40, 40, 255)
				end
			end)
			if not firstsignon then
				CreateCommands()
				firstsignon = true
			end
			if not Job() then
				phonetext = false
				helptext = "Job Failure: " .. jobfailed
				Wait(5000)
				helptext = false
				signedon = false
			end
		end
	end
	--------------------------------------------------
end)

function Job(jx, jy, jz)
	local jobwatertype = percentage[r(1, 100)]
	local jobs = jobcoordslist[jobwatertype]
	local jobnumber = r(1, #jobs)
	local job = jobs[jobnumber]
	print("job water type, job number", jobwatertype, jobnumber)

	local jetskineeded = jobwatertype == 17 and true or false -- island
	local vehicle, jetski = SpawnVehicle(jetskineeded)
	local vehiclespawnlocationx, vehiclespawnlocationy, vehiclespawnlocationz = table.unpack(GetEntityCoords(vehicle))

	helptext = "signed onto job"
	CreateThread(function()
		Wait(3000)
		helptext = false
	end)

	CreateThread(function()
		while signedon do
			Wait(1000)
			ped = PlayerPedId()
			if IsEntityDead(ped) then
				jobfailed = "we don't compensate for that"
			end
			if DoesEntityExist(vehicle) then
				if not IsVehicleDriveable(vehicle, false) then
					jobfailed = "you destroyed the vehicle"
				end
			else
				jobfailed = "you lost the vehicle"
			end
			if jetski then
				if DoesEntityExist(jetski) then
					if not IsVehicleDriveable(jetski, false) then
						jobfailed = "you destroyed the jetski"
					end
				else
					jobfailed = "you lost the jetski"
				end
			end
		end
	end)

	phonetext = "Get In Your Vehicle"
	while not IsPedInVehicle(ped, vehicle, false) do
		Wait(0)
		if jobfailed then
			return false
		end
	end
	--CODE NEEDED HERE: GIVE KEYS OF VEHICLE TO PLAYER AND/OR RENTAL DOCUMENTS

	phonetext = "Drive to the Job Area"
	local xmin, ymin, xmax, ymax, vertices, ispolygon, jobzheight = GetJobCoordDetails(job)

	local areaoffset = 30.0
	if jetski then
		areaoffset = 230.0
	end
	local areaxmin, areaymin, areaxmax, areaymax = xmin - areaoffset, ymin - areaoffset, xmax + areaoffset, ymax + areaoffset

	local blip, blipx, blipy, blipradius = CreateJobBlip(areaxmin, areaymin, areaxmax, areaymax)

	while not IsEntityInCircle(vehicle, blipx, blipy, blipradius) do
		Wait(0)
		if jobfailed then
			RemoveJobBlip(blip)
			return false
		end
	end

	if jetski then
		helptext = "Reverse To The Water's Edge"
		local jetskicoords
		while not jetskicoords do
			Wait(0)
			if jobfailed then
				return false
			end
			local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(vehicle,0.0,-7.0,0.0))
			local iswaterhere, waterheight = TestVerticalProbeAgainstAllWater(x, y, z, 0)
			if iswaterhere then
				local raycast = StartExpensiveSynchronousShapeTestLosProbe(x, y, z, x, y, -100.0, 1, 0, 4)
				local _, _, endcoords, _, _ = GetShapeTestResult(raycast)
				local endx,endy,endz = table.unpack(endcoords)
				if (endx ~= 0.0 and endy ~= 0.0 and endz ~= 0.0) then
					if waterheight > endz then
						local inrange = waterheight - endz
						if inrange > 0.7 then
							if (GetVehicleDoorAngleRatio(vehicle,2) > 0.5) and (GetVehicleDoorAngleRatio(vehicle,3) > 0.5) then
								jetskicoords = vector3(x, y, z)
							else
								helptext = "Open the back doors"
							end
						else
							helptext = "Reverse To The Water's Edge"
						end
					end
				end
			end
		end
		DetachEntity(jetski, true, true)
		SetEntityCoordsNoOffset(jetski, jetskicoords, false, false, false)
		helptext = "Jetski to the Job Area"

		areaoffset = 10.0
		areaxmin, areaymin, areaxmax, areaymax = xmin - areaoffset, ymin - areaoffset, xmax + areaoffset, ymax + areaoffset

		RemoveJobBlip(blip)
		blip, blipx, blipy, blipradius = CreateJobBlip(areaxmin, areaymin, areaxmax, areaymax)

		while not IsEntityInCircle(jetski, blipx, blipy, blipradius) do
			Wait(0)
			if jobfailed then
				RemoveJobBlip(blip)
				return false
			end
		end
		helptext = false
	end

	phonetext = "Await More Details"
	local joblist, jobcount, spotreturncount = {}, 0, 0
	while jobcount == 0 do
		joblist, jobcount = GetJobSpots(xmin, ymin, xmax, ymax, vertices, ispolygon, jobzheight)
		if jobfailed then
			return false
		end
		if ispolygon and (10 > jobcount) then
			if spotreturncount > 0 and spotreturncount < 2 then
				joblist, jobcount, spotreturncount = {}, 0, 0
				helptext = "The system is being slow, stay in the area"
			end
			Wait(3000)
		end
		spotreturncount = spotreturncount + 1
		Wait(0)
	end

	RemoveJobBlip(blip)

	helptext = false
	local currentjobspot = r(1, jobcount)
	local jobx, joby, jobz, originalx, originaly = table.unpack(joblist[currentjobspot])

	phonetext = "Head to the Job Spot"
	
	if jobfailed or (not StartJobSpot(jobx, joby, jobz, originalx, originaly, ped)) then
		return false
	end
	GetAndSetHeading(xmin, ymin, xmax, ymax, vertices, ispolygon, jobzheight, ped)
	if jobfailed then
		return false
	end
	phonetext = "Get This Water Cleaned Up"
	SetNuiFocus(true, true)

	local distance = math.floor(Vdist(jobx, joby, jobz, jx, jy, jz) / 1000)
	SendNUIMessage({location = jobwatertype, distance = distance})

	inminigame, minigamepaused, minigamewaspaused = true, false, false

	local skimmer, animdict, skimmerhash = GetSkimmingAnimation(ped)
	local scene, animationtime = PlaySkimmingAnimation(skimmer, animdict, ped)
	local animationtimeelapsed = 0
	while inminigame do
		local weapon = GetCurrentPedWeaponEntityIndex(ped)
		SetEntityVisible(weapon, false, 0)
		if jobfailed then
			Wait(1000)
			SetEntityVisible(weapon, true, 0)
			inminigame = false
			SetNuiFocus(false, false)
			SendNUIMessage({paused = "true"})
			StopSkimmingAnimation(scene)
			SetEntityVisible(weapon, true, 0)
			SetModelAsNoLongerNeeded(skimmerhash)
			skimmer = DeleteObject(skimmer)
			RemoveAnimDict(animdict)
			return false
		end
		Wait(1000)
		animationtimeelapsed = animationtimeelapsed + 1000
		if animationtimeelapsed >= animationtime then
			StopSkimmingAnimation(scene)
			scene, animationtime = PlaySkimmingAnimation(skimmer, animdict, ped)
			animationtimeelapsed = 0
		end

		if minigamepaused then
			StopSkimmingAnimation(scene)
			Wait(1000)
			SetEntityVisible(weapon, true, 0)
			PauseOrPlay(true)
			SetEntityVelocity(skimmer, 0.0,0.0,0.0)
			while minigamepaused do
				Wait(1000)
			end
			minigamewaspaused = true
		end
		if minigamewaspaused then
			StopSkimmingAnimation(scene)
			if not StartJobSpot(jobx, joby, jobz, originalx, originaly, ped) then
				return false
			end
			animationtimeelapsed = 0
			scene, animationtime = PlaySkimmingAnimation(skimmer, animdict, ped)
			PauseOrPlay(false)
			minigamewaspaused = false
		end
		

		local coordsvalid
		if originalx then
			coordsvalid = AreCoordsValidForJob(originalx, originaly, jobzheight)
		else
			coordsvalid = AreCoordsValidForJob(jobx, joby, jobzheight)
		end
		if not coordsvalid then
			PauseOrPlay(true)
		end

		local previousjobspot, prevtonext = 0
		while not coordsvalid do
			Wait(0)
			if jobfailed then
				PauseOrPlay(false)
				return false
			end

			if previousjobspot <= 10 then
				previousjobspot = previousjobspot + 1
				currentjobspot = currentjobspot - 1
			else
				if not prevtonext then
					prevtonext = true
					currentjobspot = currentjobspot + 11
				else
					currentjobspot = currentjobspot + 1
				end
			end

			if (jobcount < currentjobspot) or (1 > currentjobspot) then
				previousjobspot, prevtonext = 0
				currentjobspot = r(1, jobcount)
			end

			jobx, joby, jobz, originalx, originaly = table.unpack(joblist[currentjobspot])
			if originalx then
				coordsvalid = AreCoordsValidForJob(originalx, originaly, jobzheight)
			else
				coordsvalid = AreCoordsValidForJob(jobx, joby, jobzheight)
			end

			if coordsvalid then
				StopSkimmingAnimation(scene)
				if not StartJobSpot(jobx, joby, jobz, originalx, originaly, ped) then
					return false
				end
				animationtimeelapsed = 0
				scene, animationtime = PlaySkimmingAnimation(skimmer, animdict, ped)
				PauseOrPlay(false)
			end
		end
	end
	Wait(1000)
	local weapon = GetCurrentPedWeaponEntityIndex(ped)
	SetEntityVisible(weapon, true, 0)
	SetModelAsNoLongerNeeded(skimmerhash)
	skimmer = DeleteObject(skimmer)
	RemoveAnimDict(animdict)

	phonetext = "Return Your Vehicle"
	
	if jetski then
		helptext = "Return Your Jetski To Your Vehicle"
		local jetskiinplace
		while not jetskiinplace do
			if jobfailed then
				return false
			end
			Wait(0)
			local vx,vy,vz = table.unpack(GetOffsetFromEntityInWorldCoords(vehicle,0.0,-5.0,0.0))
			local jx,jy,jz = table.unpack(GetEntityCoords(jetski))
			DrawMarker(27, vx,vy,vz, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, 180, 180, 255, 255, false, false, 2, true, nil, nil, false)

			if (GetVehicleDoorAngleRatio(vehicle, 2) > 0.5) and (GetVehicleDoorAngleRatio(vehicle, 3) > 0.5) then
				helptext = "Return Your Jetski To Your Vehicle"
				if Vdist(vx,vy,vz, jx,jy,jz) < 1.5 then
					jetskiinplace = true
				end
			else
				helptext = "Open the back doors"
			end
		end
		helptext = false
		for seatindex=-1,0 do
			local vehicleped = GetPedInVehicleSeat(jetski, seatindex)
			if vehicleped ~= 0 then
				TaskLeaveVehicle(vehicleped, jetski, 0)
			end
		end
		SetVehicleDoorsLocked(jetski,7)
		SetVehicleDoorsLockedForAllPlayers(jetski, true)

		Wait(2000)
		local heading = GetEntityHeading(vehicle)
		SetEntityHeading(jetski, heading)
		AttachEntityToEntity(jetski, vehicle, 0, 0.0, -1.5, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
	end
	
	blip = CreateJobBlip(vehiclespawnlocationx - 4, vehiclespawnlocationy - 4, vehiclespawnlocationx + 4, vehiclespawnlocationy + 4)

	local vx,vy,vz = table.unpack(GetEntityCoords(vehicle))
	while Vdist(vehiclespawnlocationx, vehiclespawnlocationy, vehiclespawnlocationz, vx, vy, vz) > 4.0 do
		if jobfailed then
			RemoveJobBlip(blip)
			return false
		end
		vx,vy,vz = table.unpack(GetEntityCoords(vehicle))
		Wait(0)
		DrawMarker(27, vehiclespawnlocationx, vehiclespawnlocationy, vehiclespawnlocationz, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 4.0, 180, 180, 255, 255, false, false, 2, true, nil, nil, false)
	end

	for seatindex=-1,2 do
		local vehicleped = GetPedInVehicleSeat(vehicle, seatindex)
		if vehicleped ~= 0 then
			TaskLeaveVehicle(vehicleped, vehicle, 0)
		end
	end
	SetVehicleDoorsLocked(vehicle,7)
	SetVehicleDoorsLockedForAllPlayers(vehicle, true)

	RemoveJobBlip(blip)

	if jobfailed then
		return false
	end

	phonetext = "Returning Your Vehicle"
	Wait(3000)
	if jetski then
		jetski = DeleteVehicle(jetski)
	end
	vehicle = DeleteVehicle(vehicle)

	--CODE NEEDED HERE: JOB COMPLETED
	phonetext = "Job Completed"
	Wait(5000)
	phonetext = false
	signedon = false
	return true
end

function StartJobSpot(jobx, joby, jobz, originalx, originaly, ped)
	local blip = CreateJobBlip(jobx - 2.5, joby - 2.5, jobx + 2.5, joby + 2.5)
	local px,py,pz = 0.0, 0.0, 0.0
	local distance = Vdist(jobx, joby, jobz, px, py, pz)
	local waiting = 0
	while distance > 2.5 do
		helptext = "Head to the New Job Spot"
		Wait(0)
		if jobfailed then
			RemoveJobBlip(blip)
			return false
		end
		px,py,pz = table.unpack(GetEntityCoords(ped))
		if Vdist(jobx, joby, jobz, px, py, pz) < 2.5 then
			helptext = false
			if IsPedInAnyVehicle(ped, true) then
				helptext = "You can't be in a vehicle"
				px,py,pz = 0.0, 0.0, 0.0
			elseif not IsPedStopped(ped) then
				helptext = "try to stand still"
				waiting = waiting + 1
				if waiting > 1000 then -- about 13 seconds
					helptext = false
				else
					px,py,pz = 0.0, 0.0, 0.0
				end
			else
				helptext = false
			end
		else
			helptext = false
			waiting = 0
		end
		distance = Vdist(jobx, joby, jobz, px, py, pz)

		if originalx then
			DrawMarker(27, jobx, joby, jobz + 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.5, 2.5, 2.5, 180, 180, 255, 255, false, false, 2, true, nil, nil, false)
		else
			local iswaterhere, waterheight = TestVerticalProbeAgainstAllWater(jobx, joby, jobz + 2.0, 0)
			DrawMarker(27, jobx, joby, waterheight + 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.5, 2.5, 2.5, 180, 180, 255, 255, false, false, 2, true, nil, nil, false)
		end
	end
	RemoveJobBlip(blip)
	return true
end

function GetAndSetHeading(xmin, ymin, xmax, ymax, vertices, ispolygon, z, ped)
	local z = (z or 1000) * 1.0
	local px,py,pz = table.unpack(GetEntityCoords(ped))

	local headingx, headingy

	if ispolygon then
		local dx, dy = xmax*1.0 - px, ymax*1.0 - py
		local distancemax = math.sqrt(dx * dx + dy * dy)
		for i=1, #vertices, 2 do
			local x, y = vertices[i], vertices[i+1]
			local iswaterhere, waterheight = TestVerticalProbeAgainstAllWater(x*1.0, y*1.0, z*1.0, 0)
			if iswaterhere then
				local dx, dy = x - px, y - py
				local distance = math.sqrt(dx * dx + dy * dy)
				if distance < distancemax then
					distancemax = distance
					headingx, headingy = x,y
				end
			end
		end
	end

	local offsets = {vector3(0.0, 2.0, 0.0), vector3(0.0, -2.0, 0.0), vector3(-2.0, 0.0, 0.0), vector3(2.0, 0.0, 0.0)}
	for k,offset in ipairs(offsets) do
		local offsetcoords = GetOffsetFromEntityInWorldCoords(ped, offset)
		local x,y = table.unpack(offsetcoords)
		local iswaterhere, waterheight = TestVerticalProbeAgainstAllWater(x,y,z, 0)
		if iswaterhere then
			local raycast = StartExpensiveSynchronousShapeTestLosProbe(x, y, z, x, y, -100.0, 1, 0, 4)
			local _, _, endcoords, _, _ = GetShapeTestResult(raycast)
			local endx,endy,endz = table.unpack(endcoords)
			if not (endx == 0.0 and endy == 0.0 and endz == 0.0) then
				if waterheight > endz then
					local inrange = waterheight - endz
					if inrange > 1.1 then
						headingx, headingy = x, y
					end
				end
			end
		end
	end

	if not headingx then
		headingx, headingy = ((xmin + xmax) / 2) * 1.0, ((ymin + ymax) / 2) * 1.0 -- Center
	end

	local heading = GetHeadingFromVector_2d(headingx - px, headingy - py)
	local reachedheading, waiting = false, 0
	while not reachedheading do
		Wait(0)
		if jobfailed then
			return false
		end
		SetPedDesiredHeading(ped, heading)
		local currentheading = GetEntityHeading(ped)
		if currentheading >= (heading - 0.2) and currentheading <= (heading + 0.2) then
			reachedheading = true
		else
			waiting = waiting + 1
			if waiting > 600 then -- about 8 seconds
				SetEntityHeading(ped, heading)
				reachedheading = true
			end
		end
	end
end

function GetJobCoordDetails(job)
	local xmin, ymin, xmax, ymax
	local vertices = {}
	local z = 1000.0
	local tablelength = #job
	local ispolygon
	if tablelength == 2 or tablelength == 3 then
		ispolygon = false
		local tableoffset = 1
		local hasz = job[1]["z"]
		if hasz then
			z = hasz
			tableoffset = 2
		end
		local x1, y1, x2, y2 = job[tableoffset][1], job[tableoffset][2], job[tableoffset+1][1], job[tableoffset+1][2]
		if y1 < y2 then ymin, ymax = y1, y2 else ymin, ymax = y2, y1 end
		if x1 < x2 then xmin, xmax = x1, x2 else xmin, xmax = x2, x1 end
		vertices[1], vertices[2], vertices[3], vertices[4] = xmin, ymin, xmax, ymax
	elseif tablelength >= 4 then
		ispolygon = true
		local tableoffset = 1
		local hasz = job[1]["z"]
		if hasz then
			z = hasz
			tableoffset = 2
			tablelength = tablelength - 1
		end
		xmin, ymin, xmax, ymax = job[tableoffset][1], job[tableoffset][2], job[tablelength][1], job[tablelength][2]
		local min, max = math.min, math.max
		for i=tableoffset, tablelength do
			local x, y = job[i][1], job[i][2]
			table.insert(vertices, x)
			table.insert(vertices, y)
			xmin, ymin, xmax, ymax = min(x,xmin), min(y,ymin), max(x,xmax), max(y,ymax)
		end
	end
	return xmin, ymin, xmax, ymax, vertices, ispolygon, z * 1.0
end


function GetJobSpots(xmin, ymin, xmax, ymax, vertices, ispolygon, z)
	local z = z or 1000
	local xmin, ymin, xmax, ymax = xmin, ymin, xmax, ymax
	local x, y
	local jobcount = 0
	local joblist = {}
	
	for y = ymin, ymax do
		if ispolygon then
			local edges = GetEdgesOnY(xmin, xmax, y, vertices)
			if edges then
				local edgeslowtohigh = {}
				for edge,edgecoords in ipairs(edges) do
					local edgex = math.floor(edgecoords[1])
					table.insert(edgeslowtohigh, edgex)
				end
				if #edgeslowtohigh > 0 then
					table.sort(edgeslowtohigh)
					local edgeminmaxs, saveorinsert, savedx = {}, false
					for i=1, #edgeslowtohigh do
						saveorinsert = not saveorinsert
						local edgex = edgeslowtohigh[i]
						if saveorinsert then
							savedx = edgex
						else
							table.insert(edgeminmaxs, {savedx, edgex})
						end
					end
					for edge,xminmax in ipairs(edgeminmaxs) do
						local edgexmin, edgexmax = xminmax[1], xminmax[2] + 3
						for x = edgexmin, edgexmax do
							local jobfound, jobx, joby, jobz, originalx, originaly = AreCoordsValidForJob(x * 1.0, y * 1.0, z * 1.0)
							if jobfound then
								jobcount = jobcount + 1
								joblist[jobcount] = {jobx, joby, jobz, originalx, originaly}
							end
						end
					end
				end
			end
		else
			for x = xmin, xmax do
				local jobfound, jobx, joby, jobz, originalx, originaly = AreCoordsValidForJob(x * 1.0, y * 1.0, z * 1.0)
				if jobfound then
					jobcount = jobcount + 1
					joblist[jobcount] = {jobx, joby, jobz, originalx, originaly}
				end
			end
		end
	end
	--print("total jobcount", jobcount)
	drawthisjob = false
	return joblist, jobcount
end

function AreCoordsValidForJob(x, y, z)
	local iswaterhere, waterheight = TestVerticalProbeAgainstAllWater(x, y, z, 0)
	if iswaterhere then
		local raycast = StartExpensiveSynchronousShapeTestLosProbe(x, y, z, x, y, -100.0, 1, 0, 4)
		local _, _, endcoords, _, _ = GetShapeTestResult(raycast)
		if endcoords ~= vector3(0.0, 0.0, 0.0) then
			local endz = endcoords.z
			if waterheight > endz then
				local inrange = waterheight - endz
				if (inrange >= -1.0) and (inrange <= 1.0) then
					return true, x, y, endz
				elseif inrange > 1.0 then
					local offsets = {vector2(0.0, 1.0), vector2(0.0, -1.0), vector2(-1.0, 0.0), vector2(1.0, 0.0)}
					for k,offset in ipairs(offsets) do
						local ox,oy = table.unpack(offset + vector2(x, y))
						local iswaterhere, waterheight = TestVerticalProbeAgainstAllWater(ox,oy,z, 0)
						if not iswaterhere then
							local raycast = StartExpensiveSynchronousShapeTestLosProbe(ox, oy, z, ox, oy, -100.0, 1, 0, 4)
							local _, _, endcoords, _, _ = GetShapeTestResult(raycast)
							if endcoords ~= vector3(0.0, 0.0, 0.0) then
								return true, ox, oy, endcoords.z, x, y
							end
						end
					end
				end
			end
		end
	end
	return false
end

function CreateCommands()
	RegisterCommand("dwppause", function()
		if signedon and inminigame then
			print("dwppause")
			minigamepaused = true
		else
			print("You need to be at the minigame stage of the job to do that")
		end
	end, false)
	RegisterCommand("dwpplay", function()
		if signedon and inminigame then
			print("dwpplay")
			minigamepaused = false
		else
			print("You need to be at the minigame stage of the job to do that")
		end
	end, false)
end

function PauseOrPlay(pause)
	local notp = not pause
	SetNuiFocus(notp, notp)
	if pause then
		helptext = "minigame paused"
		SendNUIMessage({paused = "true"})
	else
		helptext = "minigame resumed"
		SendNUIMessage({paused = "false"})
	end
	CreateThread(function()
		Wait(3000)
		helptext = false
	end)
end

RegisterNUICallback("givesitem", function(data,cb)
	print(data.givesitem, data.givesitemquantity)
	--CODE NEEDED HERE: GIVE INVENTORY ITEM
	local itemtext = data.givesitem .. " x".. data.givesitemquantity
	CreateThread(function()
		while itemtext do
			Wait(0)
			DrawText("INVENTORY NOTIFICATION",0.5,0.82)
			DrawText("YOU RECEIVED",0.5,0.84)
			DrawText(itemtext,0.5,0.86)
			DrawRect(0.5, 0.86, 0.2, 0.1, 40, 40, 40, 255)
		end
	end)
	CreateThread(function()
		Wait(3000)
		itemtext = false
	end)
	cb("ok")
end)

RegisterNUICallback("pausegame", function(data,cb)
	print("pausegame")
	minigamepaused = true
	PauseOrPlay(true)
	cb("ok")
end)

RegisterNUICallback("endgame", function(data,cb)
	SetNuiFocus(false, false)
	inminigame = false
	cb("ok")
end)

function DrawText(text,x,y)
	SetTextFont(7)
	SetTextScale(0.35, 0.35)
	SetTextColour(255,255,255,255)--r,g,b,a
	SetTextCentre(true)
	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(x, y)
end

function CreateBlip(x, y)
	local blip = AddBlipForCoord(x, y, 0.0)
	SetBlipSprite(blip, 499)
	SetBlipScale(blip, 1.0)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Water Treatment Job")
	EndTextCommandSetBlipName(blip)
	return blip
end

function CreateStartBlip(x,y)
	local blip = CreateBlip(x,y)
	SetBlipAsShortRange(blip, true)
	return blip
end

function CreateJobBlip(xmin, ymin, xmax, ymax)
	local centerx = ((xmin + xmax) / 2) * 1.0
	local centery = ((ymin + ymax) / 2) * 1.0

	local trueradius = GetDistance(xmax, ymax, centerx, centery)
	local radius = trueradius * 2.0

	local radiusblip = AddBlipForRadius(centerx, centery, 0.0, radius)
	SetBlipSprite(radiusblip, 161)
	SetBlipColour(radiusblip, 5)

	local blip = CreateBlip(centerx, centery)
	SetBlipRoute(blip, true)
	SetBlipRouteColour(blip, 3)

	return {blip, radiusblip}, centerx, centery, trueradius
end

function RemoveJobBlip(blips)
    for i,blip in pairs(blips) do
        local blip = RemoveBlip(blip)
    end
end



function CreateJobPed(x, y, z)
	local jobmodel = GetHashKey("s_m_y_construct_02") -- Only Ped with Water and Power badges
	WaitForModel(jobmodel)
	local jobped = CreatePed(0, jobmodel, x, y, z, 245.0, false, false)
	SetBlockingOfNonTemporaryEvents(jobped, true)
	FreezeEntityPosition(jobped, true)
	SetEntityInvincible(jobped, true)
	SetPedFleeAttributes(jobped, 0, false)
	SetPedDefaultComponentVariation(jobped)
	ClearAllPedProps(jobped)
	local headvariant, uniformvariant = r(0,1), r(0,1) -- african american or caucasian and overalls or shirt & shorts
	local headdrawable, torsodrawable, legsdrawable, badgedrawable = headvariant, uniformvariant, uniformvariant, uniformvariant
	local headtexture, torsotexture, legstexture = r(0,2), r(0,1), r(0,1) -- random head and overalls or african american arms and legs
	if (uniformvariant == 0) and (headvariant == 1) then -- shirt & shorts and caucasian
		torsotexture, legstexture = r(2,3), r(2,3) -- gives caucasian arms and legs
	end
	SetPedComponentVariation(jobped, 0, headdrawable, headtexture, 0)
	SetPedComponentVariation(jobped, 3, torsodrawable, torsotexture, 0)
	SetPedComponentVariation(jobped, 4, legsdrawable, legstexture, 0)
	SetPedComponentVariation(jobped, 8, 2, 0, 0) -- vest always off so badge can be seen
	SetPedComponentVariation(jobped, 10, badgedrawable, 0, 0)
	if r(0,1) == 1 then -- hat or no hat, other hats available but they don't suit
		SetPedPropIndex(jobped, 0, 0, r(0,2), true) -- random hard hat texture
	end
	local glassesdrawable = r(0,2) -- 2 glasses drawables but variant instead includes no glasses
	local glassestexture = 0
	if glassesdrawable == 1 then -- 0 = sunglasses, 1 = glasses
		glassestexture = r(0,1) -- only glasses have textures
	end
	if glassesdrawable < 2 then -- in this code, not game code, 2 = no glasses
		SetPedPropIndex(jobped, 1, glassesdrawable, glassestexture, true)
	end

	return jobped
end

function WaitForModel(model)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(0)
	end
end

function SpawnVehicle(jetskineeded)
	local jetski
	local modelisburrito = false
	local model = -1987130134 -- boxville with W&P livery
	if jetskineeded then
		WaitForModel(-1030275036) -- seashark jetski
	else
		if r(0,1) == 1 then
			modelisburrito = true
			model = -1346687836 -- burrito with liveries
		end
	end
	WaitForModel(model)
	
	local baysblocked = GetBlockedBays()
	while #baysblocked == 5 do
		helptext = "All bays are blocked, wait or clear space"
		baysblocked = GetBlockedBays()
		Wait(1000)
	end
	helptext = false

	local emptybays = {1,2,3,4,5}
	for j,b in pairs(baysblocked) do
		for i=1,5 do
			if b == i then
				emptybays[i] = nil
			end
		end
	end

	local bay = 5
	for k,v in pairs(emptybays) do
		if v then
			bay = math.min(bay,v)
		end
	end

	bay = bay - 1
	local y1, y4 = 137 - (2.8  * bay), 132 - (2.8  * bay)
	local x2, x3 = 748 - (1.8 * bay), 755 - (1.8 * bay)
	
	local x, y = (x2 + x3) / 2 + 0.5, (y1 + y4) / 2 - 0.15

	local vehicle = CreateVehicle(model, x, y, 79.0, 243.5, true, true)

	if jetskineeded then
		jetski = CreateVehicle(-1030275036, x, y, 59.0, 0.0, true, true)
		local heading = GetEntityHeading(vehicle)
		SetEntityHeading(jetski, heading)
		AttachEntityToEntity(jetski, vehicle, 0, 0.0, -1.5, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
	end

	if modelisburrito then
		SetVehicleLivery(vehicle, 3)
		local colouracceptable = false
		local colour = r(0,159)
		local colourblacklist = {0,1,11,12,15,27,28,29,30,31,32,33,34,35,39,40,43,44,45,46,48,49,
			50,52,53,55,56,57,58,59,92,94,95,96,97,98,100,101,103,104,108,109,120,125,128,133,135,136,137,139,
		141,142,143,145,146,147,148,149,150,151,152,155}
		while not colouracceptable do
			Wait(0)
			colouracceptable = true
			for k,blacklistedcolour in pairs(colourblacklist) do
				if colour == blacklistedcolour then
					colouracceptable = false
					colour = r(0,159)
					break
				end
			end
		end
		SetVehicleColours(vehicle, colour, colour)
	end
	SetVehicleOnGroundProperly(vehicle)
	return vehicle, jetski
end

function GetBlockedBays()
	local baysblocked = {}
	local pedhandle, ped = FindFirstPed()
	local pedfound
	repeat
		if ped then
			for i,v in ipairs(IsEntityInAnyBay(ped)) do
				table.insert(baysblocked, v)
			end
		end
		pedfound, ped = FindNextPed(pedhandle)
	until not pedfound
	EndFindPed(pedhandle)

	local vehiclehandle, vehicle = FindFirstVehicle()
	local vehiclefound
	repeat
		if vehicle then
			for i,v in ipairs(IsEntityInAnyBay(vehicle)) do
				table.insert(baysblocked, v)
			end
		end
		vehiclefound, vehicle = FindNextVehicle(vehiclehandle)
	until not vehiclefound
	EndFindVehicle(vehiclehandle)

	local keyedbaysblocked = {}
	local finalbaysblocked = {}
	for k,bay in ipairs(baysblocked) do
		if (not keyedbaysblocked[bay]) then
			finalbaysblocked[#finalbaysblocked+1] = bay
			keyedbaysblocked[bay] = true
		end
	end
	return finalbaysblocked
end

function GetEntitysVertices(entity)
	local modelmin,modelmax = GetModelDimensions(GetEntityModel(entity))
	local xmin,ymin,zmin = table.unpack(modelmin)
	local xmax,ymax,zmax = table.unpack(modelmax)
	local x1, y1 = table.unpack(GetOffsetFromEntityInWorldCoords(entity,xmin, ymin, 0.0))
	local x2, y2 = table.unpack(GetOffsetFromEntityInWorldCoords(entity,xmax, ymin, 0.0))
	local x3, y3 = table.unpack(GetOffsetFromEntityInWorldCoords(entity,xmin, ymax, 0.0))
	local x4, y4 = table.unpack(GetOffsetFromEntityInWorldCoords(entity,xmax, ymax, 0.0))
	return {x1, y1, x2, y2, x3, y3, x4, y4}
end

function IsEntityInAnyBay(entity)
	local bays = {}
	if IsEntityInArea(entity, 756.0, 120.0, 75.0, 740.0, 138.0, 85.0, false, false, 0) then
		local x1, y1 = 749, 137 -- first bay top left
		local x2, y2 = 748, 135 -- first bay bottom left
		local x3, y3 = 755, 134 -- first bay top right
		local x4, y4 = 754, 132 -- first bay bottom right
		local spotvertices = {x1, y1, x2, y2, x3, y3, x4, y4}

		for i=1,5 do
			if IsEntityInSpot(GetEntitysVertices(entity), spotvertices) then
				table.insert(bays,i)
			end
			x1, y1 = x1 - 1.8, y1 - 2.8
			x2, y2 = x2 - 1.8, y2 - 2.8
			x3, y3 = x3 - 1.8, y3 - 2.8
			x4, y4 = x4 - 1.8, y4 - 2.8
			spotvertices = {x1, y1, x2, y2, x3, y3, x4, y4}
		end
	end
	return bays
end

function GetSkimmingAnimation(ped)
	local skimmerhash = GetHashKey("prop_poolskimmer")
	WaitForModel(skimmerhash)
	local animdict = "timetable@gardener@clean_pool@"
	RequestAnimDict(animdict)
	while not HasAnimDictLoaded(animdict) do
		Wait(0)
	end
	local x, y, z = table.unpack(GetEntityCoords(ped))
	local skimmer = CreateObject(skimmerhash, x, y, z, true, true, false)
	return skimmer, animdict, skimmerhash
end

function PlaySkimmingAnimation(skimmer, animdict, ped)
	local random = r(1,3)
	local anim, wait = "a", 19000
	if random == 2 then
		anim, wait = "b", 18000
	elseif random == 3 then
		anim, wait = "c", 15000
	end

	local x, y, z = table.unpack(GetEntityCoords(ped))
	local heading = GetEntityHeading(ped)
	local scene = NetworkCreateSynchronisedScene(x, y, z-1.15, 0.0, 0.0, heading + 180.0, 2, true, true, 1.0, 0.0, 1.0)
	NetworkAddPedToSynchronisedScene(ped, scene, animdict, "idle_"..anim.."_gardener", 1.5, -1.5, 262, 0, 1000.0, 0)
	NetworkAddEntityToSynchronisedScene(skimmer, scene,	animdict, "idle_"..anim.."_skimmer", 1.5, -1.5, 0)
	NetworkStartSynchronisedScene(scene)
	return scene, wait
end

function StopSkimmingAnimation(scene)
	NetworkStopSynchronisedScene(scene)
	NetworkUnlinkNetworkedSynchronisedScene(scene)
end



-- Library From https://github.com/davisdude/mlib and revised for this script

function IsEntityInCircle(entity, x, y, radius)
	local entityvertices = GetEntitysVertices(entity)
	for i = 1, #entityvertices, 2 do
		if GetDistance(entityvertices[i], entityvertices[i + 1], x, y) > radius then
			return false
		end
	end
	return true
end

function checkFuzzy(number1, number2)
	return (number1 - .00001 <= number2 and number2 <= number1 + .00001)
end

function getSlope(x1, y1, x2, y2)
	if checkFuzzy(x1, x2) then return false end
	return (y1 - y2) / (x1 - x2)
end

function GetEdgesOnY(x1, x2, y, v)
	local slope = getSlope(x1, y, x2, y)
	local intercept = slope and (y - slope * x1) or x1
	local x3, y3, x4, y4 = 1, slope * 1 + intercept, 2, slope * 2 + intercept
	local edgecoords = {}
	for i = 1, #v, 2 do
		local x1, y1, x2, y2 = GetIntersectionCoords(v[i], v[i + 1], v[(i + 1) % #v + 1], v[(i + 2) % #v + 1], x3, y3, x4, y4)
		if x1 then
			local edgecoordscount = #edgecoords
			edgecoords[edgecoordscount + 1] = {x1, y1}
			if x2 then -- edge goes straight along x
				edgecoords[edgecoordscount + 2] = {x2, y2}
			end
		end
	end
	return #edgecoords > 0 and edgecoords or false
end

function GetDistance(x1, y1, x2, y2)
	local dx, dy = x1 - x2, y1 - y2
	return math.sqrt(dx^2 + dy^2)
end

function GetIntersectionCoords(x1, y1, x2, y2, x3, y3, x4, y4)
	local x, y
	local slope1 = getSlope(x3, y3, x4, y4)
	local slope2 = getSlope(x1, y1, x2, y2)
	local intercept1 = slope1 and (y3 - slope1 * x3) or x3
	local intercept2 = slope2 and (y1 - slope2 * x1) or x1
	if slope2 then -- slope2 is not vertical
		if checkFuzzy(slope1, slope2) then -- Parallel
			if checkFuzzy(intercept1, intercept2) then -- Same intercept
				return x1, y1, x2, y2 -- Lines are collinear.
			end
		else -- normal lines
			x = (-intercept1 + intercept2) / (slope1 - slope2)
			y = slope1 * x + intercept1
		end
	else
		x, y = x1, slope1 * x1 + intercept1
	end

	if x then
		local length1, length2 = GetDistance(x1, y1, x, y), GetDistance(x2, y2, x, y)
		local distance = GetDistance(x1, y1, x2, y2)
		if length1 <= distance and length2 <= distance then
			return x, y
		else
			return false
		end
	else -- Lines are parallel but not collinear.
		if checkFuzzy(intercept1, intercept2) then
			return x1, y1, x2, y2
		else
			return false
		end
	end
end

-- math for IsEntityInAnyBay

-- Returns whether the polygon is inside the polygon.
function IsEntityInSpot(p1, p2) -- (entityvertices, spotvertices)
	for ev = 1, #p1, 2 do
		local x1, y1, x2, y2 = p1[ev], p1[ev + 1], p1[(ev + 1) % #p1 + 1], p1[(ev + 2) % #p1 + 1]
		for sv = 1, #p2, 2 do
			local x3, y3, x4, y4 = p2[sv], p2[sv + 1], p2[(sv + 1) % #p2 + 1], p2[(sv + 2) % #p2 + 1]
			if DoesSegmentIntersect(x1, y1, x2, y2, x3, y3, x4, y4) then
				return true
			end
		end
	end
	return false
end

-- Gives the point of intersection between two line segments.
function DoesSegmentIntersect(x1, y1, x2, y2, x3, y3, x4, y4)
	local slope1 = getSlope(x1, y1, x2, y2)
	local intercept1 = slope1 and (y1 - slope1 * x1) or x1
	local slope2 = getSlope(x3, y3, x4, y4)
	local intercept2 = slope2 and (y3 - slope2 * x3) or x3
	local x,y
	if ((slope1 and slope2) and checkFuzzy(slope1, slope2)) or (not slope1 and not slope2) then -- Parallel lines
		if checkFuzzy(intercept1, intercept2) then -- The same lines, possibly in different points.
			if IsPointInSegment(x1, y1, x3, y3, x4, y4) then return true end
			if IsPointInSegment(x2, y2, x3, y3, x4, y4) then return true end
			if IsPointInSegment(x3, y3, x1, y1, x2, y2) then return true end
			if IsPointInSegment(x4, y4, x1, y1, x2, y2) then return true end
		end
		return false
	elseif not slope1 then -- First is vertical
		x = x1 -- They have to meet at this x, since it is this line's only x
		y = slope2 and slope2 * x + intercept2 or 1
	elseif not slope2 then -- Second is vertical
		x = x3 -- Vice-Versa
		y = slope1 * x + intercept1
	else -- Regular lines
		x = (-intercept1 + intercept2) / (slope1 - slope2)
		y = slope1 * x + intercept1
	end
	if IsPointInSegment(x, y, x1, y1, x2, y2) and IsPointInSegment(x, y, x3, y3, x4, y4) then
		return true
	end
	return false
end

-- Gives whether or not a point lies on a line segment.
function IsPointInSegment(x, y, x1, y1, x2, y2)
	local m = getSlope(x1, y1, x2, y2)
	if m then
		local b = y1 - m * x1
		if not checkFuzzy(y, m * x + b) then return false end
	else
		if not checkFuzzy(x, x1) then return false end
	end
	local lengthx = x2 - x1
	local lengthy = y2 - y1
	if checkFuzzy(lengthx, 0) then -- Vertical line
		if checkFuzzy(x, x1) then
			if y1 < y2 then
				if y1 <= y and y2 >= y then return true end
			else
				if y2 <= y and y1 >= y then return true end
			end
		end
		return false
	elseif checkFuzzy(lengthy, 0) then -- Horizontal line
		if checkFuzzy(y, y1) then
			if x1 < x2 then
				if x1 <= x and x2 >= x then return true end
			else
				if x2 <= x and x1 >= x then return true end
			end
		end
		return false
	end
	local scalex = (x - x1) / lengthx
	local scaley = (y - y1) / lengthy
	if (scalex >= 0 and scalex <= 1) and (scaley >= 0 and scaley <= 1) then -- Intersection
		return true
	end
	return false
end
