local TeamWorker = Class(function(self, inst)
	self.inst = inst
	self.identifiers = {}
end,
nil,
{})

function TeamWorker:SetIdentifier(identifier, value)
	self.identifiers[identifier] = value
end

function TeamWorker:GetIdentifier(identifier)
	return self.identifiers[identifier]
end

function TeamWorker:RemoveIdentifier(identifier)
	self.identifiers[identifier] = nil
end

function TeamWorker:Identify(target, identifier)
	if not target.components.teamworker then
		return false
	end
	if identifier then 
		return target.components.teamworker.GetIdentifier(identifier) == self.identifiers[identifier]
	end
	for k, v in pairs(self.identifiers) do
		if target.components.teamworker.GetIdentifier(k) == v then
			return true
		end
	end
end

function TeamWorker:OnSave()
	local data = { identifiers = self.identifiers }
	return data
end

function TeamWorker:OnLoad(data, newents)
	if data.identifiers then
		self.identifiers = data.identifiers
	end
end

return TeamWorker