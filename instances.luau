local instances = {}

export type PropertiesTable = { [ string ]: any }
export type InstanceBehaviorFunc = ( Instance ) -> ()

export type InstantiateData = { Class: string, Properties: PropertiesTable?, Style: string?, Children: { InstantiateData }?, Behavior: InstanceBehaviorFunc? }

local styles = {}

function instances:ApplyProperty(
	Object: Instance,
	Property_Name: string,
	Property_Value: any
)
	local exists = pcall(function()
		Object[ Property_Name ] = Property_Value
	end)
	if not exists then
		warn( 'Cannot Set Property of Type "' .. Property_Name .. '" to Class "' .. Object.ClassName .. '" because it is Invalid.' )
		return false
	end
end

function instances:ApplyPropertyList(
	Object: Instance,
	Properties: PropertiesTable
)
	if Object ~= nil then
		if Properties ~= nil then
			for name, value in pairs( Properties ) do
				self:ApplyProperty( Object, name, value )
			end
		end
	end
end

function instances:proper_new(
	Instance_Name: string,
	Instance_Properties: PropertiesTable?,
	Style: string?,
	Behavior: InstanceBehaviorFunc?
): Instance | nil
	local object: Instance
	local exists = pcall(function()
		object = Instance.new( Instance_Name )
	end)
	if exists then
		if Instance_Properties ~= nil and typeof( Instance_Properties ) == 'table' then
			self:ApplyPropertyList( object, Instance_Properties )
		end
		self:ApplyPropertyList( object, styles[ Style ] )
		if Behavior ~= nil and typeof( Behavior ) == 'function' then
			Behavior( object )
		end
		return object
	else
		error( 'Failed to Create and Instance of Type "' .. Instance_Name .. '" because it does not exist.' )
		return nil
	end
end

function instances:proper_new_style(
	Style_Name: string,
	Style_Properties: PropertiesTable?
): boolean
	if styles[ Style_Name ] == nil then
		styles[ Style_Name ] = Style_Properties
		return true
	else
		warn( 'Could not Create a new Style with Name "' .. Style_Name .. '" because that alias has already been taken.' )
		return false
	end
end

function instances:proper_instantiate(
	Instantiate_Data: InstantiateData
): Instance | nil
	local main_object = self:proper_new( Instantiate_Data.Class, Instantiate_Data.Properties, Instantiate_Data.Style, Instantiate_Data.Behavior )
	if Instantiate_Data.Children ~= nil and typeof( Instantiate_Data.Children ) == 'table' then
		for _, sub_object in ipairs( Instantiate_Data.Children ) do
			local object = self:proper_instantiate( sub_object )
			if object ~= nil then
				object.Parent = main_object
			end
		end
	end
	return main_object
end

function instances.new(
	Instance_Name: string,
	Instance_Properties: PropertiesTable?,
	Style: string?,
	Behavior: InstanceBehaviorFunc?
): Instance | nil
	return instances:proper_new( Instance_Name, Instance_Properties, Style, Behavior )
end

function instances.newStyle(
	Style_Name: string,
	Style_Properties: PropertiesTable?
): boolean
	return instances:proper_new_style( Style_Name, Style_Properties )
end

function instances.instantiate(
	Instantiate_Data: InstantiateData
)
	return instances:proper_instantiate( Instantiate_Data )
end

return instances
