local common = import("..common.common")
local item = import("..common.item")
local stallOther = class("stallOther", function ()
	return display.newNode()
end)

table.merge(stallOther, {})

function stallOther:resetPanelPosition(type)
	if type == "left" then
		self:anchor(1, 0.5):pos(display.cx - 70, display.cy + 50)
	end

	return self
end

function stallOther:ctor()
	self._supportMove = true
	self.items = {}
	self.sItem = nil

	self:showStallPanel()
end

function stallOther:showStallPanel()
	self.bg = res.get2("pic/panels/stall/bg1.png"):addTo(self):anchor(0, 0)

	res.get2("pic/panels/stall/title.png"):addTo(self.bg):anchor(0.5, 0.5):pos(self.bg:getw() / 2, self.bg:geth() - 23)
	self:size(self.bg:getContentSize()):resetPanelPosition("left")

	local namebg = display.newScale9Sprite(res.getframe2("pic/scale/edit.png"), self.bg:getw() / 2, 381, cc.size(231, 32)):addTo(self.bg):anchor(0.5, 0.5)

	an.newLabel(g_data.stallOther.name, 20, 1, {
		color = def.colors.labelGray
	}):addTo(self.bg):pos(self.bg:getw() / 2, 381):anchor(0.5, 0.5)
	self:createItemsPanel()

	for i, v in ipairs(g_data.stallOther.items) do
		self:addItem(v.info:get("makeIndex"))
	end

	an.newBtn(res.gettex2("pic/common/btn20.png"), function ()
		sound.playSound("103")

		if not self.sItem then
			main_scene.ui:tip("����ѡ����Ҫ�������Ʒ")
		else
			self:showBuyPanel()
		end
	end, {
		pressImage = res.gettex2("pic/common/btn21.png"),
		sprite = res.gettex2("pic/panels/stall/buy.png")
	}):addTo(self.bg):pos(self.bg:getw() / 2 - 20, 55):anchor(1, 0)
	an.newBtn(res.gettex2("pic/common/btn20.png"), function ()
		sound.playSound("103")

		local input = nil
		local _, bg = common.msgbox("", {
			okFunc = function ()
				repeat
					local str = input:getText()

					if string.utf8len(str) <= 0 then
						main_scene.ui:tip("������������Ϣ.")
					elseif string.utf8len(str) > 25 then
						main_scene.ui:tip("������Ϣ����.")
					else
						net.send({
							CM_MESSAGE_STALL
						}, nil, getRecord("TStallMsg", {
							id = g_data.stallOther.id,
							msg = str
						}))

						return
					end
				until true

				return true
			end
		})

		an.newLabel("������������Ϣ", 20, 1):addTo(bg):pos(bg:getw() / 2, 180):anchor(0.5, 0.5)

		input = an.newInput(bg:getw() / 2, 140, 250, 36, 25, {
			bg = {
				h = 36,
				tex = res.gettex2("pic/scale/edit.png")
			}
		}):addTo(bg):anchor(0.5, 0.5)
	end, {
		pressImage = res.gettex2("pic/common/btn21.png"),
		sprite = res.gettex2("pic/panels/stall/msg.png")
	}):addTo(self.bg):pos(self.bg:getw() / 2 + 20, 55):anchor(0, 0)
	an.newBtn(res.gettex2("pic/common/close10.png"), function ()
		sound.playSound("103")
		self:hidePanel()
	end, {
		pressImage = res.gettex2("pic/common/close11.png"),
		size = cc.size(64, 64)
	}):addTo(self.bg):anchor(1, 1):pos(self.bg:getw() - 5, self.bg:geth() - 5)
end

function stallOther:createItemsPanel()
	if self.bg.node then
		self.bg.node:removeSelf()
	end

	self.bg.node = display.newNode():addTo(self.bg)
	local w = 245
	local h = ({
		57,
		104,
		153,
		199
	})[g_data.stallOther.level]

	display.newScale9Sprite(res.getframe2("pic/scale/scale27.png"), 0, 0, cc.size(w, h)):anchor(0, 0):addTo(self.bg.node):anchor(0.5, 1):pos(self.bg:getw() / 2, 356)

	for i = 1, g_data.stallOther.level do
		res.get2("pic/panels/stall/items.png"):addTo(self.bg.node):pos(self.bg:getw() / 2, 397 - i * 47):anchor(0.5, 1)
	end
end

function stallOther:showBuyPanel()
	local i, v = g_data.stallOther:getItem(self.sItem.data:get("makeIndex"))
	local data = v.info
	local cnt = 1
	local noError = true
	local tips, bg = nil

	local function addTips()
		if tips then
			tips:removeSelf()
		end

		local str = "�Ƿ���" .. v.price * cnt .. (v.type == 0 and "���" or "Ԫ��") .. "�ļ۸������Ʒ"
		tips = an.newLabel(str, 20, 1, {
			color = display.COLOR_WHITE
		}):addTo(bg):pos(bg:getw() / 2, 200):anchor(0.5, 0.5)
	end

	_, bg = common.msgbox("", {
		okFunc = function ()
			if noError then
				self.sItem.mask:removeSelf()

				self.sItem = nil

				net.send({
					CM_BUY_STALLITEM,
					recog = data:get("makeIndex"),
					series = cnt
				}, nil, {
					{
						"ID",
						g_data.stallOther.id
					}
				})
			else
				main_scene.ui:tip("��������ȷ������!")

				return true
			end
		end
	})

	addTips()
	res.get2("pic/common/itembg3.png"):addTo(bg):pos(125, 150)
	res.get("items", data.getVar("looks")):addTo(bg):pos(125, 150)
	an.newLabel("�۸� :", 18, 1, {
		color = display.COLOR_WHITE
	}):addTo(bg):pos(180, 165):anchor(0, 0.5)
	an.newLabel(v.price .. (v.type == 0 and "���" or "Ԫ��"), 18, 1, {
		color = display.COLOR_WHITE
	}):addTo(bg):pos(250, 165):anchor(0, 0.5)
	an.newLabel("���� : ", 18, 1, {
		color = display.COLOR_WHITE
	}):addTo(bg):pos(180, 135):anchor(0, 0.5)

	if not v.info.isPileUp() then
		an.newLabel("1", 18, 1, {
			color = display.COLOR_WHITE
		}):addTo(bg):pos(250, 135):anchor(0, 0.5)
	else
		local inputL = nil
		inputL = an.newInput(250, 135, 90, 33, 3, {
			label = {
				"1",
				18
			},
			bg = {
				h = 33,
				tex = res.gettex2("pic/scale/edit.png"),
				offset = {
					-1,
					0
				}
			},
			start_call = function ()
				inputL:setText("")
			end,
			stop_call = function ()
				local num = tonumber(inputL:getText())

				if not num or num <= 0 or num > 999 or math.floor(num) < num then
					main_scene.ui:tip("��������ȷ�����֣�")

					noError = false
				elseif not self.sItem.data.isPileUp() and num > 1 or self.sItem.data.isPileUp() and self.sItem.data:get("dura") < num then
					main_scene.ui:tip("�����������ڳ�������,���������룡")

					noError = false
				else
					cnt = num

					addTips()

					noError = true
				end
			end
		}):addTo(bg):pos(235, 135):anchor(0, 0.5)
	end
end

function stallOther:addItem(makeIndex)
	local i, v = g_data.stallOther:getItem(makeIndex)

	if v then
		if self.items[i] then
			self.items[i]:removeSelf()
		end

		local price = "�۸�:" .. v.price .. (v.type == 0 and "���" or "Ԫ��")
		self.items[i] = item.new(v.info, self, {
			donotMove = true,
			idx = i,
			extend = {
				price
			},
			clickcb = function (item)
				self:clickItem(item)
			end
		}):addTo(self.bg, 1):pos(self:idx2pos(i))
	end
end

function stallOther:delItem(makeIndex)
	local i, data = g_data.stallOther:getItem(makeIndex)

	for k, v in pairs(self.items) do
		if v.data:get("makeIndex") == tonumber(makeIndex) then
			v:removeSelf()

			self.items[k] = nil

			if data then
				self.items[k] = item.new(data.info, self, {
					idx = k,
					extend = {
						data.price
					},
					clickcb = function (item)
						self:clickItem(item)
					end
				}):addTo(self.bg, 1):pos(self:idx2pos(k))
			end
		end
	end
end

function stallOther:clickItem(item)
	if self.sItem == item then
		return
	end

	if self.sItem and self.sItem.mask then
		self.sItem.mask:removeSelf()
	end

	self.sItem = item
	self.sItem.mask = display.newColorLayer(cc.c4f(0, 255, 0, 60)):addTo(item):size(item.w, item.h):pos(-item.w / 2, -item.h / 2)
end

function stallOther:idx2pos(idx)
	idx = idx - 1
	local h = idx % 5
	local v = math.modf(idx / 5)

	return 59 + h * 47, 328 - v * 48
end

function stallOther:pos2idx(x, y)
	local h = (x - 59) / 47 + 0.5
	local v = (328 - y) / 48 + 0.5

	if h > 0 and h < 5 and v > 0 and v < 4 then
		return math.floor(v) * 8 + math.floor(h) + 1
	end

	return -1
end

return stallOther
