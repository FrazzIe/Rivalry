local DecoratorTypes = {
	Float = 1,
	Bool = 2,
	Int = 3,
	Time = 5
}

function DoesDecoratorTypeExist(Value)
	for Key, Type in pairs(DecoratorTypes) do
		if Value == Type then
			return true
		end
	end
	return false
end

function GetDecoratorType(Decorator)
	for Key, Type in pairs(DecoratorTypes) do
		if DecorIsRegisteredAsType(Decorator, Type) then
			return Key 
		end
	end
	return nil
end

function GetDecorator(Entity, Decorator)
	if DecorExistOn(Entity, Decorator) then
		local DecoratorType = GetDecoratorType(Decorator)
		if DecoratorType ~= "Time" then
			return assert(load("return DecorGet"..DecoratorType.."("..Entity..", \""..Decorator.."\")"))()
		else
			Log.Warn("Attempted to fetch a decorator \""..Decorator.."\" that cannot be fetched!")
		end
	else
		Log.Warn("Attempted to fetch a decorator \""..Decorator.."\" that does not exist on the target entity!")
		return nil
	end
	return nil
end

function SetDecorator(Entity, Decorator, Value)
	local DecoratorType = GetDecoratorType(Decorator)
	if DecoratorType then
		assert(load("DecorSet"..DecoratorType.."("..Entity..", \""..Decorator.."\", "..tostring(Value)..")"))()
	else
		Log.Warn("The decorator \""..Decorator.."\" does not exist!")
	end
end

function RemoveDecorator(Entity, Decorator)
	if DecorExistOn(Entity, Decorator) then
		DecorRemove(Entity, Decorator)
	else
		Log.Warn("The decorator \""..Decorator.."\" does not exist on the entity, therefore can't be removed!")
	end
end

function CreateDecorator(Decorator, Type)
	if not GetDecoratorType(Decorator) then
		if DoesDecoratorTypeExist(Type) then
			DecorRegister(Decorator, Type)
		else
			Log.Error("The decorator \""..Decorator.."\" has an invalid type -> \""..Type.."\"")
		end
	else
		Log.Warn("The decorator \""..Decorator.."\" already exists!")
	end
end