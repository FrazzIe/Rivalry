Utilities.Data.Decorators = {
	Float = {Type = 1, Get = DecorGetFloat, Set = DecorSetFloat},
	Bool = {Type = 2, Get = DecorGetBool, Set = DecorSetBool},
	Int = {Type = 3, Get = DecorGetInt, Set = DecorSetInt},
	Time = {Type = 5, Set = DecorSetTime},
}

function Utilities:GetDecoratorType(Decorator)
	for Key, Data in pairs(self.Data.Decorators) do
		if DecorIsRegisteredAsType(Decorator, Data.Type) then
			return Key
		end
	end

	return nil
end

function Utilities:DoesDecoratorTypeExist(Type)
	for Key, Data in pairs(self.Data.Decorators) do
		if Data.Type == Type then
			return true
		end
	end

	return false
end

function Utilities:CreateDecorator(Decorator, Type)
	if not self:GetDecoratorType(Decorator) then
		if self:DoesDecoratorTypeExist(Type) then
			DecorRegister(Decorator, Type)
		end
	end
end

function Utilities:GetDecorator(Entity, Decorator)
	if DecorExistOn(Entity, Decorator) then
		local Type = self:GetDecoratorType(Decorator)

		if Type then
			if self.Data.Decorators[Type].Get then
				return self.Data.Decorators[Type].Get(Entity, Decorator)
			end
		end
	end

	return nil
end

function Utilities:SetDecorator(Entity, Decorator, Value)
	local Type = self:GetDecoratorType(Decorator)

	if Type then
		if self.Data.Decorators[Type].Set then
			self.Data.Decorators[Type].Set(Entity, Decorator, Value)
		end
	end
end