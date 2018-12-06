# Rivalry

https://choosealicense.com/no-permission/

## This repository and all of the files within are licensed under "No License"

* You are not allowed to: use, edit, copy, re-release or re-distribute without written permission from the main contributors

* Each contributor can only re-release or re-distribute their own work on third party platforms

## Statement of standards
**Naming convention**: PascalCase (capitalise each word)

##### PascalCase example

**Variables**: `Timer = 0`, `GlobalWarrants = {}`

**Functions**: `GetCharacterName()`, `GetTableLength()`

**Event**s: Separated by a `"."` -> `"Phone.Start"`, `"Phone.Ringtone.Start"`, `"Phone.Ringtone.Stop"`

##### Basic file layout

1. Variables
2. Functions
3. Threads
4. Events
5. NUI Callbacks

##### Example file layout

```lua
Queue = {
	Players = {
		Connected = {},
		Connecting = {},
	}
}

function Queue:PlayerCount()
	return Utilities:GetTableLength(Queue.Players.Connected) + #self.Players.Connecting
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
	end
end)

RegisterNetEvent("Resource.Function")
AddEventHandler("Resource.Function", function()

end)

RegisterNUICallback("callback-name", function(data, cb)
	cb("ok")
end)
```
