local current = ...
local chatPos = class("chatPos", function ()
	return display.newNode()
end)

function chatPos:ctor(h, labelM, mapData, user, noTouch)
	local common = import(".common", current)

	common.getMinimapTexture(mapData.mapID, function (tex)
		local h = labelM.wordSize.height * 2 - 2
		local w = h * 1.5

		if tex then
			local playerInThisMap, mapw, maph = nil

			if g_data.map.mapTitle == mapData.mapTitle and main_scene.ground.map.mapid == mapData.mapID then
				playerInThisMap = true
			end

			if playerInThisMap then
				maph = main_scene.ground.map.h
				mapw = main_scene.ground.map.w
			else
				local file = res.loadmap(mapData.mapID)
				maph = file:geth()
				mapw = file:getw()
			end

			local bg = display.newSprite(tex):anchor(0, 0):add2(self)
			local size = bg:getTexture():getContentSize()
			local percent = {
				x = size.width / mapw,
				y = size.height / maph
			}
			local x = math.max(0, mapData.x * percent.x - w / 2)
			local y = math.max(0, mapData.y * percent.y - h / 2)

			bg:setTextureRect(cc.rect(x, y, w, h))
		end

		res.get2("pic/panels/bigmap/p-green.png"):anchor(0.5, 0):pos(w / 2, h / 2):scale(0.5):add2(self)

		local frame = display.newScale9Sprite(res.getframe2("pic/scale/scale2.png"), 0, 0, cc.size(w, h)):anchor(0, 0):add2(self)

		if not noTouch then
			frame:enableClick(function ()
				if tex then
					main_scene.ui:hidePanel("bigmapOther")
					main_scene.ui:showPanel("bigmapOther", {
						tex = tex,
						mapData = mapData,
						user = user
					})
				else
					main_scene.ui:tip("û�п��õĵ�ͼ")
				end
			end)
		end

		local fontSize = math.min(labelM.fontSize, 18)
		local title = an.newLabel(mapData.mapTitle, fontSize, 1, {
			color = cc.c3b(0, 255, 255)
		}):pos(w + 2, h / 2):add2(self)
		local pos = an.newLabel(string.format("(%d, %d)", mapData.x, mapData.y), fontSize, 1, {
			color = cc.c3b(0, 255, 255)
		}):pos(w + 2, 0):add2(self)

		self:size(w + math.max(title:getw(), pos:getw()), h)
	end)
end

return chatPos
