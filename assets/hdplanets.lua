-- Generated with TexturePacker (http://www.codeandweb.com/texturepacker)
-- with a custom export by Stewart Bracken (http://stewart.bracken.bz)
--
-- $TexturePacker:SmartUpdate:f49f2c3569c491600910b810a1eaa2bf:c266b5ed2842be44764c3764be3fb833:cba1b882190513ddff29e9d7841c0ed9$
--
--[[------------------------------------------------------------------------
-- Example Usage --

function love.load()
	myAtlas = require("hdplanets")
	batch = love.graphics.newSpriteBatch( myAtlas.texture, 100, "stream" )
end
function love.draw()
	batch:clear()
	batch:bind()
		batch:add( myAtlas.quads['mySpriteName'], love.mouse.getX(), love.mouse.getY() )
	batch:unbind()
	love.graphics.draw(batch)
end

--]]------------------------------------------------------------------------

local TextureAtlas = {}
local Quads = {}
local Texture = love.graphics.newImage( "assets/hdplanets.png" )

Quads["planet1"] = love.graphics.newQuad(1, 1, 129, 129, 786, 393 )
Quads["planet2"] = love.graphics.newQuad(132, 1, 123, 123, 786, 393 )
Quads["planet3"] = love.graphics.newQuad(257, 1, 124, 124, 786, 393 )
Quads["planet4"] = love.graphics.newQuad(383, 1, 125, 125, 786, 393 )
Quads["planet5"] = love.graphics.newQuad(510, 1, 125, 125, 786, 393 )
Quads["planet6"] = love.graphics.newQuad(637, 1, 125, 125, 786, 393 )
Quads["planet7"] = love.graphics.newQuad(1, 132, 129, 129, 786, 393 )
Quads["planet10"] = love.graphics.newQuad(132, 132, 129, 129, 786, 393 )
Quads["planet11"] = love.graphics.newQuad(263, 132, 129, 129, 786, 393 )
Quads["planet12"] = love.graphics.newQuad(394, 132, 129, 129, 786, 393 )
Quads["planet13"] = love.graphics.newQuad(525, 132, 129, 129, 786, 393 )
Quads["planet14"] = love.graphics.newQuad(656, 132, 129, 129, 786, 393 )
Quads["planet15"] = love.graphics.newQuad(1, 263, 129, 129, 786, 393 )
Quads["planet16"] = love.graphics.newQuad(132, 263, 129, 129, 786, 393 )
Quads["planet17"] = love.graphics.newQuad(263, 263, 129, 129, 786, 393 )
Quads["planet18_0"] = love.graphics.newQuad(394, 263, 129, 129, 786, 393 )
Quads["planet19"] = love.graphics.newQuad(525, 263, 129, 129, 786, 393 )
Quads["planet20"] = love.graphics.newQuad(656, 263, 129, 129, 786, 393 )

function TextureAtlas:getDimensions(quadName)
	local quad = self.quads[quadName]
	if not quad then
		return nil 
	end
	local x, y, w, h = quad:getViewport()
    return w, h
end

TextureAtlas.quads = Quads
TextureAtlas.texture = Texture

return TextureAtlas
