function Utilities:LoadAnimDictionary(Dictionary)
	if DoesAnimDictExist(Dictionary) then
		Citizen.CreateThread(function()
			local MaxLength = GetGameTimer() + 40000
			
			RequestAnimDict(Dictionary)

			while not HasAnimDictLoaded(Dictionary) and GetGameTimer() < MaxLength do
				Citizen.Wait(150)
			end
		end)
	end
end

function Utilities:LoadAnimSet(Set)
	Citizen.CreateThread(function()
		local MaxLength = GetGameTimer() + 40000

		RequestAnimSet(Set)

		while not HasAnimSetLoaded(Set) and GetGameTimer() < MaxLength do
			Citizen.Wait(150)
		end
	end)
end

function Utilities:LoadAnimClipset(Clipset)
	Citizen.CreateThread(function()
		local MaxLength = GetGameTimer() + 40000

		RequestClipSet(Clipset)

		while not HasClipSetLoaded(Clipset) and GetGameTimer() < MaxLength do
			Citizen.Wait(150)
		end
	end)
end