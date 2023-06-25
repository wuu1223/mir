local util = {}
local current = ...

function util.getDir(from, to)
	local offX = to.x - from.x
	local offY = to.y - from.y
	local angle = math.atan(offY / offX)

	if angle <= math.pi / 8 and angle > -math.pi / 8 then
		if offX > 0 then
			return def.role.dir.right, 1, 0
		else
			return def.role.dir.left, -1, 0
		end
	elseif angle < math.pi * 3 / 8 and angle > math.pi / 8 then
		if offX > 0 then
			return def.role.dir.rightBottom, 1, 1
		else
			return def.role.dir.leftUp, -1, -1
		end
	elseif angle >= math.pi * 3 / 8 or angle < -math.pi * 3 / 8 then
		if offY > 0 then
			return def.role.dir.bottom, 0, 1
		else
			return def.role.dir.up, 0, -1
		end
	elseif angle <= -math.pi / 8 and angle > -math.pi * 3 / 8 then
		if offY < 0 then
			return def.role.dir.rightUp, 1, -1
		else
			return def.role.dir.leftBottom, -1, 1
		end
	end

	return def.role.dir.bottom, 0, 1
end

function util.inSet(l, set)
	for k, v in ipairs(set) do
		if l == v then
			return true
		end
	end

	return false
end

function util.off2p(x, y)
	local player = main_scene.ground.player
	local ret = cc.p(x + player.x, y + player.y)
	ret.off2 = true

	return ret
end

function util.off2t(x, y, t)
	local ret = cc.p(x + t.x, y + t.y)
	ret.off2 = true

	return ret
end

function util.featu(race, dress, feature, hair)
	return {
		race = race,
		dress = dress,
		feature = feature,
		hair = hair
	}
end

function util.region(x, y, r)
	return {
		x = x,
		y = y,
		radio = r or 2
	}
end

function util.stressTest(skill, useDress, move)
	local ret = {}
	local dress = {}

	for k, v in pairs(def.items) do
		if type(v) == "table" and (v.stdMode == 10 or v.stdMode == 11) then
			table.insert(dress, k)
		end
	end

	local magics = {
		"������",
		"������",
		"��������",
		"������ս��",
		"�����",
		"ʩ����",
		"��ɱ����",
		"���ܻ�",
		"������",
		"�����Ӱ",
		"�׵���",
		"��ɱ����",
		"�����",
		"�����",
		"��ʥս����",
		"��ħ��",
		"�ٻ�����",
		"������",
		"����������",
		"�ջ�֮��",
		"˲Ϣ�ƶ�",
		"��ǽ",
		"���ѻ���",
		"�����׹�",
		"�����䵶",
		"�һ𽣷�",
		"Ұ����ײ",
		"������ʾ",
		"Ⱥ��������",
		"�ٻ�����",
		"ħ����",
		"ʥ����",
		"������",
		nil,
		"�����",
		"�޼�����",
		"������",
		nil,
		"������",
		nil,
		nil,
		nil,
		"ʨ�Ӻ�",
		nil,
		nil,
		nil,
		nil,
		"��Ѫ��",
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		"���ս���",
		"���ǻ���"
	}
	local mid = {}

	for k, v in pairs(magics) do
		table.insert(mid, k)
	end

	local pre = nil

	for y = -15, 15 do
		for x = 0, 40 do
			local dre = nil

			if useDress then
				dre = dress[math.random(#dress)]
			end

			local d = util.dummy.new("" .. (dress[x] or y), "hero", dre, nil, 0, y % 7, cc.p(x - 20, y), nil, )

			if skill and pre then
				local tpre = pre

				d.role.node:performWithDelay(function ()
					d.role.node:runForever(cca.seq({
						cca.callFunc(function ()
							local id = mid[math.random(#mid)]

							d:magic(id, tpre)
						end),
						d:actDelay(10)
					}))
				end, math.random() * 10)
			elseif move then
				d.role.node:runs({
					cca.rep(cca.seq(d:actPlayAct(dummy.acts.WALK, cc.p(-1, -1)), d:actDelay(2)), 50)
				})
			elseif useDress then
				d.role.node:performWithDelay(function ()
					d.role.node:runForever(cca.seq({
						d:actDelay(1),
						cca.callFunc(function ()
							local dir = math.random(8) - 1
							d.dir = dir
						end)
					}))
				end, 10)
			end

			pre = d

			table.insert(ret, d)
		end
	end

	return function ()
		for k, v in pairs(ret) do
			v:removeSelf()
		end
	end
end

return util
