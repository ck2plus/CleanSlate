_Vertices = {}
-- Setups the input vertex for the actual main function
function SetVertex( vertex, prefix, prefix_type, bInVertexShader )
	VertexData = _Vertices[vertex]
	if VertexData == nil then
		return "// Error cannot find " .. vertex
	end

	InputLogic = "\n"
	Code = "\n\t" .. vertex .. " glsl_vertex;\n"
	for member_type, first, second in string.gmatch( VertexData, "[^\n;]%s*(%S*)%s*(%S*)%s*:%s*([^;\n]*)" ) do 
		if ( bInVertexShader == true or second ~= "POSITION" ) then
			Code = Code .. "\n\tglsl_vertex." .. first .. " = " .. prefix .. second .. ";" 
			InputLogic = InputLogic .. prefix_type .. " ".. member_type .. " " .. prefix .. second .. ";\n" 
		end
	end
	return Code, InputLogic
end

-- Setups the output vertex for the actual main function
function SetOutVertex( vertex )
	VertexData = _Vertices[vertex]
	if VertexData == nil then
		return "// Error cannot find " .. vertex
	end

	InputLogic = "\n"
	Code = ""
	for member_type, first, second in string.gmatch( VertexData, "[^\n;]%s*(%S*)%s*(%S*)%s*:%s*([^;\n]*)" ) do 
		if ( second == "POSITION" ) then
			Code = Code .. "\n\tgl_Position = out_glsl_vertex." .. first .. ";" 
		else	
			Code = Code .. "\n\tv_" .. second .. " = out_glsl_vertex." .. first .. ";" 
		end
		InputLogic = InputLogic .. "varying " .. member_type .. " v_" .. second .. ";\n" 
	end
	return Code, InputLogic
end

-- Wraps main inside glsl_main and creates a main function that will work with glsl
function DeclareShader( name, source )
	local nLine = debug.getinfo(2).currentline + 1;
	local FileName = debug.getinfo(2).source;
	local FileStart = string.find( FileName, "@" );
	if ( not FileStart == nil ) then
		FileName = string.sub( FileName, FileStart, -1 )
	end
	local LineInfo = "#line " .. nLine .. " // \"" .. FileName .. "\"\n"
	local modified_source = "";
	
	local new_main = ""
		
	local InputLogic = ""
	local OutputLogic = ""
	local bMainFound = false;
	for line in string.gmatch( source, "[^\n]+" ) do
		if ( not bMainFound ) and string.find(line, " main") then
			local modified_line = string.match( line, "%s*%S*%s*main%s?%(%s*i?n?c?o?n?s?t?%s*%S*%s*%S*%s*" ) .. ")\n"-- "%s*%S*%s*main%(%s*%S*%s*%S*%s*%)" )
			
			if string.match( line, "{" ) then
				modified_line = modified_line .. "\n{\n"
			end
			
			local prefix
			local prefix_type
			local bInVertexShader
			OutputVertex = string.match( line, "%s*(%S*)" )
			if _Vertices[ OutputVertex ] then
				new_main = new_main .. "\n\t".. OutputVertex .. " out_glsl_vertex = glsl_main( glsl_vertex );\n"
				local VertexInfo
				VertexInfo, OutputLogic = SetOutVertex( OutputVertex )
				new_main = new_main .. VertexInfo
				prefix = "in_"
				prefix_type = "attribute"
				bInVertexShader = true
			elseif string.match( line, "COLOR" ) then
				new_main = new_main .. "\n\tgl_FragColor = glsl_main( glsl_vertex );"
				prefix = "v_"
				prefix_type = "varying"
				bInVertexShader = false
			end
			local Vertex
			Vertex, InputLogic = SetVertex( string.match( line, "main%s?%(%s*i?n?c?o?n?s?t?%s*(%S*)" ), prefix, prefix_type, bInVertexShader )
			new_main = "void main()\n{\n" .. Vertex .. new_main -- .. string.sub( modified_line, string.find( modified_line, "glsl_main" ), string.find( modified_line, ")" ) + 1 ) .. ";\n}\n\n"
	
			new_main = new_main .. "\n}\n\n"
			modified_line = string.gsub( modified_line, "main", "glsl_main" )
			
			modified_source = modified_source ..  modified_line
			bMainFound = true
		else	
			modified_source = modified_source .. line .. "\n"
		end
	end
	
	_G[name] =  "#line 1000 // Input output\n"..
	InputLogic .. "\n" .. 
	OutputLogic .. "\n" .. 
	LineInfo ..
	modified_source .. "\n" .. 
	new_main
end

-- makes sure we get shared data
function DeclareShared( source )
	local nLine = debug.getinfo(2).currentline + 1;
	local FileName = debug.getinfo(2).source;
	local FileStart = string.find( FileName, "@" );
	if ( not FileStart == nil ) then
		FileName = string.sub( FileName, FileStart, -1 )
	end
	local LineInfo = "#line " .. nLine .. "\n" --"0 // \"" .. FileName .. "\"\n\r"
	if _G[ "Shared" ] == nil then
		_G[ "Shared" ] = LineInfo .. source
	else	
		_G[ "Shared" ] = LineInfo .. source .. "\n" ..  _G[ "Shared" ]
	end
end

-- let's us find the vertex data
function DeclareVertex( source )
	local ModifiedSource = source;
	
	if string.find( source, "struct" ) then	
		name = string.match( source, "struct ([^\n]+)" )
		
		ModifiedSource = ""
		for line in string.gmatch( source, "[^\n]+" ) do
			if string.find( line, ":" ) then
				ModifiedSource = ModifiedSource .. string.match( line, "(.*)%s*:" ) .. ";\n"
			else
				ModifiedSource = ModifiedSource .. line .. "\n"
			end
		end
		
		_Vertices[name] = source;
	end
	DeclareShared( ModifiedSource );
end

function GetUniformData( line )
	local nUniform = string.match( line, "CONSTANT_BUFFER%s*%(%s*(%d)" )
	return nUniform
end

local ConstantStringSuffix = { ".x )\n", ".xy )\n", ".xyz )\n", " )\n" }

ArrayConstants = {}

function GetConstantData( line, offset, nUniformIndex )
	local ConstantString = ""
	local ConstantSize = 1
	local nFloats = 4
	local Name = ""
	nFloats, Name = string.match( line, "%s*%S*(%d)%s*([A-Za-z0-9_]*).*;" )
	
	if nFloats == nil or Name == nil then
		Name = string.match( line, "%s*%S*%s*([A-Za-z0-9_]*).*;" )
		nFloats = 1
	end
	
	ConstantSize = string.match( line, "float%dx(%d)" )
	
	local ArraySize = string.match( line, "%[%s*(%d*)%s*%]" )
	
	if ArraySize == nil then
		ArraySize = 1
		
		if ConstantSize == nil then
			if nFloats == 1 then
				ConstantString = "#define " .. Name .. " float" .. "( UNIFORM" .. nUniformIndex .. "[ " .. offset .. " ]"
			else
				ConstantString = "#define " .. Name .. " vec" .. nFloats .. "( UNIFORM" .. nUniformIndex .. "[ " .. offset .. " ]"			
			end
			local index = 0 + nFloats
			ConstantString = ConstantString .. ConstantStringSuffix[ index ]
			ConstantSize = 1
		elseif ConstantSize == "4" then
			ConstantString = "#define " .. Name .. " mat4( UNIFORM" .. nUniformIndex .. "[ " .. offset .. " ], UNIFORM" .. nUniformIndex .. "[ " .. offset + 1 .. " ], UNIFORM" .. nUniformIndex .. "[ " .. offset + 2 .. " ], UNIFORM" .. nUniformIndex .. "[ " .. offset + 3 .. " ] )\n"
		else
			ConstantString  = "// Constant define! " .. ConstantSize .. " \n"
		end
	else
		if ConstantSize == nil then
			ArrayConstants[ Name ] =  {1, nFloats, offset, "UNIFORM" .. nUniformIndex}
			ConstantString  = "// Array " .. Name .. " " .. nFloats ..  "\n"
			ConstantSize = 1
		elseif ConstantSize == "4" then
			ArrayConstants[ Name ] = {4, 4, offset, "UNIFORM" .. nUniformIndex}
			ConstantString  = "// Array " .. Name ..  " 4x4\n"
		else
			ConstantString  = "// Constant define! " .. ConstantSize .. " \n"
		end
	end
	return ConstantString, ConstantSize * ArraySize
end

function FixShaderConstants( ShaderToCompile )
	if ShaderToCompile == nil then
		return "// Lua bind is broken"
	end
	
	local bAddingConstants = false
	local nUniformSize = 0
	local nUniformIndex = 0
	
	local Constant = ""
	local Temp = ""
	for line in string.gmatch( ShaderToCompile, "[^\n]+" ) do
		
		if bAddingConstants then
			if string.find( line, "}" ) then
				Temp = Temp .. "\nuniform vec4 UNIFORM" .. nUniformIndex .. "[ " .. nUniformSize .. " ];\n" .. Constant
				bAddingConstants = false
			elseif not string.find( line, "{" ) then
				local nSize = 0
				local CurrentConstant = ""
				CurrentConstant, nSize = GetConstantData( line, nUniformSize, nUniformIndex )
				nUniformSize = nUniformSize + nSize
				Constant = Constant .. CurrentConstant		
			end
		else
			if string.find( line, "CONSTANT_BUFFER" ) then
				nUniformIndex = GetUniformData( line )
				bAddingConstants = true
				nUniformSize = 0
				Constant = ""
			else
				Temp = Temp .. line .. "\n"
			end
		end
	end
	
	for array_name, array_constant in pairs( ArrayConstants ) do
		if array_constant[1] == 1 then
				Temp = string.gsub( Temp, array_name .. "%[([^%]]*)%]", "float" .. array_constant[2] .. "( " .. array_constant[4] .. "[ " .. array_constant[ 3 ] .. " + ( %1 ) ])" )
		else
			Temp = string.gsub( Temp, array_name .. "%[([^%]]*)%]", "mat4( " .. array_constant[4] .. "[ " .. array_constant[ 3 ] .. " + 4 * ( %1 ) ], " .. 
			array_constant[4] .. "[ " .. array_constant[ 3 ] + 1 .. " + 4 * ( %1 ) ], " .. array_constant[4] .. "[ " .. array_constant[ 3 ] + 2 .. 
			" + 4 * ( %1 ) ], " .. array_constant[4] .. "[ " .. array_constant[ 3 ] + 3 .. " + 4 * ( %1 ) ] )" )
		end
	end
	return Temp
end

function AddSamplers()
-- texture tex0			: register( t0 );
-- sampler SimpleTexture	: register( s0 );
	local SamplerData = ""
	for name, sampler in pairs( Samplers ) do
		if sampler.Type == "Cube" then 
			SamplerData = SamplerData .. "\nuniform samplerCube tex" .. sampler.Index .. ";\n"
		else
			SamplerData = SamplerData .. "\nuniform sampler2D tex" .. sampler.Index .. ";\n"
		end
		SamplerData = SamplerData .. "#define " .. name .. " tex" .. sampler.Index .. "\n"
	end
	DeclareShared( SamplerData )
end