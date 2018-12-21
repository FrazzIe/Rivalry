Queue = {
	Config = {
		Whitelist = true,
		PriorityWhitelist = false,
		RequireSteam = true,
		Bans = true,
		Priority = true,
		Loading = {"🕐", "🕑", "🕒", "🕓", "🕔", "🕕", "🕖", "🕗", "🕘", "🕙", "🕚", "🕛"},
		MaxPlayers = 32,
	},
	Players = {
		Connected = {},
		Connecting = {},
		Waiting = {},
		Disconnected = {},
	},
}


function Queue:PlayerCount()
	return Utilities:GetTableLength(Queue.Players.Connected) + #self.Players.Connecting
end

function Queue:Identifiers(Source)
	return {license = Utilities:GetPlayerLicense(Source), steam = Utilities:GetPlayerSteam32(Source), ip = Utilities:GetPlayerIP(Source)}
end

function Queue:IsInWaiting(Identifiers, Source, GetData)
	for Index = 1, #self.Players.Waiting do
		if self.Players.Waiting[Index] then
			if Source ~= nil then
				if Source == self.Players.Waiting[Index].Source then
					if GetData then
						return true, Index, self.Players.Waiting[Index]
					else
						return true, Index
					end
				end
			else
				if self.Players.Waiting[Index].Identifiers then
					for _, QueueId in pairs(self.Players.Waiting[Index].Identifiers) do
						for _, Id in pairs(Identifiers) do
							if Id == QueueId then
								if GetData then
									return true, Index, self.Players.Waiting[Index]
								else
									return true, Index
								end
							end
						end
					end
				end
			end
		end
	end

	if GetData then
		return nil, nil, nil
	else
		return nil, nil
	end
end

function Queue:IsInDisconnected(Identifiers)
	for Index = 1, #self.Players.Disconnected do
		if self.Players.Disconnected[Index] then
			if self.Players.Disconnected[Index].Identifiers then
				for _, DisconnectedId in pairs(self.Players.Disconnected[Index].Identifiers) do
					for _, Id in pairs(Identifiers) do
						if Id == DisconnectedId then
							return true, Index
						end
					end
				end
			end
		end
	end

	return nil, nil
end

function Queue:IsInConnecting(Identifiers)
	for Index = 1, #self.Players.Connecting do
		if self.Players.Connecting[Index] then
			if self.Players.Connecting[Index].Identifiers then
				for _, DisconnectedId in pairs(self.Players.Connecting[Index].Identifiers) do
					for _, Id in pairs(Identifiers) do
						if Id == DisconnectedId then
							return true, Index
						end
					end
				end
			end
		end
	end

	return nil, nil
end

function Queue:UpdateData(Source, Identifiers, Priority, Deferrals)
	local InQueue, Position = self:IsInWaiting(Identifiers)
	if InQueue then
		self.Players.Waiting[Position].ConnectTime = os.time()
		self.Players.Waiting[Position].Source = Source
		self.Players.Waiting[Position].Identifiers = Identifiers
		self.Players.Waiting[Position].Priority = Priority or 0
		self.Players.Waiting[Position].Deferrals = Deferrals
		self.Players.Waiting[Position].Timeout = 0
	end
end

function Queue:SetPosition(Identifiers, NewPosition)
	local InQueue, Position, Data = self:IsInWaiting(Identifiers, nil, true)

	if InQueue then
		table.remove(self.Players.Waiting, Position)
		table.insert(self.Players.Waiting, NewPosition, Data)
	end
end

function Queue:GetPriorityPosition(Priority)
	for Index = 1, #self.Players.Waiting do
		if self.Players.Waiting[Index].Priority < Priority then
			return Index
		end
	end
end

function Queue:AddToWaiting(Data)
	Data.Timeout = 0
	Data.ConnectTime = os.time()

	if self.Config.Priority and Data.Priority > 0 then
		local Position = self:GetPriorityPosition(Data.Priority)

		table.insert(self.Players.Waiting, Position, Data)
	else
		table.insert(self.Players.Waiting, Data)
	end
end

function Queue:AddToConnecting(Data)
	Data.Timeout = 0
	Data.ConnectTime = os.time()
	Data.Deferrals = nil

	table.insert(self.Players.Connecting, Data)
end

function Queue:AddToDisconnected(Data)
	Data.DisconnectTime = os.time()

	table.insert(self.Players.Disconnected, Data)
end

function Queue:RemoveFromWaiting(Identifiers, Source)
	for Index = 1, #self.Players.Waiting do
		if self.Players.Waiting[Index] then
			if Source ~= nil then
				if Source == self.Players.Waiting[Index].Source then
					table.remove(self.Players.Waiting, Index)
					break
				end
			else
				if self.Players.Waiting[Index].Identifiers then
					for _, QueueId in pairs(self.Players.Waiting[Index].Identifiers) do
						for _, Id in pairs(Identifiers) do
							if Id == QueueId then
								table.remove(self.Players.Waiting, Index)
								break
							end
						end
					end
				end
			end
		end
	end
end

function Queue:RemoveFromConnecting(Identifiers, Source)
	for Index = 1, #self.Players.Connecting do
		if self.Players.Connecting[Index] then
			if Source ~= nil then
				if Source == self.Players.Connecting[Index].Source then
					table.remove(self.Players.Connecting, Index)
					break
				end
			else
				if self.Players.Connecting[Index].Identifiers then
					for _, QueueId in pairs(self.Players.Connecting[Index].Identifiers) do
						for _, Id in pairs(Identifiers) do
							if Id == QueueId then
								table.remove(self.Players.Connecting, Index)
								break
							end
						end
					end
				end
			end
		end
	end
end

function Queue:RemoveFromDisconnected(Identifiers)
	for Index = 1, #self.Players.Disconnected do
		if self.Players.Disconnected[Index] then
			if self.Players.Disconnected[Index].Identifiers then
				for _, QueueId in pairs(self.Players.Disconnected[Index].Identifiers) do
					for _, Id in pairs(Identifiers) do
						if Id == QueueId then
							table.remove(self.Players.Disconnected, Index)
							break
						end
					end
				end
			end
		end
	end
end

Citizen.CreateThread(function()
	AddEventHandler("playerConnecting", function(Name, Kick, Deferrals)
		Queue.Config.MaxPlayers = GetConvarInt("sv_maxclients", 32)
		Queue.Config.Hostname = Queue.Config.Hostname and Queue.Config.Hostname or GetConvar("sv_hostname")

		local Source = source
		local Identifiers = Queue:Identifiers(Source)

		Deferrals.defer()

		Deferrals.update("Connecting..")

		Citizen.Wait(1000)

		Deferrals.update("Checking Identifiers..")

		if not Identifiers.license then
			Deferrals.done("Error: Invalid identifiers!")

			return
		end

		if not Identifiers.steam and Queue.Config.RequireSteam then
			Deferrals.done("Error: Steam must be running!")

			return
		end

		if Queue.Config.Bans then
			Deferrals.update("Checking bans..")

			local Ban = exports.jssql:executeSync("SELECT bans.reason, UNIX_TIMESTAMP(bans.expire) AS 'expire', @@system_time_zone AS 'timezone' FROM bans INNER JOIN players ON bans.player_id = players.id WHERE (players.license=? OR players.steam=?) AND (UNIX_TIMESTAMP(bans.expire) > UNIX_TIMESTAMP())", {Identifiers.license, Identifiers.steam})

			if Ban[1] ~= nil then
				Deferrals.done(string.format("Error: %s you are %s - rivalryrp.com", Name, ((Ban[1].permanent == 1) and "permanently banned on this server!" or "banned! It will expire on "..os.date("%A the "..Utilities:Ordinal(os.date("%d", Ban[1].expire)).." of %B at %I:%M%p "..Ban[1].timezone, Ban[1].expire)..". Ban reason: "..Ban[1].reason)))

				return
			end
		end

		local Player = {}

		if Queue.Config.Priority or Queue.Config.Whitelist then
			local Result = exports.jssql:executeSync("SELECT whitelisted, priority FROM players WHERE steam=?", {Identifiers.steam})

			Player = Result[1] or nil

			if not Player then
				exports.jssql:execute("INSERT INTO players (`license`, `steam`, `ip`, `name`) VALUES (?, ?, ?, ?)", {Identifiers.license, Identifiers.steam, Identifiers.ip, Name})
			else
				exports.jssql:execute("UPDATE players SET license=?,ip=?,name=? WHERE steam=?", {Identifiers.license, Identifiers.ip, Name, Identifiers.steam})
			end

			if Queue.Config.Whitelist and not (Queue.Config.Priority and Queue.Config.PriorityWhitelist) then
				Deferrals.update("Checking whitelist..")

				if Player.whitelisted ~= 1 then
					Deferrals.done("Error: You must be whitelisted to play on rivalry, apply at rivalryrp.com!")

					return
				end
			end

			if Queue.Config.Priority and Queue.Config.PriorityWhitelist then
				Deferrals.update("Checking whitelist..")

				if Player.priority == nil or Player.priority < 1 then
					Deferrals.done("Error: Priority whitelisting is active; you must have priority in the queue to join!")

					return
				end
			end
		end

		Deferrals.update("Entering queue...")

		local Rejoined = false
		local InWaiting, Position = Queue:IsInWaiting(Identifiers)

		if InWaiting then
			Rejoined = true
			Queue:UpdateData(Source, Identifiers, Player.priority, Deferrals)
		else
			local InDisconnected, Position = Queue:IsInDisconnected(Identifiers)
			if InDisconnected then
				Queue:RemoveFromDisconnected(Identifiers)
				Queue:AddToWaiting({Source = Source, Identifiers = Identifiers, Priority = Player.priority or 0, Deferrals = Deferrals})
				Queue:SetPosition(Identifiers, 1)
			else
				Queue:AddToWaiting({Source = Source, Identifiers = Identifiers, Priority = Player.priority or 0, Deferrals = Deferrals})
			end
		end

		local InConnecting, Position = Queue:IsInConnecting(Identifiers)

		if InConnecting then
			Queue:RemoveFromConnecting(Identifiers)

			if Queue:PlayerCount() < Queue.Config.MaxPlayers then
				Queue:AddToConnecting({Source = Source, Identifiers = Identifiers, Priority = Player.priority or 0, Deferrals = Deferrals})
				Deferrals.done()

				Queue:RemoveFromWaiting(nil, Source)
				return
			else
				Queue:SetPosition(Identifiers, 1)
			end
		end

		InWaiting, Position, Data = Queue:IsInWaiting(nil, Source, true)

		if not InWaiting or not Data then
			Deferrals.done("Error: There was an issue when adding you to the queue!")

			return
		end

		if Queue:PlayerCount() < Queue.Config.MaxPlayers then
			Queue:AddToConnecting({Source = Source, Identifiers = Identifiers, Priority = Player.priority or 0, Deferrals = Deferrals})
			Deferrals.done()

			Queue:RemoveFromWaiting(nil, Source)
			return
		end

		Deferrals.update(string.format("%s You are %d/%d in queue", Queue.Config.Loading[1], Position, #Queue.Players.Waiting))

		Citizen.CreateThread(function()
			if Rejoined then
				return
			end

			local Emoji = 1

			while true do
				Citizen.Wait(1000)

				Emoji = Emoji + 1

				if Emoji > #Queue.Config.Loading then
					Emoji = 1
				end

				local InWaiting, Position, Data = Queue:IsInWaiting(Identifiers, nil, true)

				if not InWaiting or not Data then

					if Data and Data.Deferrals then
						Data.Deferrals.done("Error: 🤷")
					end

					Queue:RemoveFromWaiting(Identifiers)
					Queue:RemoveFromConnecting(Identifiers)
					return
				end

				if Position <= 1 and Queue:PlayerCount() < Queue.Config.MaxPlayers then
					local Deferrals = Data.Deferrals

					Queue:AddToConnecting(Data)

					Citizen.Wait(500)

					Deferrals.done()

					Queue:RemoveFromWaiting(Identifiers)
					return
				end

				Data.Deferrals.update(string.format("%s You are %d/%d in queue", Queue.Config.Loading[Emoji], Position, #Queue.Players.Waiting))
			end
		end)
	end)

	function ManageTimeouts()
		local Index = 1

		while Index <= #Queue.Players.Waiting do
			local Data = Queue.Players.Waiting[Index]
			local LastMessage = GetPlayerLastMsg(Data.Source)

			if LastMessage > 30000 then
				Data.Timeout = Data.Timeout + 1
			else
				Data.Timeout = 0
			end

			if not Data.Source or not Data.Identifiers or not Data.ConnectTime or Data.Priority == nil then
				Data.Deferrals.done("Error: Invalid data!")

				table.remove(Queue.Players.Waiting, Index)
			elseif Data.Timeout >= 120 and os.time() - Data.ConnectTime > 5 then
				Data.Deferrals.done("Error: Timed out!")

				Queue:RemoveFromWaiting(nil, Data.Source)
				Queue:RemoveFromConnecting(nil, Data.Source)
			else
				Index = Index + 1
			end
		end

		Index = 1

		while Index <= #Queue.Players.Connecting do
			local Data = Queue.Players.Connecting[Index]
			local LastMessage = GetPlayerLastMsg(Data.Source)

			Data.Timeout = Data.Timeout + 1
			if ((Data.Timeout >= 300 and LastMessage >= 35000) or Data.Timeout >= 340) and os.time() - Data.ConnectTime > 5 then
				Queue:RemoveFromWaiting(nil, Data.Source)
				Queue:RemoveFromConnecting(nil, Data.Source)
			else
				Index = Index + 1
			end
		end

		Index = 1

		while Index <= #Queue.Players.Disconnected do
			local Data = Queue.Players.Disconnected[Index]

			if not Data.Source or not Data.Identifiers or not Data.DisconnectTime then
				table.remove(Queue.Players.Disconnected, Index)
			elseif os.time() - Data.DisconnectTime >= 600000 then
				table.remove(Queue.Players.Disconnected, Index)
			else
				Index = Index + 1
			end
		end

		local QueueCount = #Queue.Players.Waiting

		if Queue.Config.Hostname then
			SetConvar("sv_hostname", ((QueueCount > 0) and "["..QueueCount.."]" or "")..Queue.Config.Hostname)
		end

		SetTimeout(1000, ManageTimeouts)
	end

	ManageTimeouts()
end)

RegisterServerEvent("Rivalry.Start")
AddEventHandler("Rivalry.Start", function()
	local Source = source
	local Identifiers = Queue:Identifiers(Source)

	if not Identifiers.license then
		DropPlayer(Source, "Invalid identifers!")
		CancelEvent()
	end

	if not Identifiers.steam and Queue.Config.RequireSteam then
		DropPlayer(Source, "Steam must be running!")
		CancelEvent()
	end

	if not WasEventCanceled() then
		if not Queue.Players.Connected[Source] then
			Queue.Players.Connected[Source] = {
				Source = Source,
				Identifiers = Identifiers,
			}
		end

		Queue:RemoveFromWaiting(Identifiers)
		Queue:RemoveFromConnecting(Identifiers)
	end
end)

AddEventHandler("playerDropped", function()
	local Source = source
	local Identifiers = Queue:Identifiers(Source)

	if Queue.Players.Connected[Source] then
		if Queue.Players.Connected[Source].Identifiers then
			Queue:AddToDisconnected(Queue.Players.Connected[Source])
			Queue:RemoveFromWaiting(Queue.Players.Connected[Source].Identifiers)
			Queue:RemoveFromConnecting(Queue.Players.Connected[Source].Identifiers)
		end

		Queue.Players.Connected[Source] = nil
	end
end)

AddEventHandler("rconCommand", function(command, args)
	if command == "setplayers" then
		Queue.Config.MaxPlayers = tonumber(args[1]) or 0
		CancelEvent()
	end
end)