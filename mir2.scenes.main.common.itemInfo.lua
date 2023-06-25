local info = {}

function info.show(data, scenePos, params)
	if g_data.player.showTips then
		return
	end

	g_data.player.showTips = true
	params = params or {}
	local layer = display.newNode():size(display.width, display.height):addto(params.parent or main_scene.ui, params.z or main_scene.ui.z.textInfo)

	layer:setTouchEnabled(true)
	layer:setTouchSwallowEnabled(false)
	layer:addNodeEventListener(cc.NODE_TOUCH_CAPTURE_EVENT, function (event)
		if event.name == "ended" then
			g_data.player.showTips = false

			layer:runs({
				cc.DelayTime:create(0.01),
				cc.RemoveSelf:create(true)
			})
		end

		return true
	end)

	local playerorhero = nil

	if params.from == "heroBag" or params.from == "heroEquip" then
		playerorhero = g_data.hero
	elseif params.from == "bag" or params.from == "equip" then
		playerorhero = g_data.player
	else
		playerorhero = g_data.player
	end

	local getData, getDataStd = nil
	local double = 1

	if params.onlyStdItem then
		function getData(k)
			return data.getVar(k)
		end

		getDataStd = getData
	else
		function getData(k)
			return data.getVar(k)
		end

		function getDataStd(k)
			return data.getStd():get(k)
		end

		if data.isPileUp and data.isPileUp() then
			double = data:get("dura")
		end
	end

	function isBind()
		if getData("normalStateSet") then
			return ycFunction:band(getData("normalStateSet"), 2) ~= 0
		elseif getData("stdMode") == 2 then
			return getData("shape") == 10 or getData("shape") == 23 or getData("shape") == 31
		elseif getData("stdMode") == 3 then
			return getData("shape") == 30
		end
	end

	function isGift()
		if getData("VTGiftProp") then
			return getData("VTGiftProp") ~= 0
		end
	end

	function isUpgrade()
		if getData("normalStateSet") then
			return ycFunction:band(getData("normalStateSet"), 1) ~= 0
		end
	end

	function getExternText()
		if isBind() then
			local itemName = getData("name")

			if string.find(itemName, "(��)") then
				return ""
			elseif isGift() then
				return "(��)"
			else
				return "(��)"
			end
		elseif isGift() then
			return "(��)"
		end

		return ""
	end

	local labels = {
		an.newLabel(getData("name") .. getExternText(), 20, 1, {
			color = cc.c3b(255, 255, 0)
		}),
		an.newLabel("����: " .. getData("weight") * double, 20, 1)
	}
	local btns = {}

	function add(text, color)
		text = text or ""
		labels[#labels + 1] = an.newLabel(text, 20, 1, {
			color = color
		})
	end

	function addAttr(text, key)
		local front = getData(key) or 0
		local after = getData("max" .. key) or 0

		if front > 0 or after > 0 then
			local normalAfter = getDataStd("max" .. key)

			if normalAfter and normalAfter < after then
				add(text .. front .. "-" .. after .. "  (+" .. after - normalAfter .. ")", display.COLOR_GREEN)
			else
				add(text .. front .. "-" .. after)
			end
		end
	end

	function addAttr2(text, value, normalValue, color, attachText)
		attachText = attachText or ""

		if normalValue and normalValue < value then
			add(text .. value .. attachText .. "  (+" .. value - normalValue .. attachText .. ")", display.COLOR_GREEN)
		else
			add(text .. value .. attachText, color)
		end
	end

	function needColor(a, b)
		return b <= a and display.COLOR_WHITE or display.COLOR_RED
	end

	function addNeed()
		local need = getData("need")
		local needLevel = getData("needLevel")

		if need == 0 then
			add("��Ҫ�ȼ�: " .. needLevel .. "��", needColor(playerorhero.ability:get("level"), needLevel))
		elseif need == 1 then
			add("��Ҫ������: " .. needLevel, needColor(playerorhero.ability:get("maxDC"), needLevel))
		elseif need == 2 then
			add("��Ҫħ����: " .. needLevel, needColor(playerorhero.ability:get("maxMC"), needLevel))
		elseif need == 3 then
			add("��Ҫ������: " .. needLevel, needColor(playerorhero.ability:get("maxSC"), needLevel))
		elseif need == 4 then
			add("��Ҫת���ȼ�: " .. needLevel, display.COLOR_WHITE)
		elseif need == 40 then
			add("��Ҫת��&�ȼ�: " .. needLevel, display.COLOR_WHITE)
		elseif need == 41 then
			add("��Ҫת��&������: " .. needLevel, display.COLOR_WHITE)
		elseif need == 42 then
			add("��Ҫת��&ħ����: " .. needLevel, display.COLOR_WHITE)
		elseif need == 43 then
			add("��Ҫת��&��������: " .. needLevel, display.COLOR_WHITE)
		elseif need == 44 then
			add("��Ҫת��&������: " .. needLevel, display.COLOR_WHITE)
		elseif need == 5 then
			add("��Ҫ������: " .. needLevel, display.COLOR_WHITE)
		elseif need == 6 then
			add("�л��Աר��", display.COLOR_WHITE)
		elseif need == 60 then
			add("�л�����ר��", display.COLOR_WHITE)
		elseif need == 7 then
			add("ɳ�ǳ�Աר��", display.COLOR_WHITE)
		elseif need == 70 then
			add("ɳ������ר��", display.COLOR_WHITE)
		elseif need == 8 then
			add("��Աר��", display.COLOR_WHITE)
		elseif need == 81 then
			add("��Ա���� =" .. Loword(needLevel) .. "���ȼ�>=" .. Hiword(needLevel), display.COLOR_WHITE)
		elseif need == 82 then
			add("��Ա���� >= " .. Loword(needLevel) .. "���ȼ�>=" .. Hiword(needLevel), display.COLOR_WHITE)
		end
	end

	local function tmpModf(value)
		local int, f = math.modf(value)

		return f >= 0.5 and int + 1 or int
	end

	local function getDuraColor(v)
		v = v or 1000
		local tmpDura = tmpModf(Word(data:get("dura") or getData("duraMax")) / v)

		return tmpDura == 0 and display.COLOR_RED or display.COLOR_WHITE
	end

	function duraStr(v)
		v = v or 1000

		if params.onlyStdItem then
			if params.hideMaxDura then
				return "-/-"
			else
				return math.modf(Word(getData("duraMax")) / v)
			end
		end

		if params.hideMaxDura then
			return tmpModf(Word(data:get("dura")) / v)
		else
			return tmpModf(Word(data:get("dura")) / v) .. "/" .. tmpModf(Word(data:get("duraMax")) / v)
		end
	end

	local stdMode = getData("stdMode")

	if stdMode == 0 then
		if getData("AC") > 0 then
			add("HP+" .. getData("AC"), display.COLOR_GREEN)
		end

		if getData("MAC") > 0 then
			add("MP+" .. getData("MAC"), display.COLOR_GREEN)
		end
	elseif stdMode == 1 then
		local shape = getData("shape") or 0

		if checkExist(shape, 1, 2, 5, 6, 7) then
			add("����: " .. duraStr() .. " Сʱ")
		elseif checkExist(shape, 3, 4, 8, 9, 10) then
			add("�ۻ�: " .. duraStr() .. " Сʱ")
		elseif shape == 30 then
			add("ʹ��: " .. duraStr(10) .. " ��")
		elseif shape == 34 then
			add("�־�: " .. duraStr(1))
		elseif shape == 35 then
			add("ʹ��: " .. duraStr(1) .. " ��")
		end
	elseif stdMode == 2 then
		local shape = getData("shape") or 0

		if shape == 9 then
			add("�޸�װ���־�: " .. duraStr(100) .. "��", display.COLOR_GREEN)
		elseif shape == 20 then
			add("����: " .. duraStr(), display.COLOR_GREEN)
			add("�ȼ�: " .. getData("needLevel"), display.COLOR_GREEN)
			add("Ʒ��: " .. getData("source"), display.COLOR_GREEN)
			add("�ƾ���: " .. getData("aniCount") .. "C��", display.COLOR_GREEN)
		elseif shape == 21 then
			add("Ʒ��: " .. getData("source"), display.COLOR_GREEN)
		else
			add("����: " .. duraStr() .. "��", display.COLOR_GREEN)
		end
	elseif stdMode == 4 then
		local shape = getData("shape") or 0

		if checkExist(shape, 0, 1, 2) then
			local names = {
				"սʿ�ؼ�",
				"ħ���ؼ�",
				"��ʿ�ؼ�"
			}

			add(names[shape + 1], display.COLOR_GREEN)
		end

		if not params.hideMaxDura then
			local needLevel = math.modf(Word(getData("duraMax")))

			add("��Ҫ�ȼ�: " .. needLevel .. "��", needColor(playerorhero.ability:get("level"), needLevel))
		end
	elseif checkExist(stdMode, 5, 6) then
		if isUpgrade() then
			labels[1]:setString("(*)" .. getData("name"))
		end

		add("�־�: " .. duraStr(), getDuraColor())
		addAttr("����: ", "DC")
		addAttr("ħ��: ", "MC")
		addAttr("����: ", "SC")

		local source = getData("source")
		local sourceN = getDataStd("source")

		if checkIn(source, 1, 10) then
			addAttr2("ǿ��: +", source, sourceN)
		elseif checkIn(source, -50, -1) then
			addAttr2("��ʥ: +", -source, -sourceN, display.COLOR_WHITE)
		elseif checkIn(source, -100, -51) then
			add("��ʥ: -" .. -source - 50, display.COLOR_RED)
		end

		local AC = getData("AC")
		local maxAC = getData("maxAC")
		local MAC = getData("MAC")
		local maxMAC = getData("maxMAC")
		local ACN = getDataStd("AC")
		local maxACN = getDataStd("maxAC")
		local MACN = getDataStd("MAC")
		local maxMACN = getDataStd("maxMAC")

		if maxAC > 0 then
			local ac = getData("accurate") or maxAC

			addAttr2("׼ȷ: +", ac, maxACN, display.COLOR_WHITE)
		end

		if maxMAC > 0 then
			if maxMAC > 10 then
				if macN then
					macN = maxMACN
					macN = macN > 10 and macN - 10 or macN
				end

				addAttr2("�����ٶ�: +", maxMAC - 10, macN, display.COLOR_WHITE)
			else
				add("�����ٶ�: -" .. maxMAC, display.COLOR_RED)
			end
		end

		if AC > 0 then
			addAttr2("����: +", AC, acN or ACN, display.COLOR_WHITE)
		end

		if MAC > 0 then
			add("����: +" .. MAC, display.COLOR_RED)
		end

		addNeed()
	elseif stdMode == 7 then
		local shape = getData("shape") or 0

		if checkExist(shape, 0, 1, 2, 3) then
			local front = {
				"����: ",
				"HP ",
				"MP ",
				"HPMP "
			}
			local after = {
				" ��",
				" ��",
				" ��",
				" ��"
			}

			add(front[shape + 1] .. duraStr() .. after[shape + 1])
		end

		addNeed()
	elseif checkExist(stdMode, 10, 11) then
		add("�־�: " .. duraStr(), getDuraColor())
		addAttr("����: ", "AC")
		addAttr("ħ��: ", "MAC")
		addAttr("����: ", "DC")
		addAttr("ħ��: ", "MC")
		addAttr("����: ", "SC")

		local source = getData("source")
		local sourceN = getDataStd("source")

		if Lobyte(source) > 0 then
			addAttr2("����: +", Lobyte(source), sourceN and Lobyte(sourceN), display.COLOR_WHITE)
		end

		if Hibyte(source) > 0 then
			add("����: +" .. Hibyte(source), display.COLOR_RED)
		end

		addNeed()
	elseif checkExist(stdMode, 15, 30, 16, 19, 20, 21, 22, 23, 24, 26, 27, 28, 52, 62, 53, 63, 54, 64) then
		if getData("shape") == 188 then
			local name = getData("name")

			p2("normal", "===================\n", name, "�õ����ƺ�����������Թ���")
		end

		local tmpShape = getData("shape") or 0

		if stdMode ~= 64 then
			add("�־�: " .. duraStr(), getDuraColor())
		end

		local AC = getData("AC")
		local maxAC = getData("maxAC")
		local MAC = getData("MAC")
		local maxMAC = getData("maxMAC")
		local ACN = getDataStd("AC")
		local maxACN = getDataStd("maxAC")
		local MACN = getDataStd("MAC")
		local maxMACN = getDataStd("maxMAC")

		if stdMode == 19 or stdMode == 53 then
			if maxAC > 0 then
				addAttr2("ħ�����: +", maxAC, maxACN, display.COLOR_WHITE, "0��")
			end

			if maxMAC > 0 then
				addAttr2("����: +", maxMAC, maxMACN, display.COLOR_WHITE)
			end

			if MAC > 0 then
				add("����: +" .. MAC, display.COLOR_RED)
			end
		elseif stdMode == 20 or stdMode == 24 then
			if maxAC > 0 then
				addAttr2("׼ȷ: +", maxAC, maxACN, display.COLOR_WHITE)
			end

			if maxMAC > 0 then
				addAttr2("����: +", maxMAC, maxMACN, display.COLOR_WHITE)
			end
		elseif stdMode == 21 then
			if maxAC > 0 then
				addAttr2("�����ָ�: +", maxAC, maxACN, display.COLOR_WHITE, "0��")
			end

			if maxMAC > 0 then
				addAttr2("ħ���ָ�: +", maxMAC, maxMACN, display.COLOR_WHITE, "0��")
			end

			if AC > 0 then
				addAttr2("�����ٶ�: +", AC, ACN, display.COLOR_WHITE)
			end

			if MAC > 0 then
				add("�����ٶ�: -" .. MAC, display.COLOR_RED)
			end
		elseif stdMode == 23 then
			if maxAC > 0 then
				addAttr2("������: +", maxAC, maxACN, display.COLOR_WHITE, "0��")
			end

			if maxMAC > 0 then
				addAttr2("�ж��ָ�: +", maxMAC, maxMACN, display.COLOR_WHITE, "0��")
			end

			if AC > 0 then
				addAttr2("�����ٶ�: +", AC, ACN, display.COLOR_WHITE)
			end

			if MAC > 0 then
				add("�����ٶ�: -" .. MAC, display.COLOR_RED)
			end
		elseif stdMode == 28 or stdMode == 27 then
			addAttr("����: ", "AC")
			addAttr("ħ��: ", "MAC")

			if getData("aniCount") > 0 then
				add("����: +" .. getData("aniCount"), display.COLOR_WHITE)
			end
		elseif stdMode == 63 then
			if AC > 0 then
				add("HP: +" .. AC, display.COLOR_GREEN)
			end

			if maxAC > 0 then
				add("MP: +" .. maxAC, display.COLOR_GREEN)
			end

			if maxMAC > 0 then
				addAttr2("����: +", maxMAC, maxMACN, display.COLOR_WHITE)
			end

			if MAC > 0 then
				add("����: +" .. MAC, display.COLOR_RED)
			end
		else
			addAttr("����: ", "AC")
			addAttr("ħ��: ", "MAC")
		end

		addAttr("����: ", "DC")
		addAttr("ħ��: ", "MC")
		addAttr("����: ", "SC")

		local source = getData("source")

		if checkIn(source, -50, -1) then
			add("��ʥ: +" .. -source, display.COLOR_WHITE)
		elseif checkIn(source, -100, -51) then
			add("��ʥ: -" .. -source - 50, display.COLOR_RED)
		end

		if stdMode ~= 52 and stdMode ~= 64 then
			addNeed()
		end
	elseif stdMode == 25 then
		local shape = getData("shape") or 0

		if shape == 9 then
			add("����: " .. duraStr(1))
		elseif shape == 10 or shape == 11 then
			add("�־�: " .. duraStr(100))
		elseif shape == 8 then
			if getData("name") == "ף����" or getData("name") == "ħ���" then
				add("����: " .. duraStr(100))
			else
				add("����: " .. duraStr(10))
			end
		else
			add("����: " .. duraStr(100))
		end
	elseif stdMode == 40 then
		add("Ʒ��: " .. duraStr())
	elseif stdMode == 42 then
		-- Nothing
	elseif stdMode == 43 then
		if not params.onlyStdItem then
			add("����: " .. math.modf(Word(data:get("dura")) / 1000))
		end
	elseif stdMode == 48 then
		-- Nothing
	elseif stdMode == 49 then
		-- Nothing
	end

	local desc = def.items.desc[getData("name")]

	if desc then
		local strs = string.split(desc, "\\")

		for i, v in ipairs(strs) do
			add(v)
		end
	end

	if params.extend then
		for i, v in ipairs(params.extend) do
			add(v, display.COLOR_RED)
		end
	end

	local function release(name)
		local msgBox, slider = nil
		local count = 0
		msgBox = an.newMsgbox("", function (idx)
			if idx == 1 and count > 0 then
				local useCnt = math.min(count, 6)

				local function use()
					if g_data.bag:use("eat", data:get("makeIndex")) then
						net.send({
							CM_EAT,
							recog = data:get("makeIndex")
						})

						useCnt = useCnt - 1

						if useCnt > 0 then
							scheduler.performWithDelayGlobal(use, 0.5)
						end
					end
				end

				use()
			end
		end, {
			disableScroll = true,
			hasCancel = true
		})

		an.newLabel("��ǰ��" .. data:get("dura") / 100 .. "��" .. name, 18, 1):addTo(msgBox.bg):pos(60, 190):anchor(0, 0.5)

		local getout = an.newLabel("ȡ��0��" .. name .. "(һ�����ȡ6��)", 18, 1):addTo(msgBox.bg):pos(60, 160):anchor(0, 0.5)
		slider = an.newSlider(res.gettex2("pic/common/sliderBg3.png"), nil, res.gettex2("pic/common/sliderBlock3.png"), {
			scale9 = cc.size(280, 31),
			valueChange = function (value)
				count = math.min(data:get("dura") / 100, 6) * value

				getout:setString("ȡ��" .. math.ceil(count) .. "��" .. name .. "(һ�����ȡ6��)")
			end
		}):add2(msgBox.bg):pos(msgBox.bg:getw() / 2, 110):anchor(0.5, 0.5)
	end

	if getData("name") == "ף����" and params.from == "bag" and data:get("dura") >= 100 then
		btns[#btns + 1] = {
			sprite = "pic/panels/bag/release.png",
			click = function ()
				release("ף����")
			end
		}
	end

	if getData("name") == "ħ���" and params.from == "bag" and data:get("dura") >= 100 then
		btns[#btns + 1] = {
			sprite = "pic/panels/bag/release.png",
			click = function ()
				release("ħ��ָ����")
			end
		}
	end

	if getData("name") == "����" and params.from == "bag" then
		btns[#btns + 1] = {
			sprite = "pic/panels/bag/dh.png",
			click = function ()
				an.newMsgbox("ȷ��ʹ��һ�������һ�998000�����", function ()
					if g_data.bag:use("eat", data:get("makeIndex")) then
						net.send({
							CM_EAT,
							recog = data:get("makeIndex")
						})

						if main_scene.ui.panels.bag then
							main_scene.ui.panels.bag:delItem(data:get("makeIndex"))
						end
					end
				end, {
					center = true
				})
			end
		}
	end

	if (getData("name") == "ף����" or getData("name") == "Ȫˮ��" or getData("name") == "ħ���") and params.from == "equip" then
		btns[#btns + 1] = {
			sprite = "pic/panels/bag/collect.png",
			click = function ()
				net.send({
					CM_DBLCLICKUSEITEM,
					recog = data:get("makeIndex"),
					param = U_BUJUK
				})
			end
		}
	end

	if params.itemLink then
		btns[#btns + 1] = {
			name = "�������",
			click = params.itemLink
		}
	end

	local function splitItem()
		local input = nil
		local msgbox = an.newMsgbox("", function (idx)
			if idx == 1 then
				local count = tonumber(input:getString())

				if not count or count < 0 or data:get("dura") < count then
					main_scene.ui:tip("��������ȷ�����֣�")
				else
					net.send({
						CM_SPLITITEM,
						tag = 0,
						recog = data:get("makeIndex"),
						param = count,
						series = params.from == "heroBag" and 1 or 0
					})
					playerorhero:setIsSplliting(true)
				end
			end
		end, {
			disableScroll = true,
			hasCancel = true
		})

		an.newLabel("��ǰ�ѵ�����Ϊ " .. data:get("dura") .. ", ������������", 18, 1):addTo(msgbox.bg):pos(msgbox.bg:getw() / 2, 180):anchor(0.5, 0.5)

		input = an.newInput(0, 0, 300, 36, 3, {
			bg = {
				h = 36,
				tex = res.gettex2("pic/scale/edit.png")
			}
		}):addTo(msgbox.bg):pos(msgbox.bg:getw() / 2, 140):anchor(0.5, 0.5)
	end

	if params.from and (params.from == "bag" or params.from == "heroBag") and data.isPileUp() and data:get("dura") > 1 then
		btns[#btns + 1] = {
			sprite = "pic/panels/bag/split.png",
			click = splitItem
		}
	end

	if params.from and params.from == "storage" and data.isPileUp() and data:get("dura") > 1 then
		btns[#btns + 1] = {
			sprite = "pic/panels/bag/split.png",
			click = splitItem
		}
	end

	local bg = display.newScale9Sprite(res.getframe2("pic/scale/scale24.png")):addto(layer):anchor(0, 1)
	local w = 0
	local h = 7
	local space = -2

	for i, v in ipairs(btns) do
		local params = {
			pressImage = res.gettex2("pic/common/btn91.png")
		}

		if v.name then
			params.label = {
				v.name or "",
				20,
				1,
				{
					color = def.colors.btn30
				}
			}
		elseif v.sprite then
			params.sprite = res.gettex2(v.sprite)
		end

		local btn = an.newBtn(res.gettex2("pic/common/btn90.png"), function ()
			v.click()
		end, params):anchor(0.5, 0):pos(w * 0.5, h):add2(bg, 999):scale(0.9)
		btns[i] = btn
		w = math.max(w, btn:getw())
		h = h + btn:geth() + space
	end

	for i = #labels, 1, -1 do
		local v = labels[i]:addto(bg, 99):anchor(0, 0):pos(10, h)
		w = math.max(w, v:getw())
		h = h + v:geth() + space
	end

	w = w + 20
	h = h + 10

	for i, v in ipairs(btns) do
		v:setPositionX(w * 0.5)
	end

	local rect = cc.rect(params.minx or 0, params.miny or 0, params.maxx or display.width, params.maxy or display.height)
	local p = scenePos

	if p.x < rect.x then
		p.x = rect.x
	end

	if rect.width < p.x + w then
		p.x = rect.width - w
	end

	if rect.height < p.y then
		p.y = rect.height
	end

	if p.y - h < rect.y then
		p.y = h + rect.y
	end

	bg:size(w, h):pos(p.x, p.y)

	return layer
end

return info
