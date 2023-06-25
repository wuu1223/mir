local common = import("...common.common")
local itemInfo = import("...common.itemInfo")
local voiceBtn = import("...common.voiceBtn")
local chatPos = import("...common.chatPos")
local chatPic = import("...common.chatPic")
local chatItem = import("...common.chatItem")
local keyboardEx = import("...common.keyboardEx")
local frameSize = 2
local widthMax = display.width
local widthMin = 100
local heightMax = 300
local heightMin = 50
local fontSizeMax = 24
local fontSizeMin = 10
local chat = class("panelMainChat", function ()
	return display.newNode()
end)

table.merge(chat, {
	config,
	data,
	frame,
	input,
	scroll,
	newMark,
	sayerNode,
	buf,
	default = {
		fontSize = 18,
		h = 120,
		enableInput = 1,
		enableTouch = 1,
		w = 300,
		showFrame = 1
	}
})

function chat:ctor(config, data)
	data.w = data.w or self.default.w
	data.h = data.h or self.default.h
	data.fontSize = data.fontSize or self.default.fontSize
	data.enableTouch = data.enableTouch or self.default.enableTouch
	data.enableInput = data.enableInput or self.default.enableInput
	data.showFrame = data.showFrame or self.default.showFrame
	self.data = data

	self:size(data.w, data.h):anchor(0.5, 0.5):pos(data.x, data.y)
	self:loadFrame()
	self:loadScroll()
	self:loadInput()
end

function chat:getEditNode()
	local node = display.newNode():size(500, 170)
	local cnt = 0
	local space = 150
	local begin = 20

	local function addToggle(key, name, func)
		local pos = cc.p(30 + cnt * space, node:geth() - 20)
		local btn = an.newBtn(res.getuitex(2, 228), function ()
			self.data[key] = self.data[key] == 0 and 1 or 0

			func(self.data[key] == 1)
		end, {
			scale = 2,
			support = "easy",
			select = {
				res.getuitex(2, 229),
				manual = externHandle
			}
		}):anchor(0, 0.5):pos(pos.x, pos.y):add2(node)

		if self.data[key] == 1 then
			btn:select()
		end

		an.newLabel(name, 20, 1, {
			color = cc.c3b(0, 255, 255)
		}):add2(node):pos(pos.x + 40, pos.y):anchor(0, 0.5)

		cnt = cnt + 1
	end

	addToggle("enableTouch", "�ɴ���", function (b)
		self:loadScroll()
	end)
	addToggle("enableInput", "������", function (b)
		self:loadScroll()
		self:loadInput()
	end)
	addToggle("showFrame", "��ʾ���", function (b)
		self:loadFrame()
	end)

	local cnt = 0
	local space = 45
	local begin = 60

	local function addSlider(key, name, valueMax, valueMin)
		local num = an.newLabel("", 16, 1, {
			color = cc.c3b(0, 255, 255)
		}):add2(node):anchor(0, 0.5):pos(420, node:geth() - begin - cnt * space)

		local function upt(uptUI, from)
			num:setString(name .. "(" .. self.data[key] .. ")")

			if uptUI then
				if key == "w" or key == "h" then
					self:size(self.data.w, self.data.h)
					self:_sizeChanged()

					if self.frame then
						self.frame:size(self:getContentSize()):pos(self:centerPos())
					end
				end

				if from == "end" then
					self:loadScroll()
					self:loadInput()
				end
			end
		end

		upt()

		local slider = an.newSlider(res.gettex2("pic/common/sliderBg.png"), res.gettex2("pic/common/sliderBar.png"), res.gettex2("pic/common/sliderBlock.png"), {
			value = (self.data[key] - valueMin) / (valueMax - valueMin),
			valueChange = function (value)
				local num = (valueMax - valueMin) * value + valueMin
				self.data[key] = math.modf(num)

				upt(true, "change")
			end,
			valueChangeEnd = function (value)
				local num = (valueMax - valueMin) * value + valueMin
				self.data[key] = math.modf(num)

				upt(true, "end")
			end
		}):add2(node):anchor(0, 0.5):pos(20, node:geth() - begin - cnt * space)
		cnt = cnt + 1
	end

	addSlider("w", "��", widthMax, widthMin)
	addSlider("h", "��", heightMax, heightMin)
	addSlider("fontSize", "�ֺ�", fontSizeMax, fontSizeMin)

	return node
end

function chat:loadFrame()
	if self.frame then
		self.frame:removeSelf()

		self.frame = nil
	end

	if self.data.showFrame == 1 then
		self.frame = display.newScale9Sprite(res.getframe2("pic/console/chat.png")):size(self:getContentSize()):pos(self:centerPos()):add2(self, 2)
	end
end

function chat:loadScroll()
	if self.scroll then
		self.scroll:removeSelf()

		self.scroll = nil
	end

	local beginy = self.data.enableInput == 1 and 18 or 0
	local maxLine = 20
	self.scroll = an.newScroll(frameSize, frameSize + beginy, self:getw() - frameSize * 2, self:geth() - beginy - frameSize, {
		labelM = {
			self.data.fontSize,
			1,
			params = {
				bufferChannel = 11,
				maxLine = maxLine,
				doubleClickLine_call = self.data.enableTouch == 1 and function (msg)
					if not msg or msg.target == "" then
						return
					end

					if g_data.chat.style.channel == "˽��" and g_data.chat.style.target == msg.target then
						return
					end

					common.changeChatStyle({
						{
							"channel",
							"˽��"
						},
						{
							"target",
							msg.target
						}
					})
				end
			}
		}
	}):addTo(self)

	self.scroll:enableTouch(self.data.enableTouch == 1)
	self.scroll:setListenner(function (event)
		if event.name == "moved" then
			local x, y = self.scroll:getScrollOffset()

			if y + self.scroll.labelM.wordSize.height > self.scroll:getScrollSize().height - self.scroll:geth() then
				self:hideNewMark()
			end
		end
	end)

	self.buf = newList()
	local msgs = g_data.chat:getMsgs(common.getAllOpenChatChannel(), maxLine)

	for i, v in ipairs(msgs) do
		self:addMsg(v)
	end
end

function chat:loadInput()
	local oldstr = ""

	if self.input and self.input.keyboard then
		oldstr = self.input.keyboard:getText()
	end

	if self.input then
		self.input:removeSelf()

		self.input = nil
	end

	if self.data.enableInput == 0 then
		return
	end

	self.input = display.newColorLayer(cc.c4b(0, 0, 0, 128)):pos(frameSize, frameSize):size(self:getw() - frameSize * 2, 18):add2(self)

	self.input:scalex((self:getw() - frameSize * 2) / self.input:getw())

	local channel = g_data.chat.style.channel
	local filenames = {
		["˽��"] = "single",
		["���"] = "group",
		["����"] = "loudly",
		["ս��"] = "clan",
		["ǧ�ﴫ��"] = "far",
		["�л�"] = "guild",
		["����"] = "near"
	}
	local filename = "pic/console/" .. (filenames[channel] or "far") .. ".png"
	local channelBtn = res.get2(filename):anchor(0, 0):pos(0, -3):add2(self.input)

	channelBtn:scale((self.input:geth() + 6) / channelBtn:geth()):enableClick(function ()
		local p = channelBtn:convertToWorldSpace(cc.p(channelBtn:getw() / 2, channelBtn:geth()))

		common.chatChannelChoose(true):anchor(0.5, 0):pos(p.x, p.y):add2(main_scene.ui, main_scene.ui.z.chatChannel)
	end, {
		size = cc.size(channelBtn:getw(), 17),
		anchor = cc.p(0, 1),
		pos = cc.p(0, 0)
	})

	local labelw = channelBtn:getw() * channelBtn:getScale()

	if channel == "˽��" then
		local text = nil

		if g_data.chat.style.target == "" then
			text = "(�������)"
		else
			text = "" .. g_data.chat.style.target
		end

		local label = an.newLabel(text, 16, 1, {
			color = cc.c3b(255, 255, 0)
		}):pos(labelw, -1):add2(self.input)

		label:enableClick(function ()
			g_data.mark:addNear(main_scene.ground.map:getHeroNameList())

			local msgbox = nil
			msgbox = an.newMsgbox("\n������Է�����.\n", function ()
				common.changeChatStyle({
					{
						"target",
						msgbox.input:getString()
					}
				})
			end, {
				disableScroll = true,
				input = 20,
				inputList = {
					"<����Ҫѡ>",
					g_data.mark:getNames()
				}
			})

			msgbox.input:setString(g_data.chat.style.target)
		end, {
			size = cc.size(label:getw(), 17),
			anchor = cc.p(0, 1),
			pos = cc.p(0, 0)
		})

		labelw = labelw + label:getw()
	end

	if g_data.chat.style.input == "keyboard" then
		local mac_use_source_keyboard = true

		if (device.platform == "mac" or device.platform == "windows") and mac_use_source_keyboard then
			self.input.keyboard = cc.ui.UIInput.new({
				UIInputType = 1,
				image = "res/public/empty.png",
				size = cc.size(self.input:getw() - labelw, 25),
				listener = function (type)
					if type == "changed" then
						local text = self.input.keyboard:getText()

						if string.byte(string.reverse(text)) == string.byte("\\") then
							self.input.keyboard:setText(string.sub(text, 1, #text - 1))
							self:say(self.input.keyboard:getText())
						end
					else
						self:say(self.input.keyboard:getText())
					end
				end
			}):anchor(0, 0):pos(labelw, -6):add2(self.input)

			self.input.keyboard:setText(oldstr)
			self:setKeypadEnabled(true)
			self:addNodeEventListener(cc.KEYPAD_EVENT, function (event)
				if event.key == 32 then
					self:say(self.input.keyboard:getText())
				end
			end)
		else
			self.input.keyboard = an.newInput(labelw, -6, self.input:getw() - labelw - 2, 25, 50, {
				label = {
					oldstr,
					16,
					1
				},
				return_call = function ()
					self:say()
				end,
				show_call = function (dur, y, worldY)
					main_scene:stopAllActions()
					main_scene:moveTo(dur, 0, y / 2)
					main_scene.ui:stopAllActions()
					main_scene.ui:moveTo(dur, 0, y / 2)
					keyboardEx.create(self.input.keyboard):pos(0, y / 2 + worldY)
				end,
				hide_call = function (dur)
					main_scene:stopAllActions()
					main_scene:moveTo(dur, 0, 0)
					main_scene.ui:stopAllActions()
					main_scene.ui:moveTo(dur, 0, 0)
				end,
				getWorldY_call = function ()
					return self:getPositionY() - self:geth() * self:getAnchorPoint().y
				end,
				keyboardEx = {
					get = function ()
						return keyboardEx.create(self.input.keyboard)
					end,
					remove = function ()
						return keyboardEx.destory()
					end
				}
			}):anchor(0, 0):addto(self.input)
		end
	else
		local size = cc.size(self.input:getw() - labelw, self.input:geth())
		local rect = cc.rect(0, -20, size.width, 20)
		self.input.voiceBtn = voiceBtn.new(res.gettex2("pic/voice/voiceBtn.png"), res.gettex2("pic/voice/voiceBtn2.png"), size, rect):anchor(0.5, 0.5):pos(labelw + size.width / 2, self.input:geth() / 2):add2(self.input)

		an.newLabel("��ס˵��", 14, 1, {
			color = cc.c3b(0, 255, 255)
		}):anchor(0.5, 0.5):pos(self.input.voiceBtn:getPosition()):add2(self.input)
	end
end

function chat:hideSayer()
	if self.sayerNode then
		self.sayerNode:removeSelf()

		self.sayerNode = nil
	end
end

function chat:showSayer(msg)
	self:hideSayer()

	local size = cc.size(self:getw(), self.data.fontSize + 2)
	self.sayerNode = display.newClippingRegionNode(cc.rect(0, 0, size.width, size.height)):pos(0, self:geth() - frameSize - size.height + 1):add2(self, 1)
	local c1, c2 = self:getColor(msg)

	display.newColorLayer(cc.c4b(0, 255, 255, 188)):size(size):add2(self.sayerNode)

	local user = an.newLabel(msg.user .. ":", self.data.fontSize, 1, {
		color = c1,
		sc = c2
	}):anchor(0, 0.5):pos(5, size.height / 2):add2(self.sayerNode)

	for i, v in ipairs(msg.data) do
		if v.type == "voice" then
			local bgkey = msg.channel == "˽��" and (msg.fromClient and "˽��self" or "˽��") or msg.channel

			an.newVoiceBubble(size.height, bgkey, v.dur, v.msgID, v.state, true):anchor(0, 0.5):pos(user:getPositionX() + user:getw() + 3, size.height / 2):add2(self.sayerNode)

			break
		end
	end
end

function chat:getColor(msg)
	local color = msg.color
	local bgColor = msg.bgColor

	if msg.channel == "����" then
		bgColor = color
		color = bgColor
	elseif color == 219 and (bgColor == 255 or bgColor == 256) then
		bgColor = 0
		color = 250
	end

	local c1, c2 = nil

	if type(color) == "number" then
		c1 = def.colors.get(color)
	else
		c1 = color
	end

	if type(bgColor) == "number" then
		c2 = def.colors.get(bgColor)
	else
		c2 = bgColor
	end

	return c1, c2
end

function chat:addMsg(msg)
	self.buf.pushBack(msg)
end

function chat:updateAddMsg(msg)
	if not common.getChatChannelIsOpen(msg.channel) then
		return
	end

	local c1, c2 = self:getColor(msg)
	local x, y = self.scroll:getScrollOffset()
	local isInEnd = self.scroll:getScrollSize().height < y + self.scroll:geth() + self.scroll.labelM.wordSize.height

	self.scroll.labelM:nextLine(msg)

	for i, v in ipairs(msg.data) do
		if v.type == "emoji" then
			self.scroll.labelM:addEmoji(res.gettex2("pic/emoji/" .. v.emoji .. ".png"))
		elseif v.type == "emojiConvert" then
			self.scroll.labelM:addEmojiForConvert(v.emoji)
		elseif v.type == "voice" then
			local bgkey = msg.channel == "˽��" and (msg.fromClient and "˽��self" or "˽��") or msg.channel

			self.scroll.labelM:addVoice(bgkey, v.dur, v.msgID, v.state, v.readed, self.data.enableTouch == 1 and function ()
				voice.play(msg.user, v.msgID, msg.channel, v.url, v.dur)
			end)
		elseif v.type == "pic" then
			self.scroll.labelM:addNode(chatPic.new(2, self.scroll.labelM, v, msg.user, msg.channel, self.data.enableTouch == 0), 2, v.msgID)
		elseif v.type == "pos" then
			self.scroll.labelM:addNode(chatPos.new(2, self.scroll.labelM, v, msg.user, self.data.enableTouch == 0), 2)
		elseif v.type == "item" then
			self.scroll.labelM:addNode(chatItem.new(2, self.scroll.labelM, v, self.data.enableTouch == 0), 2)
		else
			self.scroll.labelM:addLabel(v, c1, nil, c2)
		end
	end

	if isInEnd then
		self.scroll:setScrollOffset(0, self.scroll:getScrollSize().height - self.scroll:geth())
	else
		self:showNewMark()
	end
end

function chat:showNewMark()
	if not self.newMark then
		self.newMark = res.get2("pic/common/msgNew.png"):add2(self, 1):run(cc.RepeatForever:create(transition.sequence({
			cc.ScaleTo:create(0.5, 0.7),
			cc.ScaleTo:create(0.5, 1)
		}))):enableClick(function ()
			self.newMark:hide()
			self.scroll:setScrollOffset(0, self.scroll:getScrollSize().height - self.scroll:geth())
		end)
	end

	self.newMark:show():pos(self:getw() - frameSize - 20, (self.input and self.input:geth() or 0) + 24 + frameSize)
end

function chat:hideNewMark()
	if self.newMark then
		self.newMark:hide()
	end
end

function chat:say(text)
	if not self.input then
		return
	end

	if common.say(text or self.input.keyboard:getRichText()) then
		self.input.keyboard:setText("")
	end
end

function chat:update(dt)
	while self.scroll.labelM.maxLine < self.buf.size() do
		self.buf.popFront()
	end

	if not self.buf.isEmpty() then
		self:updateAddMsg(self.buf.popFront())
	end
end

return chat
