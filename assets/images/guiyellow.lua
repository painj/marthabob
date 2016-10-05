-- Generated with TexturePacker (http://www.codeandweb.com/texturepacker)
-- with a custom export by Stewart Bracken (http://stewart.bracken.bz)
--
-- $TexturePacker:SmartUpdate:ad29fd45a5f0f582a7eeeb94cc077da9:a44f6878118d46a80431898b1f9d5cea:7939852fc0e90b672ac530606f145e17$
--
--[[------------------------------------------------------------------------
-- Example Usage --

function love.load()
	myAtlas = require("guiyellow")
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
local Texture = love.graphics.newImage( "guiyellow.png" )

Quads["border-down"] = love.graphics.newQuad(5, 222, 33, 26, 512, 256 )
Quads["border-left"] = love.graphics.newQuad(451, 143, 26, 33, 512, 256 )
Quads["border-right"] = love.graphics.newQuad(451, 182, 26, 33, 512, 256 )
Quads["border-up"] = love.graphics.newQuad(388, 143, 33, 26, 512, 256 )
Quads["buttonleft"] = love.graphics.newQuad(316, 5, 180, 63, 512, 256 )
Quads["buttonRight"] = love.graphics.newQuad(316, 74, 177, 63, 512, 256 )
Quads["corner0"] = love.graphics.newQuad(309, 156, 35, 34, 512, 256 )
Quads["corner1"] = love.graphics.newQuad(70, 216, 34, 35, 512, 256 )
Quads["corner2"] = love.graphics.newQuad(339, 196, 35, 34, 512, 256 )
Quads["corner3"] = love.graphics.newQuad(299, 200, 34, 35, 512, 256 )
Quads["fill"] = love.graphics.newQuad(350, 143, 32, 32, 512, 256 )
Quads["orn-0"] = love.graphics.newQuad(185, 210, 32, 38, 512, 256 )
Quads["orn-1"] = love.graphics.newQuad(223, 210, 32, 38, 512, 256 )
Quads["orn-2"] = love.graphics.newQuad(261, 210, 32, 38, 512, 256 )
Quads["orn-3"] = love.graphics.newQuad(271, 156, 32, 38, 512, 256 )
Quads["orn-4"] = love.graphics.newQuad(271, 80, 38, 32, 512, 256 )
Quads["orn-5"] = love.graphics.newQuad(271, 118, 38, 32, 512, 256 )
Quads["orn-6"] = love.graphics.newQuad(141, 151, 38, 32, 512, 256 )
Quads["orn-7"] = love.graphics.newQuad(141, 189, 38, 32, 512, 256 )
Quads["orn-8"] = love.graphics.newQuad(135, 80, 59, 65, 512, 256 )
Quads["orn-9"] = love.graphics.newQuad(5, 151, 59, 65, 512, 256 )
Quads["orn-10"] = love.graphics.newQuad(5, 80, 59, 65, 512, 256 )
Quads["orn-11"] = love.graphics.newQuad(70, 80, 59, 65, 512, 256 )
Quads["orn-12"] = love.graphics.newQuad(200, 80, 65, 59, 512, 256 )
Quads["orn-13"] = love.graphics.newQuad(200, 145, 65, 59, 512, 256 )
Quads["orn-14"] = love.graphics.newQuad(70, 151, 65, 59, 512, 256 )
Quads["orn-15"] = love.graphics.newQuad(380, 181, 65, 59, 512, 256 )
Quads["title-bar"] = love.graphics.newQuad(5, 5, 305, 69, 512, 256 )

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
