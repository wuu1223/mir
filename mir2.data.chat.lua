local chat = {
	msgs = {},
	style = {
		channel = "����",
		target = "",
		input = "keyboard"
	}
}

function chat:addMsg(data, color, bgColor, fromClient, user, ident)
	local msg = {
		data = data,
		color = color,
		bgColor = bgColor,
		fromClient = fromClient,
		ident = ident,
		channel = self:getChannel(msg)
	}
	msg.target = self:getUser(msg.data, msg.channel)
	msg.user = user or msg.target
	self.msgs[#self.msgs + 1] = msg

	if #self.msgs > 50 then
		table.remove(self.msgs, 1)
	end

	return msg
end

function chat:getUser(data, channel)
	local text = data[1]

	if channel == "����" or channel == "�л�" or channel == "ǧ�ﴫ��" then
		local pos = string.find(text, ":")

		if pos then
			local name = string.sub(text, 1, pos - 1)

			g_data.mark:addChat(name)

			return name
		end
	elseif channel == "˽��" then
		if string.byte(text) == string.byte("/") then
			local pos = string.find(text, " ")

			if pos then
				local name = string.sub(text, 2, pos - 1)

				g_data.mark:addChat(name)

				return name
			end
		else
			local pos = string.find(text, "%[")

			if pos then
				return string.sub(text, 1, pos - 1)
			end
		end
	elseif channel == "����" then
		if string.byte(text, 1) == string.byte("(") and string.byte(text, 2) == string.byte("!") and string.byte(text, 3) == string.byte(")") then
			local pos = string.find(text, ":")

			if pos then
				local name = string.sub(text, 4, pos - 1)

				g_data.mark:addChat(name)

				return name
			end
		end
	elseif channel == "���" then
		local pos1 = string.find(text, "-")
		local pos2 = string.find(text, ":")

		if pos1 and pos2 and pos1 < pos2 then
			local name = string.sub(text, pos1 + 1, pos2 - 1)

			g_data.mark:addChat(name)

			return name
		end
	elseif channel == "ϵͳ" then
		local pos = string.find(text, ":")

		if pos then
			return string.sub(text, 1, pos - 1)
		end
	end

	return ""
end

function chat:getChannel(msg)
	if SM_HEAR == msg.ident then
		return "����"
	elseif SM_WHISPER == msg.ident then
		return "˽��"
	elseif SM_CRY == msg.ident then
		return "����"
	elseif SM_GUILDMESSAGE == msg.ident then
		return "�л�"
	elseif SM_CORPSMESSAGE == msg.ident then
		return "ս��"
	end

	local text = msg.data[1]

	if msg.color == 180 and msg.bgColor == 255 then
		if string.byte(text, 1) == string.byte("/") then
			return "˽��"
		end
	elseif msg.color == 196 and msg.bgColor == 255 and string.byte(text, 1) == string.byte("-") then
		return "���"
	end

	return "ϵͳ"
end

function chat:getMsgs(name, maxLine)
	local ret = {}

	for i = #self.msgs, 1, -1 do
		local msg = self.msgs[i]

		if type(name) == "string" then
			if name == "ȫ��" or msg.channel == name then
				table.insert(ret, 1, msg)
			end
		else
			local channel = self:getChannel(msg)

			for i, v in ipairs(name) do
				if v == channel then
					table.insert(ret, 1, msg)

					break
				end
			end
		end

		if maxLine <= #ret then
			break
		end
	end

	return ret
end

function chat:getMsgWithMsgID(msgID, type)
	for i, v in ipairs(self.msgs) do
		for i2, v2 in ipairs(v.data) do
			if v2.type == type and v2.msgID == msgID then
				return v
			end
		end
	end
end

function chat:uptVoiceMsgState(msgID, state, readed)
	for i, v in ipairs(self.msgs) do
		for i2, v2 in ipairs(v.data) do
			if v2.type == "voice" and v2.msgID == msgID then
				v2.state = state
				v2.readed = v2.readed or readed

				break
			end
		end
	end
end

function chat:setVoiceReaded(msg)
	for i, v in ipairs(msg.data) do
		if v.type == "voice" then
			v.readed = true

			break
		end
	end
end

function chat:setPicLoaded(msg)
	for i, v in ipairs(msg.data) do
		if v.type == "pic" then
			v.state = "loadOk"

			break
		end
	end
end

function chat:uptPicMsgState(msgID, state)
	for i, v in ipairs(self.msgs) do
		for i2, v2 in ipairs(v.data) do
			if v2.type == "pic" and v2.msgID == msgID then
				v2.state = state

				break
			end
		end
	end
end

function chat:uptItemMsgData(data)
	for i, v in ipairs(self.msgs) do
		for i2, v2 in ipairs(v.data) do
			if v2.type == "item" and v2.makeIndex == data:get("makeIndex") then
				v2.itemData = data

				return true
			end
		end
	end
end

function chat:setStyle(key, value)
	self.style[key] = value
end

function chat:getSayText(str)
	if self.style.channel == "����" then
		return str
	elseif self.style.channel == "����" then
		return "!" .. str
	elseif self.style.channel == "˽��" then
		return "/" .. self.style.target .. " " .. str
	elseif self.style.channel == "���" then
		return "!!" .. str
	elseif self.style.channel == "ս��" then
		return "!#" .. str
	elseif self.style.channel == "�л�" then
		return "!~" .. str
	elseif self.style.channel == "ǧ�ﴫ��" then
		return def.cmds.get("@ǧ�ﴫ��") .. " " .. str
	end

	return str
end

function chat:setShieldMask(s)
	self.shieldMask = s
end

return chat
