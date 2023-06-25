function main(evt)
	print("onNewbee", evt)

	return

	function guideTouch(nodeName, hightLight, twinkle, tipText, params)
		if not GUIDE:isNodeExist(nodeName) then
			local time = 0

			while not GUIDE:isNodeExist(name) do
				delay(0.1)

				time = time + 0.1

				if time > 5 then
					return false
				end
			end
		end

		if hightLight then
			GUIDE:hightLightNode(nodeName)
		end

		if twinkle then
			local flashHandler = GUIDE:twinkleNodeWidthName(nodeName, twinkle)
		end

		if tipText then
			local align = "right"
			local off = pos(-30, 0)
			local text = tipText

			if type(tipText) ~= "table" or not tipText.align then
				local n = GUIDE:getNodeByName(nodeName)

				if not n then
					print(nodeName, "not exist")
				end

				if n and n:convertToWorldSpace(pos(0, 0)).x < display.width / 2 then
					align = "left"
					off = pos(30, 0)
				end

				if type(tipText) == "table" then
					text = tipText.text

					if tipText.pos then
						off = tipText.pos

						if align ~= "left" then
							off.x = -off.x
						end
					end
				end
			else
				text = tipText.text
				align = tipText.align or align
				off = tipText.pos or off
			end

			GUIDE:showTipText(nodeName, {
				text,
				tipText.fontSize or 22,
				1,
				align = align
			}, off)
		end

		local lockOther = true
		lockOther = (not params or type(params.lockOther) == "nil") and true or params.lockOther
		local evt = nil

		GUIDE:focusToNode(nodeName, lockOther, nil, params)

		local endedEvt = "ended," .. nodeName
		evt = waitEvt({
			endedEvt,
			"clean," .. nodeName,
			"timeout"
		})

		GUIDE:stop()

		return evt == endedEvt
	end

	function guideUseItem(itemName, tipText, params)
		local isBook = params
		local lockOther = true
		local timeout = 999

		if type(params) == "table" then
			isBook = params.isBook
			lockOther = params.lockOther
			timeout = params.timeout or timeout
		end

		local nodeName = "bag_" .. itemName
		local cnt = getItemCount(itemName)

		if cnt > 0 and isPanelOpenning("bag") then
			local align = "left"
			local off = pos(30, 0)

			if GUIDE:getNodeByName(nodeName):getPositionX() > display.width / 2 then
				align = "right"
				off = pos(-30, 0)
			end

			if lockOther then
				GUIDE:hightLightNode(nodeName)
			end

			GUIDE:showTipText(nodeName, {
				tipText,
				22,
				1,
				align = align
			}, off)
			GUIDE:twinkleNodeWidthName(nodeName, {
				circle = true,
				radio = 35
			})

			if isBook then
				while not GUIDE:isNodeExist("msgBoxLearnSkill") do
					if not GUIDE:isNodeExist(nodeName) then
						return false
					end

					GUIDE:focusToNode(nodeName, lockOther, nil, 0.1)
					waitEvt({
						"ended," .. nodeName,
						"timeout"
					})
				end

				GUIDE:stop()

				while GUIDE:isNodeExist("msgBoxLearnSkill") do
					delay(0.1)
				end
			else
				params = params or {}
				params.timeout = 0.1
				local t = 0

				while cnt == getItemCount(itemName) and GUIDE:isNodeExist(nodeName) do
					GUIDE:focusToNode(nodeName, lockOther, nil, params)

					evt = waitEvt({
						"ended," .. nodeName,
						"timeout"
					})
					t = t + 0.1

					if evt ~= "timeout" or timeout <= t then
						break
					end
				end
			end

			GUIDE:stop()

			return true
		end
	end

	function guideTip(text, hightLight, timeout, btns)
		local tip = GUIDE:showGuideBoard(text, hightLight, btns)
		local evt = nil

		if btns then
			evt = waitEvt({
				"GuideBoardEvt_confirm",
				"GuideBoardEvt_cancel",
				"timeout"
			})
		elseif hightLight then
			tip:setName("welcome")
			guideTouch("welcome", false, nil, , {
				lockOther = true,
				swallowAnyway = true
			})
		elseif timeout then
			delay(timeout)

			evt = "timeout"
		else
			return tip
		end

		tip:removeSelf()

		return evt, evt == "GuideBoardEvt_confirm"
	end

	function untilClosed(target)
		while true do
			delay(0.1)

			local x, y, mapid = getPlayerLocation()

			if math.abs(x - target.x) <= 2 and math.abs(y - target.y) <= 2 then
				return true
			elseif not isPlayerMoving() then
				return
			end
		end
	end

	function untilNodeExist(name)
		GUIDE:untilNodeExist(name)
	end

	function untilNodeNotExist(name)
		while GUIDE:isNodeExist(name) do
			delay(0.1)
		end
	end

	function utilNPCExist(name, timeout)
		timeout = timeout or 999

		for k = 0.1, 999, 0.1 do
			if findNPCWithName(name) then
				break
			end

			delay(0.1)
		end
	end

	function guideOpenPanel(btnName, panelName, tipText, twinkle, timeout)
		timeout = timeout or 30

		if not GUIDE:isNodeExist(btnName) or isPanelOpenning(panelName) then
			return isPanelOpenning(panelName)
		end

		if tipText then
			local align = "right"
			local off = pos(-30, 0)
			local text = tipText

			if type(tipText) ~= "table" or not tipText.align then
				local n = GUIDE:getNodeByName(btnName)

				if not n then
					print(btnName, "not exist")
				end

				if n and n:convertToWorldSpace(pos(0, 0)).x < display.width / 2 then
					align = "left"
					off = pos(30, 0)
				end

				if type(tipText) == "table" then
					text = tipText.text

					if tipText.pos then
						off = tipText.pos

						if align ~= "left" then
							off.x = -off.x
						end
					end
				end
			else
				text = tipText.text
				align = tipText.align or align
				off = tipText.pos or off
			end

			GUIDE:showTipText(btnName, {
				text,
				tipText.fontSize or 22,
				1,
				align = align
			}, off)
		end

		GUIDE:twinkleNodeWidthName(btnName, twinkle or {
			circle = true,
			radio = 45
		})

		local t = 0

		while not isPanelOpenning(panelName) do
			delay(0.1)

			t = t + 0.1

			if not GUIDE:isNodeExist(btnName) or timeout < t then
				break
			end
		end

		GUIDE:stop()

		return isPanelOpenning(panelName)
	end

	if evt == "firstLogin" then
		if GUIDE:isNodeExist("diy_����") then
			local tip = GUIDE:showGuideBoard("��ӭ����ԭʼ����Ѫ���档����������ְ��������Ҹ�����һЩ�����Ĳ����ɡ�", true)

			tip:setName("welcome")
			guideTouch("welcome", false, nil, , {
				swallowAnyway = true
			})
			tip:removeSelf()

			if not isPanelOpenning("bag") and not guideOpenPanel("diy_����", "bag", "����򿪱���") then
				return
			end

			if PLAYERSEX == 0 then
				dressName = "����(��)"
			else
				dressName = "����(Ů)"
			end

			for _, dress in pairs({
				dressName,
				"ľ��"
			}) do
				if hasItem(dress) and not hasEquip(dress) and not guideUseItem(dress, string.format("˫��%s����װ��", dress), {
					lockOther = false
				}) then
					break
				end
			end

			if isPanelOpenning("bag") then
				guideTouch("bag_close", false, nil, {
					text = "�رձ���"
				}, {
					lockOther = false
				})
			end

			guideTip("�Ѿ�ѧϰ��������װ����������ȥ�ͱ���Ұ��Ĺ������һ����", true)

			local x, y, mapid = getPlayerLocation()

			if mapid == "0" then
				local npc1 = "�����ϱ�"
				local npc2 = "�߽��ϱ�"
				local npc = nil
				npcRole = findNPCWithName(npc1)

				if not npcRole then
					npcRole = findNPCWithName(npc2)
					npc = npc2
				else
					npc = npc1
				end

				if not npcRole then
					if GUIDE:isNodeExist("diy_��ͨ����") then
						guideTouch("diy_��ͨ����", false, nil, "��ͨ������ť�ܹ������Զ�ѡ��\n����Ĺ�����Ϊ����Ŀ��", {
							lockOther = false,
							timeout = 5
						})
					end

					return
				end

				playerMoveTo(npcRole.x, npcRole.y, mapid, 2)

				if not untilClosed(npcRole) then
					guideTouch("diy_��ͨ����", false, nil, "��ͨ������ť�ܹ������Զ�ѡ��\n����Ĺ�����Ϊ����Ŀ��", {
						lockOther = false,
						timeout = 5
					})

					return
				end

				stopPlayerMove()

				if GUIDE:talkWithNPC(npc) then
					untilNodeExist("npc_ȥ��Χ����")
					guideTouch("npc_ȥ��Χ����", false, nil, {
						text = string.format("��%s����ȥ��Χ������", npc),
						pos = pos(65, 0)
					}, {
						lockOther = false
					})
					untilNodeNotExist("npc_ȥ��Χ����")

					if GUIDE:isNodeExist("diy_��ͨ����") then
						guideTouch("diy_��ͨ����", false, nil, "��ͨ������ť�ܹ������Զ�ѡ��\n����Ĺ�����Ϊ����Ŀ��", {
							lockOther = false,
							timeout = 5
						})
					end
				end
			end
		end

		return
	end

	if evt == "level_3" then
		if not hasItem("3�����") then
			guideTip("����������м����顢ҩƷ�ȳ�ֵ��Ʒ������ȼ���ǵÿ�����", true, 5)

			return
		end

		if not isPanelOpenning("bag") then
			if GUIDE:isNodeExist("diy_����") then
				if not guideOpenPanel("diy_����", "bag", "������п��Դ���") then
					return
				end
			elseif GUIDE:isNodeExist("diyhp") then
				guideTouch("diyhp", false, nil, {
					text = "������п��Դ���"
				})
				guideTouch("btnEx_bag", true, nil, {
					text = "������п��Դ���"
				})
				openPanel("bag")
				delay(0.5)
			else
				faild()
			end
		end

		if hasItem("3�����") then
			guideUseItem("3�����", "˫����")

			while not hasItem("7�����") do
				if not isPanelOpenning("bag") then
					faild()

					return
				end

				delay(0.1)
			end
		end
	end

	if evt == "level_7" then
		local skillName, skillIdx = nil

		if PlayerJob == 0 then
			skillName = "��������"
			skillIdx = 3
		elseif PlayerJob == 1 then
			skillName = "������"
			skillIdx = 1
		else
			skillName = "������"
			skillIdx = 2
		end

		local skillNodeName = "diyPanel_skill" .. skillIdx
		local skillQuickNodeName = "diy_skill" .. skillIdx

		function faild()
			guideTip(string.format("7��������м�����%s��˫������ѧϰ�����Լ���", skillName), true, 5)
		end

		if not hasItem("3�����") and not hasItem("7�����") and not checkPlayerSkill(skillIdx) then
			faild()

			return
		end

		if not isPanelOpenning("bag") then
			if GUIDE:isNodeExist("diy_����") then
				if not guideOpenPanel("diy_����", "bag", "������п��Դ���") then
					return
				end
			elseif GUIDE:isNodeExist("diyhp") then
				guideTouch("diyhp", false, nil, {
					text = "������п��Դ���"
				})
				guideTouch("btnEx_bag", true, nil, {
					text = "������п��Դ���"
				})
				openPanel("bag")
				delay(0.5)
			else
				faild()
			end
		end

		if isPanelOpenning("bag") then
			if hasItem("3�����") then
				guideUseItem("3�����", "˫����", {
					lockOther = false
				})

				while not hasItem("7�����") do
					if not isPanelOpenning("bag") then
						faild()

						return
					end

					delay(0.1)
				end
			end

			if hasItem("7�����") then
				guideUseItem("7�����", "˫����")

				while not hasItem(skillName) do
					if not isPanelOpenning("bag") then
						faild()

						return
					end

					delay(0.1)
				end
			end
		end

		if hasItem(skillName) and isPanelOpenning("bag") then
			guideUseItem(skillName, "˫��ѧϰ", {
				lockOther = false,
				isBook = true
			})
			guideTouch("bag_close", false, {
				circle = true,
				radio = 25
			}, {
				text = "�رձ���"
			}, {
				lockOther = false
			})
		else
			faild()
		end
	end

	if evt == "level_9" then
		if GUIDE:isNodeExist("diy_�һ�") then
			return
		end

		guideOpenPanel("diy_����", "diy", "���ֹ��ܿ��Զ�����Ϸ����\n����������Ч��Ӧ�Ը��ֳ���", {
			w = 40,
			circle = false,
			h = 75
		})

		dragHandler = GUIDE:dragGuide("diyPanel_btnAutoRat", "diyPanel_ScrollView", {
			goalOffset = pos(500, -75)
		})

		GUIDE:hightLightNode("diyPanel_btnAutoRat")
		GUIDE:showTipText("diyPanel_btnAutoRat", {
			"�϶���ݰ�ť�����ʵ�λ��",
			22,
			1,
			align = "left"
		}, pos(30, 0))
		GUIDE:focusToNode("diyPanel_btnAutoRat", true)
		GUIDE:untilNodeExist("diy_�һ�")
		GUIDE:stop()
		guideTouch("diy_close", true, {
			circle = true,
			radio = 25
		}, {
			text = "�رղ��ֽ���"
		})
		guideTouch("diy_�һ�", false, {
			circle = true,
			radio = 45
		}, {
			text = "ʹ�ùһ����ܷ�����������"
		}, {
			lockOther = false,
			timeout = 60
		})
	end

	if evt == "level_10" then
		local function faild1()
			guideTip("������ȡ����ͨ����������Ĵ���Ա���԰������ٵ����귨��½������������ǰ������ͨ�����洫��Ա���͵����˹�Ĺ������ս��", true, 5)
		end

		local function faild2()
			guideTip("������ȡ�������˹�Ĺ����Ա���԰������͵����˹�Ĺ��������Ϊ�������Լ�����Ҳ����һЩ�������۸񹫵�ͯ�����ۡ�", true, 5)
		end

		guideTip("��ĵȼ��Ѿ��ﵽ��10����������ս��Ϸ�н�Ϊǿ���Ĺ����ˡ��������ҽ��������ߵ����", true, nil)

		local npc = "�����ϱ�"
		local npcRole = findNPCWithName(npc)

		if not npcRole then
			GUIDE:useOnceAct(1)
			utilNPCExist(npc, 5)

			npcRole = findNPCWithName(npc)

			if not npcRole then
				return
			end
		end

		playerMoveTo(npcRole.x, npcRole.y, "0", 2)

		if not untilClosed(npcRole) then
			faild1()

			return
		end

		stopPlayerMove()
		GUIDE:stop()
		GUIDE:talkWithNPC(npc)
		untilNodeExist("npc_��Ѩ����")

		local ret = guideTouch("npc_��Ѩ����", false, nil, {
			text = "������е�ͼ����",
			pos = pos(45, 0)
		}, {
			lockOther = false,
			timeout = 60
		})

		if not ret then
			faild1()

			return
		end

		untilNodeExist("npc_ǰ�����˹�Ĺ")

		ret = guideTouch("npc_ǰ�����˹�Ĺ", false, nil, {
			text = "���͵����˹�Ĺ",
			pos = pos(70, 0)
		}, {
			lockOther = false,
			timeout = 60
		})

		if not ret then
			faild1()

			return
		end

		npc = "���˹�Ĺ����Ա"

		utilNPCExist(npc, 5)

		npcRole = findNPCWithName(npc)

		if not npcRole then
			GUIDE:stop()
			faild2()

			return
		end

		playerMoveTo(npcRole.x, npcRole.y, "0", 2)

		if not untilClosed(npcRole) then
			faild2()

			return
		end

		stopPlayerMove()
		delay(0.6)
		GUIDE:stop()
		npcRole.node:setName("newbee_guideTouchRole")

		ret = guideTouch("newbee_guideTouchRole", false, nil, "�������Ա���жԻ�", {
			lockOther = false,
			timeout = 60,
			swallowAnyway = true
		})

		if not ret then
			faild2()

			return
		end

		GUIDE:talkWithNPC(npc)
		untilNodeExist("npc_ǰ�����˹�Ĺ����")

		local ret = guideTouch("npc_ǰ�����˹�Ĺ����", false, nil, {
			text = "ǰ�����˹�Ĺ����",
			pos = pos(70, 0)
		}, {
			lockOther = false,
			timeout = 60
		})

		if not ret then
			faild2()

			return
		end
	end

	if evt == "low_hp" and GUIDE:isNodeExist("diy_��ҩ") then
		guideTouch("diy_��ҩ", false, {
			circle = true,
			radio = 45
		}, {
			text = "ʹ�ú�ҩ��Ѫ"
		}, {
			lockOther = false,
			timeout = 35
		})
	end
end
