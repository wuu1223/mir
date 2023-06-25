local controlHeight = 110
local common = import("..common.common")
local bigmap = class("bigmap", function ()
	return display.newNode()
end)

table.merge(bigmap, {
	texSize,
	mapid,
	mapFile,
	mapw,
	maph,
	point,
	group,
	bgSprs,
	borderSpr,
	mapScale,
	mapNode,
	mapSpr,
	title,
	titleLabel,
	worldMapScale,
	worldMapNode,
	worldMapSpr,
	worldMode,
	findPathNode,
	findPathPoint,
	dest,
	destPoint,
	inputx,
	inputy,
	likeSpr,
	tabs,
	quickNode,
	npcScroll,
	handler
})

local minh = 350
local config = {
	["0"] = {
		title = "����ʡ",
		res = "biqi",
		x = 566,
		y = 397,
		spriteOffset = cc.p(0, -40),
		worldpos = cc.p(-563, 1077),
		signpos = {
			x = 570,
			y = 465
		}
	},
	["1"] = {
		title = "����ɭ��",
		res = "woma",
		x = 453,
		y = 591,
		spriteOffset = cc.p(8, 0),
		worldpos = cc.p(-448, 856),
		signpos = {
			x = 472,
			y = 647
		}
	},
	["2"] = {
		title = "����ɽ��",
		res = "dushe",
		x = 766,
		y = 463,
		spriteOffset = cc.p(-40, 50),
		worldpos = cc.p(-727, 942),
		signpos = {
			x = 730,
			y = 555
		}
	},
	["3"] = {
		title = "����ʡ",
		res = "mengzhong",
		x = 827,
		y = 576,
		spriteOffset = cc.p(-65, 118),
		worldpos = cc.p(-775, 825),
		signpos = {
			x = 764,
			y = 735
		}
	},
	["4"] = {
		title = "��ħ��",
		res = "fengmo",
		x = 274,
		y = 692,
		spriteOffset = cc.p(0, -20),
		worldpos = cc.p(-268, 783),
		signpos = {
			x = 270,
			y = 737
		}
	},
	["5"] = {
		title = "���µ�",
		res = "cangyue",
		x = 442,
		y = 1015,
		spriteOffset = cc.p(0, -30),
		worldpos = cc.p(-444, 464),
		signpos = {
			x = 445,
			y = 1025
		}
	},
	["6"] = {
		title = "ħ����",
		res = "molong",
		x = 1096,
		y = 435,
		spriteOffset = cc.p(10, -32),
		worldpos = cc.p(-1104, 1033),
		signpos = {
			x = 1105,
			y = 485
		}
	},
	["11"] = {
		title = "������",
		res = "bairi",
		x = 403,
		y = 779,
		spriteOffset = cc.p(20, -25),
		worldpos = cc.p(-417, 694),
		signpos = {
			x = 415,
			y = 825
		}
	},
	SLDG = {
		title = "�߽��",
		res = "bianjie",
		x = 650,
		y = 182,
		spriteOffset = cc.p(0, -30),
		worldpos = cc.p(-646, 1259),
		signpos = {
			x = 645,
			y = 280
		}
	}
}

function bigmap:ctor(tex)
	self._supportMove = true

	self:setNodeEventEnabled(true)

	function self.onCleanup()
		self:unloadMapFile()
		self:unscheduleHandle()
	end

	local b1 = res.get2("pic/panels/bigmap/bg1.png"):anchor(0, 1):addTo(self, -1)
	local b2 = res.get2("pic/panels/bigmap/bg2.png"):anchor(0, 0):addTo(self, -1)
	local b3 = res.get2("pic/panels/bigmap/bg3.png"):anchor(0, 0):addTo(self, -1)
	self.bgSprs = {
		b1,
		b2,
		b3
	}

	res.get2("pic/panels/bigmap/map.png"):addTo(b1):pos(b1:getw() / 2, b1:geth() / 2 + 12):anchor(0.5, 0.5)

	local sprs = {
		"pic/panels/bigmap/tab_world.png",
		"pic/panels/bigmap/tab_local.png"
	}
	self.tabs = common.tabs(b1, {
		ox = 3,
		oy = 10,
		sprs = sprs
	}, function (idx, btn)
		if idx == 1 then
			self:change2WorldMap()
		elseif idx == 2 then
			self:change2LocalMap()
		end
	end, {
		tabTp = 1,
		pos = {
			offset = 70,
			x = 1,
			y = b1:geth() - 82,
			anchor = cc.p(1, 0.5)
		},
		default = {
			var = 2,
			manual = true
		}
	})
	self.controlNode = display.newNode():addTo(b3):pos(0, 0)

	an.newLabel("X:", 20, 1, {
		color = cc.c3b(255, 255, 0)
	}):anchor(0, 0.5):pos(27, b3:geth() / 2 - 2):addTo(self.controlNode)

	self.inputx = an.newInput(52, b3:geth() / 2 - 7, 86, 32, 4, {
		label = {
			"",
			20,
			1
		},
		bg = {
			h = 32,
			tex = res.gettex2("pic/scale/edit.png"),
			offset = {
				-3,
				4
			}
		},
		stop_call = function ()
			local num = tonumber(self.inputx:getText()) or 0
			local w, h = self:mapSize()

			if num < 0 then
				num = 0
			end

			if w < num then
				num = w or num
			end

			self:setDestPoint(num)
		end
	}):addTo(self.controlNode):anchor(0, 0.5)

	an.newLabel("Y:", 20, 1, {
		color = cc.c3b(255, 255, 0)
	}):anchor(0, 0.5):pos(140, b3:geth() / 2 - 2):addTo(self.controlNode)

	self.inputy = an.newInput(165, b3:geth() / 2 - 7, 86, 32, 4, {
		label = {
			"",
			20,
			1
		},
		bg = {
			h = 32,
			tex = res.gettex2("pic/scale/edit.png"),
			offset = {
				-3,
				4
			}
		},
		stop_call = function ()
			local num = tonumber(self.inputy:getText()) or 0
			local w, h = self:mapSize()

			if num < 0 then
				num = 0
			end

			if h < num then
				num = h or num
			end

			self:setDestPoint(nil, num)
		end
	}):addTo(self.controlNode):anchor(0, 0.5)
	self.likeSpr = res.get2("pic/panels/bigmap/start_n.png"):enableClick(function (x, y)
		sound.playSound("103")

		local x = tonumber(self.inputx:getText())
		local y = tonumber(self.inputy:getText())

		repeat
			if not x or not y then
				main_scene.ui:tip("��Ч�����꣡")
			elseif self:canWalk(x, y).block then
				main_scene.ui:tip("Ŀ�����޷�����, �ղ�ʧ�ܣ�")
			elseif self.likeSpr.state then
				g_data.bigmap:removeLike(self.mapid, x, y)
				self:setLikeSprState(false)
				main_scene.ui:tip("�Ƴ��ղ�����ɹ�.")
			else
				local edit = nil
				local _, bg = common.msgbox("", {
					okFunc = function ()
						local str = edit:getText()

						if string.len(str) == 0 then
							main_scene.ui:tip("�������ղص�����֣�")

							return true
						else
							g_data.bigmap:addLike(self.mapid, str, x, y)
							self:setLikeSprState(true)
							main_scene.ui:tip("�ղ������ɹ�.")
						end
					end,
					title = res.gettex2("pic/panels/bigmap/quick.png")
				})

				an.newLabel("���ղصĵص��һ������", 20, 1, {
					color = def.colors.labelYellow
				}):addTo(bg):pos(bg:getw() / 2, 210):anchor(0.5, 0.5)

				edit = an.newInput(0, 0, 200, 45, 7, {
					bg = {
						h = 36,
						tex = res.gettex2("pic/scale/scale16.png"),
						offset = {
							-20,
							5
						}
					}
				}):addTo(bg):pos(bg:getw() / 2 + 20, bg:geth() / 2 + 15):anchor(0.5, 0.5)

				an.newLabel("�������ڿ��Ѱ·���ҵ����ղص�����", 16, 1, {
					color = def.colors.btn20
				}):addTo(bg):pos(bg:getw() / 2, 100):anchor(0.5, 0.5)

				return
			end
		until true
	end):addTo(self.controlNode):pos(260, b3:geth() / 2 - 2):anchor(0, 0.5)

	local function autopath()
		sound.playSound("103")

		local x = tonumber(self.inputx:getText())
		local y = tonumber(self.inputy:getText())

		if not x or not y then
			main_scene.ui:tip("��Ч�ĵ�ͼ���꣡")

			return
		end

		if self.mapid == main_scene.ground.map.mapid and self.dest.from == "npc" then
			y = y + 1
		end

		if self:canWalk(x, y).block then
			main_scene.ui:tip("Ŀ�����赲, �޷����")

			return
		end

		main_scene.ui.console.controller.autoFindPath:searching(x, y, self.mapid)
	end

	local function sdgo()
		sound.playSound("103")

		local x = tonumber(self.inputx:getText())
		local y = tonumber(self.inputy:getText())

		if not x or not y then
			main_scene.ui:tip("��Ч�ĵ�ͼ���꣡")

			return
		end

		if self.mapid ~= main_scene.ground.map.mapid then
			main_scene.ui:tip("�޷��ڲ�ͬ��ͼ�䴫�ͣ�")

			return
		end

		if self.dest.from == "npc" then
			y = y + 1
		end

		if main_scene.ground.map:canWalk(x, y).block then
			main_scene.ui:tip("Ŀ�����赲, �޷����ͣ�")

			return
		end

		if (not g_data.equip.items[7] or g_data.equip.items[7].getVar("name") ~= "���ͽ�ָ") and (not g_data.equip.items[8] or g_data.equip.items[8].getVar("name") ~= "���ͽ�ָ") then
			an.newMsgbox("��Ҫ������ͽ�ָ��", nil, {
				center = true
			})

			return
		end

		net.send({
			CM_SAY
		}, {
			"@sdgo " .. " " .. x .. " " .. y
		})
	end

	local function quickpath()
		sound.playSound("103")
		self:loadQuickPath()
	end

	local btns = {
		{
			sprite = "pic/panels/bigmap/tab_auto.png",
			posx = 535,
			click = autopath
		},
		{
			sprite = "pic/panels/bigmap/tab_transfer.png",
			posx = 435,
			click = sdgo
		},
		{
			sprite = "pic/panels/bigmap/tab_quick.png",
			posx = 335,
			click = quickpath
		}
	}

	for i, v in ipairs(btns) do
		an.newBtn(res.gettex2("pic/common/btn20.png"), v.click, {
			pressImage = res.gettex2("pic/common/btn21.png"),
			sprite = res.gettex2(v.sprite)
		}):anchor(0, 0.5):pos(v.posx, b3:geth() / 2 - 2):addTo(self.controlNode)
	end

	an.newBtn(res.gettex2("pic/common/close10.png"), function ()
		sound.playSound("103")
		self:hidePanel()
	end, {
		pressImage = res.gettex2("pic/common/close11.png"),
		size = cc.size(64, 64)
	}):anchor(1, 1):pos(b1:getw() - 9, b1:geth() - 9):addTo(b1)
	self:loadLocalMap()

	local autoFindPath = main_scene.ui.console.controller.autoFindPath
	local pathDestX = autoFindPath.destx
	local pathDestY = autoFindPath.desty

	self:schedule(function ()
		if autoFindPath.points and (pathDestX ~= autoFindPath.destx or pathDestY ~= autoFindPath.desty) then
			self:loadFindPath()
		end
	end, 0.1)
end

function bigmap:reset(size)
	self:size(self.bgSprs[1]:getw(), size.height + controlHeight):anchor(0.5, 0.5):center()
	self.bgSprs[1]:pos(0, self:geth())
	self.bgSprs[2]:pos(0, self.bgSprs[3]:geth()):scaleY((self:geth() - self.bgSprs[1]:geth() - self.bgSprs[3]:geth()) / self.bgSprs[2]:geth())

	if self._touchFrames and self._touchFrames.main then
		local rect = cc.rect(0, 0, self:getw(), self:geth())

		self:addTouchFrame(rect, "main")
	end
end

function bigmap:loadFindPath()
	self:loadFindPathPoint(main_scene.ui.console.controller.autoFindPath.points)

	local point = main_scene.ui.console.controller.autoFindPath.points[#main_scene.ui.console.controller.autoFindPath.points]

	if not main_scene.ui.console.autoRat.enableRat then
		self:loadDestPoint(point.x, point.y, {
			noAction = true
		})
	end
end

function bigmap:loadLocalMap(param)
	self.controlNode:show()
	self:unloadMapFile()

	if param and param.switch then
		self.mapid = param.id
		self.title = param.title

		self:loadMapFile()

		self.maph = self.mapFile:geth()
		self.mapw = self.mapFile:getw()
	else
		self.mapid = main_scene.ground.map.mapid
		self.title = g_data.map.mapTitle
		self.maph = main_scene.ground.map.h
		self.mapw = main_scene.ground.map.w
	end

	common.getMinimapTexture(self.mapid, function (tex)
		local maxw = 615
		local maxh = 450
		self.texSize = tex:getContentSize()
		self.mapScale = math.min(maxw / self.texSize.width, maxh / self.texSize.height)
		local mapSize = cc.size(self.texSize.width * self.mapScale, self.texSize.height * self.mapScale)
		local resetSize = cc.size(mapSize.width, mapSize.height)
		local offsetX = 0
		local offsetY = 0

		if maxh <= mapSize.height and mapSize.width < maxw then
			offsetX = (self.bgSprs[1]:getw() - 26 - mapSize.width) / 2
		elseif maxw <= mapSize.width and mapSize.height < minh then
			resetSize.height = minh
			offsetY = (minh - mapSize.height) / 2
		end

		self:reset(resetSize)

		self.mapNode = display.newNode():pos(13 + offsetX, 60 + offsetY):size(mapSize):addTo(self, 1)
		self.mapSpr = display.newSprite(tex):scale(self.mapScale):anchor(0, 0):addTo(self.mapNode)

		display.newScale9Sprite(res.getframe2("pic/scale/scale27.png"), 0, 0, mapSize):anchor(0, 0):addTo(self.mapNode)

		self.titleLabel = an.newLabel(self.title, 20, 1, {
			color = display.COLOR_WHITE
		}):addTo(self.mapNode):pos(5, 5):anchor(0, 0)

		self:loadEntryInfo()
		self:pointUpt(main_scene.ground.map, main_scene.ground.player)

		if main_scene.ui.console.controller.autoFindPath.points then
			self:loadFindPath()
		end

		local hasMove, handler = nil
		local doubleClick = false

		local function click(event)
			local rect1 = self:getBoundingBox()
			local rect2 = self.mapNode:getBoundingBox()
			local x, y = self:gamePos(event.x - rect1.x - rect2.x, event.y - rect1.y - rect2.y)
			local point = self:canWalk(x, y)

			if doubleClick then
				if not point.block then
					main_scene.ui.console.controller.autoFindPath:searching(x, y, self.mapid)
				else
					main_scene.ui:tip("Ŀ�����赲, �޷����")
				end
			end

			handler = nil
			doubleClick = nil
		end

		local touchNode = display.newNode():size(self.mapNode:getContentSize()):addto(self.mapNode)

		touchNode:setTouchEnabled(true)
		touchNode:addNodeEventListener(cc.NODE_TOUCH_EVENT, function (event)
			local rect1 = self:getBoundingBox()
			local rect2 = self.mapNode:getBoundingBox()
			local x = event.x - rect1.x - rect2.x
			local y = event.y - rect1.y - rect2.y

			if event.name == "began" then
				if handler then
					doubleClick = true

					return false
				end

				return true
			elseif event.name == "moved" then
				hasMove = true
			elseif event.name == "ended" then
				local pos = self:convertToNodeSpace(cc.p(event.x, event.y))

				if cc.rectContainsPoint(self.mapNode:getBoundingBox(), cc.p(pos.x, pos.y)) then
					self:setDestPoint(self:gamePos(x, y))

					if not hasMove then
						handler = scheduler.performWithDelayGlobal(function ()
							click(event)
						end, 0.25)
					end
				end

				hasMove = false
			end
		end)
	end)

	if self.mapid == main_scene.ground.map.mapid then
		net.send({
			CM_MEMBERS_POSITION_INFO
		})
		self:unscheduleHandle()

		self.handler = scheduler.scheduleGlobal(function ()
			if table.nums(g_data.player.groupMembers) > 0 then
				net.send({
					CM_MEMBERS_POSITION_INFO
				})
			end
		end, 1)
	end
end

function bigmap:loadWorldMap()
	self.controlNode:hide()

	local localh = self.texSize.height * self.mapScale
	local worldMapSize = cc.size(615, localh < minh and minh - 2 or localh)
	self.worldMapScale = 0.75
	self.worldMapNode = an.newScroll(14, 61, worldMapSize.width, worldMapSize.height, {
		dir = 0
	}):addTo(self, 1)

	self.worldMapNode.scrollView:setBounceable(false)

	self.worldMapSpr = res.get2("pic/panels/bigmap/bg4.png"):addTo(self.worldMapNode):scale(self.worldMapScale):anchor(0, 1):pos(0, worldMapSize.height)
	self.borderSpr = display.newScale9Sprite(res.getframe2("pic/scale/scale27.png"), 13, 60, cc.size(worldMapSize.width + 2, worldMapSize.height + 2)):anchor(0, 0):addTo(self, 2)

	local function checkScrollPos(pos)
		local x = pos.x * self.worldMapScale
		local y = pos.y * self.worldMapScale
		x = x + worldMapSize.width / 2

		if x > 0 then
			x = 0
		end

		if math.abs(x - worldMapSize.width) > self.worldMapSpr:getw() * self.worldMapScale then
			x = worldMapSize.width - self.worldMapSpr:getw() * self.worldMapScale or x
		end

		y = y + worldMapSize.height / 2

		if y < worldMapSize.height then
			y = worldMapSize.height or y
		end

		if y > self.worldMapSpr:geth() * self.worldMapScale then
			y = self.worldMapSpr:geth() * self.worldMapScale or y
		end

		return x, y
	end

	local scrollpos = nil

	if config[self.mapid] then
		res.get2("pic/panels/bigmap/p-blue.png"):addTo(self.worldMapSpr, 1):pos(config[self.mapid].signpos.x, config[self.mapid].signpos.y)
		self.worldMapNode.scrollView:scrollTo(checkScrollPos(config[self.mapid].worldpos))
	else
		self.worldMapNode.scrollView:scrollTo(checkScrollPos(config["0"].worldpos))
	end

	for k, v in pairs(config) do
		local exactTouchInst = exactTouch:create(res.getfile("pic/panels/bigmap/btn-" .. v.res .. ".png"))
		local area = nil
		area = an.newBtn(res.gettex2("pic/panels/bigmap/btn-" .. v.res .. ".png"), function ()
			area.sprite:setTex(res.gettex2("pic/panels/bigmap/labeln-" .. v.res .. ".png"))
			self.tabs.click(2, true)
			self:change2LocalMap({
				switch = true,
				id = k,
				title = v.title
			})
		end, {
			pressShow = true,
			support = "scroll",
			pressBig = 1.001,
			sprite = res.gettex2("pic/panels/bigmap/labeln-" .. v.res .. ".png"),
			spriteOffset = v.spriteOffset,
			customTouchCheck = function (x, y)
				local p = area:convertToNodeSpace(cc.p(x, y))

				return exactTouchInst:containsPoint(p.x, p.y)
			end,
			call_remove = function ()
				exactTouchInst:release()
			end
		}):addTo(self.worldMapSpr):pos(v.x, v.y):anchor(0.5, 0.5)
	end

	an.newBtn(res.gettex2("pic/common/btn20.png"), function ()
		local x, y = self.worldMapNode.scrollView.scrollNode:getPosition()

		print(x, y)
	end, {
		pressImage = res.gettex2("pic/common/btn21.png"),
		label = {
			"��ȡ����",
			20,
			1
		}
	}):addTo(self):pos(10, 10):anchor(0, 0)
end

function bigmap:loadQuickPath()
	local node = display.newNode():addTo(main_scene.ui, main_scene.ui.z.detail):size(display.width, display.height):anchor(0.5, 0.5):center()
	self.quickNode = node
	local bg = res.get2("pic/panels/bigmap/quick-bg.png"):addTo(node):pos(node:getw() / 2, node:geth() / 2):anchor(0.5, 0.5)

	res.get2("pic/panels/bigmap/quick.png"):addTo(bg):pos(bg:getw() / 2, bg:geth() - 20):anchor(0.5, 0.5)
	an.newBtn(res.gettex2("pic/common/close10.png"), function ()
		sound.playSound("103")
		node:removeSelf()

		node = nil
	end, {
		pressImage = res.gettex2("pic/common/close11.png"),
		size = cc.size(64, 64)
	}):anchor(1, 1):pos(bg:getw() - 4, bg:geth() - 3):addTo(bg)
	display.newScale9Sprite(res.getframe2("pic/scale/scale16.png"), 0, 0, cc.size(165, 260)):addTo(bg):pos(112, 15):anchor(0, 0)

	local isFromNpc = false
	local list = display.newNode():addTo(bg)

	local function createList(key)
		list:removeAllChildren()

		local scroll = an.newScroll(115, 17, 160, 255):addTo(list):anchor(0, 0)
		local data = {}

		if key == "NPC" then
			self.npcScroll = scroll

			scroll:setNodeEventEnabled(true)

			function scroll.onCleanup()
				self.npcScroll = nil
			end

			local npcs = g_data.bigmap:getNpcs(self.title)

			if not npcs then
				g_data.client:setLastNpcMap({
					title = self.title,
					id = self.mapid
				})

				if self.mapid == main_scene.ground.map.mapid then
					net.send({
						CM_QUERY_MAP_NPC,
						param = 0
					})
				else
					net.send({
						CM_QUERY_MAP_NPC,
						param = 1
					}, {
						self.mapid
					})
				end
			else
				isFromNpc = true
			end

			data = npcs or {}
		elseif key == "transform" then
			for i, v in pairs(def.map.transferPositions) do
				local var = string.split(i, "-")

				if var[1] == self.mapid then
					data[#data + 1] = {
						id = var[1],
						name = v.name,
						x = v.x,
						y = v.y,
						destMapid = var[2]
					}
				end
			end
		else
			local likes = g_data.bigmap:getLikes(self.mapid)

			if likes then
				if self.mapid == main_scene.ground.map.mapid then
					data = likes
				else
					for i, v in ipairs(likes) do
						data[#data + 1] = {
							name = v.name,
							x = v.x,
							y = v.y,
							destMapid = self.mapid
						}
					end
				end
			end
		end

		self:createCell(data, scroll, isFromNpc)
	end

	local sprs = {
		"pic/panels/bigmap/tab_npc.png",
		"pic/panels/bigmap/tab_point.png",
		"pic/panels/bigmap/tab_collect.png"
	}

	common.tabs(bg, {
		sprs = sprs
	}, function (idx, btn)
		createList(({
			"NPC",
			"transform",
			"like"
		})[idx])
	end, {
		tabTp = 2,
		scale = 0.8,
		pos = {
			x = 15,
			offset = 45,
			y = 230,
			anchor = cc.p(0, 0)
		}
	})
	node:setTouchEnabled(true)
	node:setTouchSwallowEnabled(true)
	node:addNodeEventListener(cc.NODE_TOUCH_EVENT, function (event)
		if event.name == "began" and not cc.rectContainsPoint(bg:getBoundingBox(), cc.p(event.x, event.y)) then
			node:removeSelf()

			node = nil
		end
	end)
end

function bigmap:createCell(data, scroll, fromNpc)
	for i, v in ipairs(data) do
		local y = 260 - (i - 1) * 44 - 30

		an.newBtn(res.gettex2("pic/panels/bigmap/label_n.png"), function (btn)
			sound.playSound("103")
			main_scene.ui.console.controller.autoFindPath:searching(v.x, fromNpc and v.y + 1 or v.y, v.destMapid)
			self.quickNode:removeSelf()
		end, {
			support = "scroll",
			pressImage = res.gettex2("pic/panels/bigmap/label_s.png"),
			label = {
				v.name,
				20,
				1,
				{
					color = def.colors.btn30
				}
			}
		}):addTo(scroll):pos(80, y):anchor(0.5, 0.5)
	end
end

function bigmap:uptNpcCell()
	if self.npcScroll then
		local data = g_data.bigmap:getNpcs(self.title)

		if data then
			self:createCell(data, self.npcScroll, true)
		end
	end
end

function bigmap:uptGroupPos()
	if self.group then
		for i, v in ipairs(self.group) do
			v:removeSelf()
		end
	end

	self.group = {}

	for i, v in ipairs(g_data.bigmap.group) do
		local x, y = self:mapPos(v.x, v.y)
		local point = display.newColorLayer(def.colors.get(250, true)):addTo(self.mapNode, 1):size(6, 6)

		point:pos(x - point:getw() / 2, y - point:geth() / 2)

		local label = an.newLabel(v.name, 14, 1, {
			color = display.COLOR_GREEN
		}):addTo(point)

		label:pos(point:getw() / 2, point:geth() / 2 + 2):anchor(0.5, 0)

		self.group[#self.group + 1] = point
	end
end

function bigmap:loadEntryInfo()
	local info = def.bigmap[tostring(self.mapid)]

	if info then
		for i, v in ipairs(info) do
			an.newLabel(v[2], 16, 2, {
				color = def.colors.text
			}):addTo(self.mapNode):pos(self:mapPos(v[3], v[4])):anchor(0.5, 0.5)
		end
	end
end

function bigmap:loadDestPoint(x, y, params)
	if not self.dest then
		self.dest = {}
	end

	local form = params.from
	local noAction = params.noAction
	self.dest.x = x or self.dest.x or 0
	self.dest.y = y or self.dest.y or 0
	self.dest.from = from
	x, y = self:mapPos(self.dest.x, self.dest.y)

	if not self.destPoint then
		self.destPoint = res.get2("pic/panels/bigmap/p-blue.png"):anchor(0.5, 0):addTo(self.mapNode, 1)
	end

	if self:canWalk(self.dest.x, self.dest.y).block then
		self.destPoint:setTex(res.gettex2("pic/panels/bigmap/p-red.png"))
		self:setLikeSprState(false)
	else
		self.destPoint:setTex(res.gettex2("pic/panels/bigmap/p-blue.png"))

		if g_data.bigmap:isExistLike(self.mapid, self.dest.x, self.dest.y) then
			self:setLikeSprState(true)
		else
			self:setLikeSprState(false)
		end
	end

	self.destPoint:stopAllActions()

	if noAction then
		self.destPoint:pos(x, y):show()
	else
		self.destPoint:pos(x, self.mapNode:geth()):show()
		self.destPoint:moveTo(0.1, x, y)
	end
end

function bigmap:mapSize()
	local w, h = nil

	if self.mapid ~= main_scene.ground.map.mapid then
		h = self.maph
		w = self.mapw
	else
		h = main_scene.ground.map.h
		w = main_scene.ground.map.w
	end

	return w, h
end

function bigmap:mapPos(x, y)
	local w, h = self:mapSize()
	local percent = {
		x = self.texSize.width / w * self.mapScale,
		y = self.texSize.height / h * self.mapScale
	}

	return x * percent.x, (h - y - 1) * percent.y
end

function bigmap:gamePos(x, y)
	local w, h = self:mapSize()
	local percent = {
		x = self.texSize.width / w * self.mapScale,
		y = self.texSize.height / h * self.mapScale
	}

	return math.modf(x / percent.x), math.modf(h - y / percent.y - 1)
end

function bigmap:setDestPoint(x, y, from)
	self:loadDestPoint(x, y, {
		from = from
	})
	self.inputx:setString(self.dest.x .. "")
	self.inputy:setString(self.dest.y .. "")
	main_scene.ui.console.controller.autoFindPath:multiMapPathStop()
end

function bigmap:canWalk(gamex, gamey)
	local ret = nil

	if self.mapid ~= main_scene.ground.map.mapid then
		ret = {}
		local data = self.mapFile:gettile(gamex, gamey)

		if data then
			if ycFunction:band(data.doorIndex, 128) > 0 and not data.doorOpen then
				ret.block = "door"
				ret.data = data
			elseif not data.canWalk then
				ret.block = "map"
			end
		end
	else
		ret = main_scene.ground.map:canWalk(gamex, gamey)
	end

	return ret
end

function bigmap:removeAllFindPath()
	if self.worldMode or not self.mapNode then
		return
	end

	if self.findPathNode then
		self.findPathNode:removeSelf()

		self.findPathNode = nil
	end

	self.findPathPoint = nil
end

function bigmap:removePoint(key)
	if self.worldMode or not self.mapNode then
		return
	end

	if self.findPathPoint and self.findPathPoint[key] then
		self.findPathPoint[key]:removeSelf()

		self.findPathPoint[key] = nil
	end
end

if DEBUG > 0 then
	function bigmap:loadFlagPoints(type, points, color)
		if self.worldMode or self.mapid ~= main_scene.ground.map.mapid then
			return
		end

		self.flagPoints = self.flagPoints or {}

		if not tolua.isnull(self.flagPoints[type]) then
			self.flagPoints[type]:removeSelf()
		end

		self.flagPoints[type] = display.newNode():size(self.mapNode:getContentSize()):addTo(self.mapNode)
		local findPathNode = self.flagPoints[type]
		local autoFindPath = main_scene.ui.console.controller.autoFindPath

		for i, v in ipairs(points) do
			local point = display.newColorLayer(color or cc.c4b(0, 0, 255, 255)):size(4, 4):addTo(findPathNode)
			local x, y = self:mapPos(v.x, v.y)

			point:pos(x - self.point:getw() / 2, y - self.point:geth() / 2)
		end

		return findPathNode
	end
end

function bigmap:loadFindPathPoint(points)
	if self.worldMode or self.mapid ~= main_scene.ground.map.mapid then
		return
	end

	self:removeAllFindPath()

	self.findPathNode = display.newNode():size(self.mapNode:getContentSize()):addTo(self.mapNode)
	self.findPathPoint = {}
	local autoFindPath = main_scene.ui.console.controller.autoFindPath

	for i, v in ipairs(points) do
		local point = display.newColorLayer(cc.c4b(0, 255, 255, 255)):size(4, 4):addTo(self.findPathNode)
		local x, y = self:mapPos(v.x, v.y)

		point:pos(x - self.point:getw() / 2, y - self.point:geth() / 2)

		self.findPathPoint[autoFindPath:key(v.x, v.y)] = point
	end
end

function bigmap:pointUpt(map, player)
	if self.worldMode or self.mapid ~= main_scene.ground.map.mapid then
		return
	end

	if not self.point then
		self.point = display.newColorLayer(def.colors.get(251, true)):addTo(self.mapNode, 1):size(6, 6)
	end

	local x, y = self:mapPos(player.x, player.y)

	self.point:pos(x - self.point:getw() / 2, y - self.point:geth() / 2)
end

function bigmap:resetInput()
	self.inputx:setString("")
	self.inputy:setString("")
end

function bigmap:loadMapFile()
	self.mapFile = res.loadmap(self.mapid)
end

function bigmap:unloadMapFile()
	if self.mapFile then
		res.unLoadmap(self.mapid)

		self.mapFile = nil
	end
end

function bigmap:removeLocalMap()
	if self.mapNode then
		self.mapNode:removeSelf()

		self.mapNode = nil
		self.findPathNode = nil
		self.point = nil
		self.findPathPoint = nil
		self.destPoint = nil
		self.titleLabel = nil
		self.group = nil

		self:unscheduleHandle()
	end
end

function bigmap:removeWorldMap()
	if self.worldMapNode then
		self.worldMapNode:removeSelf()

		self.worldMapNode = nil

		self.borderSpr:removeSelf()

		self.borderSpr = nil
	end
end

function bigmap:change2WorldMap()
	if self.worldMode then
		return
	end

	self.worldMode = true

	self:resetInput()
	self:removeLocalMap()
	self:loadWorldMap()
end

function bigmap:change2LocalMap(param)
	if not self.worldMode then
		return
	end

	self.worldMode = false

	self:resetInput()
	self:removeWorldMap()
	self:loadLocalMap(param)
end

function bigmap:change2CurMap()
	self:resetInput()
	self:removeLocalMap()
	self:loadLocalMap()
end

function bigmap:setLikeSprState(state)
	self.likeSpr:setTex(res.gettex2(state and "pic/panels/bigmap/start_s.png" or "pic/panels/bigmap/start_n.png"))

	self.likeSpr.state = state
end

function bigmap:updateTitle()
	if self.worldMode or not self.titleLabel then
		return
	end

	self.title = g_data.map.mapTitle

	self.titleLabel:setString(g_data.map.mapTitle)
end

function bigmap:unscheduleHandle()
	if self.handler then
		scheduler.unscheduleGlobal(self.handler)

		self.handler = nil
	end
end

return bigmap
