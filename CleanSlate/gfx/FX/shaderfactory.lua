function DeclareShader( name, source )
	local nLine = debug.getinfo(2).currentline + 1;
	local FileName = debug.getinfo(2).source;
	local FileStart = string.find( FileName, "@" );
	if ( not FileStart == nil ) then
		FileName = string.sub( FileName, FileStart, -1 )
	end
	local LineInfo = "#line " .. nLine .. " \"" .. FileName .. "\"\n"
	_G[name] = LineInfo .. source;
end

function DeclareShared( source )
	local nLine = debug.getinfo(2).currentline + 1;
	local FileName = debug.getinfo(2).source;
	local FileStart = string.find( FileName, "@" );
	if ( not FileStart == nil ) then
		FileName = string.sub( FileName, FileStart, -1 )
	end
	local LineInfo = "#line " .. nLine .. " \"" .. FileName .. "\"\n"
	if _G[ "Shared" ] == nil then
		_G[ "Shared" ] = LineInfo .. source
	else	
		_G[ "Shared" ] = LineInfo .. source .. "\n" ..  _G[ "Shared" ]
	end
end

-- let's us find the vertex data
function DeclareVertex( source )
	DeclareShared( source );
end


function AddSamplers()
-- texture tex0			: register( t0 );
-- sampler SimpleTexture	: register( s0 );
	local SamplerData = ""
	for name, sampler in pairs( Samplers ) do
		SamplerData = SamplerData .. "texture tex" .. sampler.Index .. " : register( t" .. sampler.Index .. " );\n"
		SamplerData = SamplerData .. "sampler " .. name .. " : register( s" .. sampler.Index .. " );\n"
	end
	DeclareShared( SamplerData )
end

function GetUniformData( line )
	local nStartIndex = string.match( line, "CONSTANT_BUFFER%s*%(%s*%d%s*,%s*(%d*)" )
	return nStartIndex
end


function GetConstantData( line, nUniformIndex )
	local ConstantString
	local ConstantSize = 1
	local ConstantType
	local Name = ""
	ConstantType, Name = string.match( line, "%s*(%S*)%s*(%S*)%s*;" )
	
	local ArraySize = string.match( line, "%[%s*(%d*)%s*%]" )
	if ArraySize == nil then
		ArraySize = 1
	end
	
	ConstantSize = string.match( line, "float%dx(%d)" )
	if  ConstantSize == nil then
		ConstantSize = 1
	end
	return ConstantType .. " " .. Name .. " : register( c" .. nUniformIndex .. " );\n" , ConstantSize * ArraySize
end

function FixShaderConstants( ShaderToCompile )
	if ShaderToCompile == nil then
		return "// Lua bind is broken"
	end
	
	local bAddingConstants = false
	local nStartRegister = 0
	
	local Constant = ""
	local Temp = ""
	for line in string.gmatch( ShaderToCompile, "[^\n]+" ) do
		
		if bAddingConstants then
			if string.find( line, "}" ) then
				Temp = Temp .. Constant
				bAddingConstants = false
			elseif not string.find( line, "{" ) then
				local nSize = 0
				local CurrentConstant = ""
				CurrentConstant, nSize = GetConstantData( line, nStartRegister )
				nStartRegister = nStartRegister + nSize
				Constant = Constant .. CurrentConstant		
			end
		else
			if string.find( line, "CONSTANT_BUFFER" ) then
				nStartRegister = GetUniformData( line )
				bAddingConstants = true
				nUniformSize = 0
				Constant = "// Start: " .. nStartRegister .. "\n"
			else
				Temp = Temp .. line .. "\n"
			end
		end
	end
	return Temp
end
