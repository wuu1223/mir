local titleInfo = {}

function titleInfo.show(data, scenePos, params)
	params = params or {}
	local layer = display.newNode():size(display.width, display.height):addto(params.parent or main_scene.ui, params.z or main_scene.ui.z.textInfo)

	layer:setTouchEnabled(true)
	layer:setTouchSwallowEnabled(false)
	layer:addNodeEventListener(cc.NODE_TOUCH_CAPTURE_EVENT, function (event)
		if event.name == "ended" then
			layer:removeSelf()
		end

		return true
	end)

	local labels = {}

	function add(text, color)
		text = text or ""
		labels[#labels + 1] = an.newLabel(text, 20, 1, {
			color = color
		})
	end

	add(data:get("TitleName"), cc.c3b(0, 255, 0))

	if data:get("Add_MaxHP") > 0 then
		add("��������+" .. data:get("Add_MaxHP"))
	end

	if data:get("Add_MAC") > 0 then
		add("ħ��+" .. data:get("Add_MAC"))
	end

	if data:get("Add_AC") > 0 then
		add("����+" .. data:get("Add_AC"))
	end

	if data:get("Add_DC") > 0 then
		add("����+" .. data:get("Add_DC"))
	end

	if data:get("Add_MC") > 0 then
		add("ħ��+" .. data:get("Add_MC"))
	end

	if data:get("Add_SC") > 0 then
		add("����+" .. data:get("Add_SC"))
	end

	if data:get("Add_MaxMAC") > 0 then
		add("ħ������+" .. data:get("Add_MaxMAC"))
	end

	if data:get("Add_MaxAC") > 0 then
		add("��������+" .. data:get("Add_MaxAC"))
	end

	if data:get("Add_MaxDC") > 0 then
		add("��������+" .. data:get("Add_MaxDC"))
	end

	if data:get("Add_MaxMC") > 0 then
		add("ħ������+" .. data:get("Add_MaxMC"))
	end

	if data:get("Add_MaxSC") > 0 then
		add("��������+" .. data:get("Add_MaxSC"))
	end

	if data:get("Add_QuickRate") > 0 then
		add("����+" .. data:get("Add_QuickRate"))
	end

	if data:get("Add_Union_Damage") > 0 then
		add("�ϻ��˺�+" .. data:get("Add_Union_Damage"))
	end

	if data:get("Add_Union_Damage_Percent") > 0 then
		add("�ϻ��˺�����+" .. data:get("Add_Union_Damage_Percent"))
	end

	if data:get("Add_Exp") > 0 then
		add("����ֵ+" .. data:get("Add_Exp"))
	end

	if data:get("Add_Exp_Percent") > 0 then
		add("����ֵ����+" .. data:get("Add_Exp_Percent"))
	end

	if data:get("Add_UnBreakValue") > 0 then
		add("����+" .. data:get("Add_UnBreakValue"))
	end

	if data:get("Add_PerAddForceValue") > 0 then
		add("�ڹ��ָ��ٶ�+" .. data:get("Add_PerAddForceValue"))
	end

	if data:get("Add_MaxMP") > 0 then
		add("ħ��+" .. data:get("Add_MaxMP"))
	end

	if data:get("UseTimes") > 0 then
		add("��Ч����+" .. data:get("UseTimes") .. "��")
	end

	if math.floor(data:get("LeftTime") / 1440) ~= 0 then
		add("ʣ��ʱ��:" .. math.floor(data:get("LeftTime") / 1440) .. "��")
	elseif math.floor(data:get("LeftTime") / 60) % 24 ~= 0 then
		add("ʣ��ʱ��:" .. math.floor(data:get("LeftTime") / 60) % 24 .. "Сʱ")
	else
		add("ʣ��ʱ��:" .. math.floor(data:get("LeftTime") % 60) .. "��")
	end

	if not params.noshow then
		if params.dwon then
			add("(����ͼ��ȡ����ǰ�ƺ�)")
		else
			add("(����ͼ����Ϊ��ǰ�ƺ�)")
		end
	end

	local bg = display.newScale9Sprite(res.getframe2("pic/scale/scale4.png")):addto(layer):anchor(0, 1)
	local w = 0
	local h = 7
	local space = -2

	for i = #labels, 1, -1 do
		local v = labels[i]:addto(bg, 99):anchor(0, 0):pos(10, h)
		w = math.max(w, v:getw())
		h = h + v:geth() + space
	end

	w = w + 20
	h = h + 10
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
end

return titleInfo
