-- Generated with TexturePacker (http://www.codeandweb.com/texturepacker)
-- with a custom export by Stewart Bracken (http://stewart.bracken.bz)
--
-- $TexturePacker:SmartUpdate:1859cedb22b7b8871a70b19285bc2ee1:52078c29e54350370d6b4b63b05053bb:85097420ab0e145884869a55e393bf40$
--
--[[------------------------------------------------------------------------
-- Example Usage --

function love.load()
	myAtlas = require("planetatlas")
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
local Texture = love.graphics.newImage( "assets/planetatlas.png" )

Quads["huge-blue-1"] = love.graphics.newQuad(1, 1, 166, 166, 512, 1024 )
Quads["huge-purple-1"] = love.graphics.newQuad(169, 1, 166, 142, 512, 1024 )
Quads["large-blue-1"] = love.graphics.newQuad(337, 1, 118, 118, 512, 1024 )
Quads["large-brown-1"] = love.graphics.newQuad(1, 169, 142, 118, 512, 1024 )
Quads["large-brown-2"] = love.graphics.newQuad(145, 169, 118, 118, 512, 1024 )
Quads["large-green-1"] = love.graphics.newQuad(265, 169, 118, 118, 512, 1024 )
Quads["large-green-2"] = love.graphics.newQuad(385, 169, 118, 118, 512, 1024 )
Quads["large-purple-1"] = love.graphics.newQuad(1, 289, 142, 118, 512, 1024 )
Quads["large-red-1"] = love.graphics.newQuad(145, 289, 142, 118, 512, 1024 )
Quads["large-yellow-sun"] = love.graphics.newQuad(289, 289, 142, 142, 512, 1024 )
Quads["medium-blue-1"] = love.graphics.newQuad(1, 433, 118, 94, 512, 1024 )
Quads["medium-blue-2"] = love.graphics.newQuad(121, 433, 118, 94, 512, 1024 )
Quads["medium-blue-3"] = love.graphics.newQuad(241, 433, 118, 94, 512, 1024 )
Quads["medium-blue-4"] = love.graphics.newQuad(361, 433, 94, 94, 512, 1024 )
Quads["medium-blue-5"] = love.graphics.newQuad(1, 529, 94, 94, 512, 1024 )
Quads["medium-blue-6"] = love.graphics.newQuad(97, 529, 94, 94, 512, 1024 )
Quads["medium-brown-1"] = love.graphics.newQuad(193, 529, 94, 94, 512, 1024 )
Quads["medium-brown-2"] = love.graphics.newQuad(289, 529, 94, 94, 512, 1024 )
Quads["medium-green-1"] = love.graphics.newQuad(385, 529, 118, 94, 512, 1024 )
Quads["medium-green-2"] = love.graphics.newQuad(1, 625, 118, 94, 512, 1024 )
Quads["medium-green-3"] = love.graphics.newQuad(121, 625, 118, 94, 512, 1024 )
Quads["medium-grey-1"] = love.graphics.newQuad(241, 625, 118, 94, 512, 1024 )
Quads["medium-white-1"] = love.graphics.newQuad(361, 625, 118, 94, 512, 1024 )
Quads["medium-white-2"] = love.graphics.newQuad(1, 721, 118, 94, 512, 1024 )
Quads["small-blue-1"] = love.graphics.newQuad(121, 721, 94, 70, 512, 1024 )
Quads["small-blue-2"] = love.graphics.newQuad(217, 721, 70, 70, 512, 1024 )
Quads["small-grey-1"] = love.graphics.newQuad(289, 721, 70, 70, 512, 1024 )
Quads["small-grey-2"] = love.graphics.newQuad(361, 721, 70, 70, 512, 1024 )
Quads["small-grey-3"] = love.graphics.newQuad(433, 721, 70, 70, 512, 1024 )
Quads["small-purple-1"] = love.graphics.newQuad(1, 817, 70, 70, 512, 1024 )

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
