local Animation = {
	Dictionaries = {},
	Sets = {},
	Clipsets = {},
}

function DictionaryExists(Dictionary)
	for Index = 1, #Animation.Dictionaries do
		if Animation.Dictionaries[Index] == Dictionary then
			return true
		end
	end
	return false
end

function AnimSetExists(Set)
	for Index = 1, #Animation.Sets do
		if Animation.Sets[Index] == Set then
			return true
		end
	end
	return false
end

function ClipsetExists(Clipset)
	for Index = 1, #Animation.Clipsets do
		if Animation.Clipsets[Index] == Clipset then
			return true
		end
	end
	return false
end

function AddAnimDictionary(Dictionary)
	if not DictionaryExists(Dictionary) then
		table.insert(Animation.Dictionaries, Dictionary)
	end
end

function AddAnimSet(Set)
	if not AnimSetExists(Set) then
		table.insert(Animation.Sets, Set)
	end
end

function AddAnimClipset(Clipset)
	if not ClipsetExists(Clipset) then
		table.insert(Animation.Clipsets, Clipset)
	end
end

Citizen.CreateThread(function()
	Citizen.Trace("[Dictionaries]->Loading")
	for Index = 1, #Animation.Dictionaries do
		local Dictionary = Animation.Dictionaries[Index]
		if DoesAnimDictExist(Dictionary) then
			RequestAnimDict(Dictionary)
			while not HasAnimDictLoaded(Dictionary) do
				Citizen.Wait(250)
			end
			--Citizen.Trace("[Dictionaries]->["..Dictionary.."]->Loaded")
		end
	end
	Citizen.Trace("[Dictionaries]->Loaded")
end)

Citizen.CreateThread(function()
	Citizen.Trace("[Sets]->Loading")
	for Index = 1, #Animation.Sets do
		local Set = Animation.Sets[Index]
		RequestAnimSet(Set)
		while not HasAnimSetLoaded(Set) do
			Citizen.Wait(250)
		end
		--Citizen.Trace("[Sets]->["..Set.."]->Loaded")
	end
	Citizen.Trace("[Sets]->Loaded")
end)

Citizen.CreateThread(function()
	Citizen.Trace("[Clipsets]->Loading")
	for Index = 1, #Animation.Clipsets do
		local Clipset = Animation.Clipsets[Index]
		RequestClipSet(Clipset)
		while not HasClipSetLoaded(Clipset) do
			Citizen.Wait(250)
		end
		--Citizen.Trace("[Clipsets]->["..Clipset.."]->Loaded")
	end
	Citizen.Trace("[Clipsets]->Loaded")
end)