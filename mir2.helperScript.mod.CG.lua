function main(stageIndex)
	sound.playMusic("CG2", true)

	function focus(img, x, y, w, h, dur)
		dur = dur or 2
		local scale = math.min(display.width / w, display.height / h)
		local newAnchorX = x / img:getw()
		local newAnchorY = y / img:geth()
		local oleAnchor = img:getAnchorPoint()
		local oleAX = oleAnchor.x
		local oleAY = oleAnchor.y
		local oleScale = img:getScale()
		local proc = 0
		local act = nil

		local function upt(act, per)
			local dt = getDeltaTime()
			proc = proc + dt
			local per = per or proc / dur

			if per >= 1 then
				per = 1

				if act then
					act:stop()
				end
			end

			local ax = oleAX + (newAnchorX - oleAX) * per
			local ay = oleAY + (newAnchorY - oleAY) * per

			img:anchor(ax, ay)

			local sc = oleScale + (scale - oleScale) * per

			img:setScale(sc)
		end

		if dur == 0 then
			upt(nil, 1)
		else
			act = img:schedule(upt, 0)
		end
	end

	local tDelay = delay

	function delay(...)
		tDelay(...)

		if SKIP_PLAY() then
			sound.stopAllSounds()
			exitStage()

			return true
		end
	end

	function playSound(filename)
		sound.setPriority(filename, 10)
		sound.playSound(filename)
	end

	fsdress = 329
	fsweapon = 210
	dsdress = 330
	dsweapon = 326
	zsdress = 328
	zsweapon = 208
	ad = action.delay
	acb = action.callFunc
	rs = action.removeSelf

	function showText(text)
		if la then
			la:removeSelf()
		end

		la = createLabel(text, 32, 1):pos(display.cx, 75):anchor(0.5, 0.5)

		la:setLocalZOrder(999)
		la:setNodeEventEnabled(true)

		function la.onCleanup()
			la = nil
		end
	end

	local tCreateRole = createRole

	local function createRole(...)
		local role = tCreateRole(...)
		role.say_default_duration = 3
		role.say_default_strWidth = 316
		role.say_default_fontSize = 24

		return role
	end

	function noInfoRole(...)
		local role = createRole(...)
		role.role.noInfo = true

		return role
	end

	stageIndex = stageIndex or "stage0"

	enterStage(nil, 0, 0)

	if stageIndex == "stage0" then
		enterStage("image", 0, 0, "")

		worldImg = createImage("helperScript/world.jpg"):center()

		worldImg:setLocalZOrder(-1)

		scale = math.max(display.width / worldImg:getw(), display.height / worldImg:geth())

		worldImg:scale(scale)

		if delay(1) then
			return
		end

		focus(worldImg, 1250, 890, 960, 640, 2)
		showText("�귨��½�ϵء���")
		playSound("dubbing/1", true)

		if delay(2) then
			return
		end

		showText("��ǧ��ǰ����ħ���ڲ�����")
		playSound("dubbing/2", true)

		role1 = createRole("��ħ����", 37, 182, 0, 0, 0, nil, pos(0, 1))

		role1.role.node:opacity(0):run(action.fadeIn(0.8))

		role1.dir = DIR.bottom
		role2 = createRole("�������", 21, 34, 0, 0, 0, nil, pos(-2, 3))
		role2.dir = DIR.bottom

		role2.role.node:opacity(0):run(action.fadeIn(0.8))

		role3 = createRole("�������", 49, 63, 0, 0, 0, nil, pos(2, 3))
		role3.dir = DIR.bottom

		role3.role.node:opacity(0):run(action.fadeIn(0.5))

		if delay(2) then
			return
		end

		stageIndex = "stage1"
	end

	if stageIndex == "stage1" then
		createColorLayer(color(0, 0, 0, 255)):opacity(0):runs({
			action.fadeIn(1.5)
		})

		if delay(1.5) then
			return
		end

		enterStage("image", 0, 0, "stage1.jpg")
		createColorLayer(color(0, 0, 0, 255)):runs({
			action.fadeOut(1.5),
			action.removeSelf()
		})
		showText("��ħ�����ꡢ���꣬����֮���ս����")
		playSound("dubbing/3", true)

		one1 = noInfoRole("��Ұ��", 19, 112, 0, 0, 0, nil, pos(-6, -4))
		one1.dir = DIR.rightBottom
		one2 = noInfoRole("�������", 47, 61, 0, 0, 0, nil, pos(-4, -3))
		one2.dir = DIR.leftUp
		one3 = noInfoRole("��ħЫ��ʬ��", 53, 180, 0, 0, 0, nil, pos(-2, -2))
		one3.dir = DIR.rightBottom

		one3:playAct(ACTS.DEATH)

		one4 = noInfoRole("������ʿ", 19, 151, 0, 0, 0, nil, pos(-1, -4))
		one4.dir = DIR.leftBottom
		one5 = noInfoRole("������ʿ", 47, 62, 0, 0, 0, nil, pos(1, -1))
		one5.dir = DIR.leftBottom
		one6 = noInfoRole("������ʿ", 19, 102, 0, 0, 0, nil, pos(0, 0))
		one6.dir = DIR.rightUp
		one7 = noInfoRole("��Ұ��", 19, 111, 0, 0, 0, nil, pos(6, -4))
		one7.dir = DIR.leftUp
		one8 = noInfoRole("�������", 47, 61, 0, 0, 0, nil, pos(3, -4))
		one8.dir = DIR.right
		one9 = noInfoRole("��������", 20, 31, 0, 0, 0, nil, pos(4, -3))
		one9.dir = DIR.bottom
		one10 = noInfoRole("��Ұ��ʬ��", 19, 112, 0, 0, 0, nil, pos(6, -2))
		one10.dir = DIR.leftUp

		one10:playAct(ACTS.DEATH)

		one12 = noInfoRole("��Ұ��", 19, 112, 0, 0, 0, nil, pos(-1, 4))
		one12.dir = DIR.rightUp
		one13 = noInfoRole("��Ұ��", 19, 112, 0, 0, 0, nil, pos(4, 1))
		one13.dir = DIR.up

		one13:playAct(ACTS.NowDEATH)

		one14 = noInfoRole("���깭����", 45, 47, 0, 0, 0, nil, pos(-4, 1))
		one14.dir = DIR.rightUp
		one15 = noInfoRole("����ս��", 19, 33, 0, 0, 0, nil, pos(-4, 2))
		one15.dir = DIR.leftBottom

		one15:playAct(ACTS.DEATH)

		one16 = noInfoRole("��ħ����", 19, 181, 0, 0, 0, nil, pos(-5, 2))
		one16.dir = DIR.rightBottom
		one17 = noInfoRole("��Ұ��", 19, 110, 0, 0, 0, nil, pos(-5, -2))
		one17.dir = DIR.up

		one17:playAct(ACTS.DEATH)

		one19 = noInfoRole("������ʿ", 19, 102, 0, 0, 0, nil, pos(0, 3))
		one19.dir = DIR.leftBottom
		one20 = noInfoRole("��������", 20, 31, 0, 0, 0, nil, pos(-4, 4))
		one20.dir = DIR.leftUp
		one21 = noInfoRole("���깭����", 45, 47, 0, 0, 0, nil, pos(4, 4))
		one21.dir = DIR.rightBottom
		one22 = noInfoRole("������ʿ", 47, 62, 0, 0, 0, nil, pos(3, 2))
		one22.dir = DIR.leftBottom

		one22:playAct(ACTS.DEATH)

		one23 = noInfoRole("����ս��", 19, 33, 0, 0, 0, nil, pos(5, 2))
		one23.dir = DIR.leftBottom

		one23:playAct(ACTS.DEATH)

		one24 = noInfoRole("��Ұ��ʬ��", 19, 112, 0, 0, 0, nil, pos(5, 5))
		one24.dir = DIR.leftUp

		one24:playAct(ACTS.DEATH)

		one25 = noInfoRole("��������", 20, 31, 0, 0, 0, nil, pos(4, 3))
		one25.dir = DIR.rightUp

		one25:playAct(ACTS.DEATH)

		one26 = noInfoRole("��Ұ��ʬ��", 19, 112, 0, 0, 0, nil, pos(-6, 4))
		one26.dir = DIR.leftBottom

		one26:playAct(ACTS.DEATH)

		one27 = createRole("���깭����", 45, 47, 0, 0, 0, nil, pos(1, -4))
		one27.dir = DIR.rightBottom

		one27:playAct(ACTS.DEATH)

		if delay(1) then
			return
		end

		runActs({
			one1:actAssign("dir", DIR.right),
			one1:actPlayAct(ACTS.WALK, pos(1, 0)),
			one1:actDelay(0.8),
			one1:actAssign("dir", DIR.rightBottom),
			action.rep(action.seq({
				one1:actAttack(3),
				one1:actDelay(0.5),
				one2:actPlayAct(ACTS.STRUCK),
				one26:actDelay(1)
			}), 100)
		})

		if delay(0.3) then
			return
		end

		runActs({
			one6:actAssign("dir", DIR.rightUp),
			action.rep(action.seq({
				one6:actAttack(3),
				one6:actDelay(0.5),
				one5:actPlayAct(ACTS.STRUCK),
				one26:actDelay(1)
			}), 100)
		})

		if delay(0.3) then
			return
		end

		runActs({
			one7:actAssign("dir", DIR.leftBottom),
			one7:actPlayAct(ACTS.WALK, pos(-1, 0)),
			one7:actDelay(0.8),
			one7:actAssign("dir", DIR.left),
			action.rep(action.seq({
				one7:actAttack(3),
				one7:actDelay(0.5),
				one8:actPlayAct(ACTS.STRUCK),
				one26:actDelay(1)
			}), 100)
		})

		if delay(0.3) then
			return
		end

		runActs({
			one9:actAssign("dir", DIR.bottom),
			one9:actPlayAct(ACTS.WALK, pos(0, 1)),
			one9:actDelay(0.8),
			one9:actAssign("dir", DIR.bottom),
			action.rep(action.seq({
				one9:actAttack(3),
				one9:actDelay(0.5),
				one13:actPlayAct(ACTS.STRUCK),
				one26:actDelay(1)
			}), 100)
		})

		if delay(0.4) then
			return
		end

		runActs({
			one16:actAssign("dir", DIR.rightBottom),
			action.rep(action.seq({
				one16:actAttack(3),
				one16:actDelay(0.5),
				one20:actPlayAct(ACTS.STRUCK),
				one26:actDelay(1)
			}), 100)
		})

		if delay(0.3) then
			return
		end

		runActs({
			one14:actAssign("dir", DIR.rightUp),
			action.rep(action.seq({
				one14:actAttack(3),
				one14:actDelay(0.5),
				one4:actPlayAct(ACTS.STRUCK),
				one26:actDelay(1)
			}), 100)
		})

		if delay(0.3) then
			return
		end

		runActs({
			one12:actAssign("dir", DIR.rightUp),
			action.rep(action.seq({
				one12:actAttack(3),
				one12:actDelay(0.5),
				one19:actPlayAct(ACTS.STRUCK),
				one26:actDelay(1)
			}), 100)
		})

		stageIndex = "stage2"

		if delay(2) then
			return
		end
	end

	if stageIndex == "stage2" then
		createColorLayer(color(0, 0, 0, 255)):opacity(0):runs({
			action.fadeIn(0.5)
		})

		if delay(0.5) then
			return
		end

		enterStage("image", 0, 0, "stage1.jpg")
		createColorLayer(color(0, 0, 0, 255)):runs({
			action.fadeOut(0.5),
			action.removeSelf()
		})
		showText("ǧ���Ѫ�ȵĽ���֮����������̻�ʤ����")
		playSound("dubbing/4", true)

		role = noInfoRole("�������", 49, 63, 0, 0, 0, nil, pos(0, -1))

		role:sayDR("�۹�������������ȥ�׼���")

		one1 = noInfoRole("���깭����", 45, 47, 0, 0, 0, nil, pos(-6, -3))
		one1.dir = DIR.rightBottom
		one2 = noInfoRole("���깭����", 45, 47, 0, 0, 0, nil, pos(-5, -4))
		one2.dir = DIR.rightBottom
		one3 = noInfoRole("���깭����", 45, 47, 0, 0, 0, nil, pos(-4, -2))
		one3.dir = DIR.rightBottom
		one4 = noInfoRole("���깭����", 45, 47, 0, 0, 0, nil, pos(-5, -1))
		one4.dir = DIR.rightBottom
		one1 = noInfoRole("���깭����", 45, 47, 0, 0, 0, nil, pos(6, -3))
		one1.dir = DIR.leftBottom
		one2 = noInfoRole("���깭����", 45, 47, 0, 0, 0, nil, pos(5, -4))
		one2.dir = DIR.leftBottom
		one3 = noInfoRole("���깭����", 45, 47, 0, 0, 0, nil, pos(4, -2))
		one3.dir = DIR.leftBottom
		one4 = noInfoRole("���깭����", 45, 47, 0, 0, 0, nil, pos(5, -1))
		one4.dir = DIR.leftBottom
		one2 = noInfoRole("�������", 47, 61, 0, 0, 0, nil, pos(-3, -4))
		one2.dir = DIR.bottom
		one2 = noInfoRole("�������", 47, 61, 0, 0, 0, nil, pos(-2, -3))
		one2.dir = DIR.bottom
		one2 = noInfoRole("�������", 47, 61, 0, 0, 0, nil, pos(3, -4))
		one2.dir = DIR.bottom
		one2 = noInfoRole("�������", 47, 61, 0, 0, 0, nil, pos(2, -3))
		one2.dir = DIR.bottom
		one5 = noInfoRole("���깭����", 45, 47, 0, 0, 0, nil, pos(0, 10))
		one5.dir = DIR.up
		local randomBodys = {
			{
				19,
				112
			},
			{
				53,
				180
			},
			{
				19,
				151
			},
			{
				19,
				102
			},
			{
				19,
				111
			},
			{
				20,
				31
			},
			{
				19,
				33
			},
			{
				19,
				181
			},
			{
				19,
				110
			},
			{
				19,
				102
			}
		}

		for k = 0, 20 do
			local body = randomBodys[math.random(1, #randomBodys)]
			local role = noInfoRole("", body[1], body[2], 0, 0, 0, nil, pos(math.random(-5, 5), math.random(2, 5)))
			role.dir = math.random(0, 7)

			role:playAct(ACTS.DEATH)
		end

		if delay(2) then
			return
		end

		runActs({
			one5:actPlayAct(ACTS.WALK, pos(0, -7)),
			one5:actDelay(0.5),
			one5:actAssign("dir", DIR.up),
			one5:actDelay(0.5)
		})

		if delay(1) then
			return
		end

		one5:sayDL("�ˡ����࡭�ӱ��������ˣ�")

		if delay(2) then
			return
		end

		role:sayDR("���úã���Ʒ�Ӳ��Ӷ�")

		stageIndex = "stage3"

		if delay(3) then
			return
		end
	end

	if stageIndex == "stage3" then
		createColorLayer(color(0, 0, 0, 255)):opacity(0):runs({
			action.fadeIn(0.5)
		})

		if delay(0.5) then
			return
		end

		enterStage("image", 0, 0, "stage3.jpg")
		createColorLayer(color(0, 0, 0, 255)):runs({
			action.fadeOut(0.5),
			action.removeSelf()
		})
		showText("������ǰ�������۹�������������������")
		playSound("dubbing/5", true)

		role = noInfoRole("�������", 49, 63, 0, 0, 0, nil, pos(0, -1))

		role:sayDL("�Ҿ�Ȼ���ˣ�!")
		runActsForever(action.seq({
			role:actDelay(0.8)
		}))

		one1 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(4, 4))
		one1.dir = DIR.leftUp
		one2 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(3, 4))
		one2.dir = DIR.rightUp
		one3 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(2, 5))
		one3.dir = DIR.leftUp
		one4 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(1, 5))
		one4.dir = DIR.leftUp
		one5 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(0, 5))
		one5.dir = DIR.up
		one6 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(-4, 4))
		one6.dir = DIR.rightUp
		one7 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(-3, 4))
		one7.dir = DIR.rightUp
		one8 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(-2, 5))
		one8.dir = DIR.rightUp
		one9 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(-1, 5))
		one9.dir = DIR.up
		one10 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(5, 4))
		one10.dir = DIR.leftUp
		one11 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(-5, 4))
		one11.dir = DIR.rightUp
		one12 = noInfoRole("���깭����", 45, 47, 0, 0, 0, nil, pos(-6, -4))
		one12.dir = DIR.bottom

		one12:playAct(ACTS.DEATH)

		one13 = noInfoRole("���깭����", 45, 47, 0, 0, 0, nil, pos(5, -4))
		one13.dir = DIR.leftBottom

		one13:playAct(ACTS.DEATH)

		one14 = noInfoRole("���깭����", 45, 47, 0, 0, 0, nil, pos(-3, -3))
		one14.dir = DIR.rightUp

		one14:playAct(ACTS.DEATH)

		one15 = noInfoRole("���깭����", 45, 47, 0, 0, 0, nil, pos(1, -3))
		one15.dir = DIR.rightBottom

		one15:playAct(ACTS.DEATH)

		one16 = noInfoRole("�������", 47, 61, 0, 0, 0, nil, pos(0, -3))
		one16.dir = DIR.left

		one16:playAct(ACTS.DEATH)

		one17 = noInfoRole("�������", 47, 61, 0, 0, 0, nil, pos(-5, -4))
		one17.dir = DIR.rightBottom

		one17:playAct(ACTS.DEATH)

		one18 = noInfoRole("�������", 47, 61, 0, 0, 0, nil, pos(3, -3))
		one18.dir = DIR.rightBottom

		one18:playAct(ACTS.DEATH)

		one19 = noInfoRole("�������", 47, 61, 0, 0, 0, nil, pos(0, -4))
		one19.dir = DIR.up

		one19:playAct(ACTS.DEATH)

		one20 = noInfoRole("�������", 47, 61, 0, 0, 0, nil, pos(-4, -4))
		one20.dir = DIR.up

		one20:playAct(ACTS.DEATH)

		one21 = noInfoRole("�������", 47, 61, 0, 0, 0, nil, pos(3, -4))
		one21.dir = DIR.leftUp

		one21:playAct(ACTS.DEATH)

		one22 = noInfoRole("���깭����", 45, 47, 0, 0, 0, nil, pos(1, 1))
		one22.dir = DIR.leftBottom

		one22:playAct(ACTS.DEATH)

		one23 = noInfoRole("�������", 47, 61, 0, 0, 0, nil, pos(3, 2))
		one23.dir = DIR.bottom
		one24 = noInfoRole("���깭����", 45, 47, 0, 0, 0, nil, pos(-4, 2))
		one24.dir = DIR.rightBottom

		one24:playAct(ACTS.DEATH)

		one25 = noInfoRole("�������", 47, 61, 0, 0, 0, nil, pos(5, 1))
		one25.dir = DIR.leftUp

		one25:playAct(ACTS.DEATH)

		one26 = noInfoRole("�������", 47, 61, 0, 0, 0, nil, pos(3, 0))
		one26.dir = DIR.left

		one26:playAct(ACTS.DEATH)

		one27 = noInfoRole("���깭����", 45, 47, 0, 0, 0, nil, pos(-5, 0))
		one27.dir = DIR.rightBottom

		one27:playAct(ACTS.DEATH)

		one28 = noInfoRole("���깭����", 45, 47, 0, 0, 0, nil, pos(-1, 1))
		one28.dir = DIR.leftBottom

		one28:playAct(ACTS.DEATH)

		one29 = noInfoRole("�������", 47, 61, 0, 0, 0, nil, pos(-3, 2))
		one29.dir = DIR.right

		one29:playAct(ACTS.DEATH)

		one30 = noInfoRole("���깭����", 45, 47, 0, 0, 0, nil, pos(-4, 2))
		one30.dir = DIR.rightBottom

		one30:playAct(ACTS.DEATH)

		one31 = noInfoRole("�������", 47, 61, 0, 0, 0, nil, pos(-1, 0))
		one31.dir = DIR.leftUp

		one31:playAct(ACTS.DEATH)

		one32 = noInfoRole("�������", 47, 61, 0, 0, 0, nil, pos(-3, 0))
		one32.dir = DIR.leftUp

		one32:playAct(ACTS.DEATH)

		one33 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(6, 3))
		one33.dir = DIR.leftUp
		one34 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(-6, 3))
		one34.dir = DIR.rightUp
		one35 = noInfoRole("��", 19, 70, 0, 0, 0, nil, pos(-6, -1))
		one35.dir = DIR.rightUp
		one36 = noInfoRole("��", 19, 70, 0, 0, 0, nil, pos(5, -1))
		one36.dir = DIR.left
		one37 = noInfoRole("��", 19, 70, 0, 0, 0, nil, pos(2, -1))
		one37.dir = DIR.leftBottom

		runActs({
			one2:actAssign("dir", DIR.up),
			action.rep(action.seq({
				one2:actAttack(3),
				one2:actDelay(0.5),
				one23:actPlayAct(ACTS.STRUCK),
				one23:actPlayAct(ACTS.NOWDEATH),
				one23:actDelay(0.3)
			}), 1)
		})

		if delay(2.5) then
			return
		end

		role:sayDL("���Ҽ�ס��")
		runActs({
			role:actPlayAct(ACTS.WALK, pos(0, -1)),
			role:actDelay(0.7),
			role:actAssign("dir", DIR.leftUp),
			role:actDelay(0.5)
		})

		if delay(1) then
			return
		end

		for k = 1, 3 do
			role:playAct(ACTS.WALK, pos(-4, -4))

			if delay(0.4) then
				return
			end
		end

		stageIndex = "stage4"

		if delay(1) then
			return
		end
	end

	if stageIndex == "stage4" then
		createColorLayer(color(0, 0, 0, 255)):opacity(0):runs({
			action.fadeIn(0.5)
		})

		if delay(0.5) then
			return
		end

		enterStage("image", 0, 0, "stage1.jpg")
		createColorLayer(color(0, 0, 0, 255)):runs({
			action.fadeOut(0.5),
			action.removeSelf()
		})
		showText("����Զ����������꣬������������")
		playSound("dubbing/6", true)

		if delay(1) then
			return
		end

		role = noInfoRole("�����󽫾�", 50, 31, 0, 0, 0, nil, pos(-2, -2))

		role:sayDR("ǰ�����ѩɽ����԰��Զ��")

		solid = {}
		local position = {
			tr = function (x, y)
				return pos(x + 1, y - 1)
			end,
			lb = function (x, y)
				return pos(-x - 1 + 9, -y + 10)
			end
		}
		local index = 0

		for k, p in pairs(position) do
			for i = 0, 9 do
				solid[index * 4] = noInfoRole("ʿ��", 19, 72, 0, 0, 0, nil, p(i, i))
				solid[index * 4].dir = DIR.leftUp
				solid[index * 4 + 1] = noInfoRole("ʿ��", 19, 72, 0, 0, 0, nil, p(i + 1, i - 1))
				solid[index * 4 + 1].dir = DIR.leftUp
				solid[index * 4 + 2] = noInfoRole("ʿ��", 19, 72, 0, 0, 0, nil, p(i + 2, i - 2))
				solid[index * 4 + 2].dir = DIR.leftUp
				solid[index * 4 + 3] = noInfoRole("ʿ��", 19, 72, 0, 0, 0, nil, p(i + 3, i - 3))
				solid[index * 4 + 3].dir = DIR.leftUp
				index = index + 1
			end
		end

		for k, v in pairs(solid) do
			runActsForever({
				v:actPlayAct(ACTS.WALK, pos(-1, -1)),
				v:actDelay(0.6)
			})
		end

		stageIndex = "stage5"

		if delay(3) then
			return
		end
	end

	if stageIndex == "stage5" then
		enterStage(nil, 0, 0, {
			trans = {
				"fade",
				0.5
			}
		})
		waitEvt("stage_onTransFinish")
		playVideo("snowMountain")
		playSound("dubbing/7", true)
		waitEvt("VideoComplete")

		stageIndex = "stage5_2"

		if delay(1) then
			return
		end
	end

	if stageIndex == "stage5_2" then
		enterStage("image", 0, 0, "stage4.jpg")
		createColorLayer(color(0, 0, 0, 255)):runs({
			action.fadeOut(0.5),
			action.removeSelf()
		})
		showText("��������Χ�����侮��ʯ")
		playSound("dubbing/8", true)

		one1 = noInfoRole("�������", 21, 34, 0, 0, 0, nil, pos(3, -1))
		one1.dir = DIR.leftBottom
		one2 = noInfoRole("����ս��", 19, 33, 0, 0, 0, nil, pos(4, -4))
		one2.dir = DIR.leftBottom
		one9 = noInfoRole("��ħ����", 19, 181, 0, 0, 0, nil, pos(6, 5))
		one9.dir = DIR.leftUp
		one3 = noInfoRole("��Ұ��", 19, 110, 0, 0, 0, nil, pos(-4, -3))
		one3.dir = DIR.rightBottom
		one4 = noInfoRole("��Ұ��", 19, 112, 0, 0, 0, nil, pos(5, -5))
		one4.dir = DIR.leftBottom
		one5 = noInfoRole("������ʿ", 19, 102, 0, 0, 0, nil, pos(-2, -4))
		one5.dir = DIR.rightBottom
		one6 = noInfoRole("��������", 20, 31, 0, 0, 0, nil, pos(5, 2))
		one6.dir = DIR.leftBottom
		one7 = noInfoRole("���깭����", 45, 47, 0, 0, 0, nil, pos(-4, 1))
		one7.dir = DIR.rightUp
		one8 = noInfoRole("������ʿ", 47, 62, 0, 0, 0, nil, pos(-3, -1))
		one8.dir = DIR.rightBottom
		one10 = noInfoRole("��Ұ��", 19, 112, 0, 0, 0, nil, pos(-6, -2))
		one10.dir = DIR.rightBottom
		one11 = noInfoRole("��ħЫ��", 53, 180, 0, 0, 0, nil, pos(-4, 4))
		one11.dir = DIR.rightUp
		one12 = noInfoRole("��Ұ��", 19, 111, 0, 0, 0, nil, pos(-6, 2))
		one12.dir = DIR.rightBottom
		one13 = noInfoRole("��Ұ��", 19, 111, 0, 0, 0, nil, pos(6, -2))
		one13.dir = DIR.leftBottom
		one14 = noInfoRole("��ħ����", 19, 181, 0, 0, 0, nil, pos(-6, -4))
		one14.dir = DIR.rightBottom
		one15 = noInfoRole("����ս��", 19, 151, 0, 0, 0, nil, pos(4, 4))
		one15.dir = DIR.left
		one16 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(0, 2))
		one16.dir = DIR.rightBottom
		one17 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(-1, 3))
		one17.dir = DIR.leftBottom
		one18 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(2, 1))
		one18.dir = DIR.rightUp
		one19 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(-3, 0))
		one19.dir = DIR.leftBottom

		one19:playAct(ACTS.DEATH)

		one20 = noInfoRole("��������", 45, 71, 0, 0, 0, nil, pos(-2, 2))
		one20.dir = DIR.left
		one21 = noInfoRole("��������", 45, 71, 0, 0, 0, nil, pos(-1, 0))
		one21.dir = DIR.leftUp
		one22 = noInfoRole("�����󽫾�", 50, 31, 0, 0, 0, nil, pos(0, -1))
		one22.dir = DIR.leftUp
		one23 = noInfoRole("��������", 45, 71, 0, 0, 0, nil, pos(1, 1))
		one23.dir = DIR.leftUp
		one24 = noInfoRole("��������", 45, 71, 0, 0, 0, nil, pos(2, 3))
		one24.dir = DIR.rightBottom
		one25 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(-1, -4))
		one25.dir = DIR.rightBottom

		one25:playAct(ACTS.DEATH)

		one26 = noInfoRole("��������", 45, 71, 0, 0, 0, nil, pos(1, -1))
		one26.dir = DIR.rightUp
		one27 = noInfoRole("��������", 45, 71, 0, 0, 0, nil, pos(1, -4))
		one27.dir = DIR.right
		one28 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(-1, -2))
		one28.dir = DIR.leftUp
		one25 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(0, 4))
		one25.dir = DIR.rightUp

		one25:playAct(ACTS.DEATH)
		runActs({
			one8:actAssign("dir", DIR.rightBottom),
			action.rep(action.seq({
				one8:actAttack(3),
				one8:actDelay(0.8),
				one21:actPlayAct(ACTS.NOWDEATH),
				one23:actDelay(0.1)
			}), 1)
		})

		if delay(2) then
			return
		end

		one21:sayDL("��������������")

		if delay(1.5) then
			return
		end

		one22:sayDR("�ڽ�ʿ������һ��ɱ��ȥ��")

		stageIndex = "stage6"

		if delay(3) then
			return
		end
	end

	if stageIndex == "stage6" then
		enterStage(nil, 0, 0, {
			trans = {
				"fade",
				0.5
			}
		})
		showText("�����˻���������Զ�������˴�룬��·����")
		playSound("dubbing/9", true)
		waitEvt("stage_onTransFinish")

		if delay(6) then
			return
		end

		buildimg = createImage("helperScript/stage6Build1.jpg"):center()

		buildimg:setOpacity(0)
		buildimg:run(action.fadeIn(1))

		if delay(2) then
			return
		end

		showText("ֻ�þ͵ؽ�������ǣ�����������Ϊ����")
		playSound("dubbing/10", true)

		if delay(1) then
			return
		end

		buildimg = createImage("helperScript/stage6Build2.jpg"):center()

		buildimg:setOpacity(0)
		buildimg:run(action.fadeIn(1))

		if delay(2) then
			return
		end

		buildimg = createImage("helperScript/stage6Build3.jpg"):center()

		buildimg:setOpacity(0)
		buildimg:run(action.fadeIn(1))

		if delay(2) then
			return
		end

		enterStage("image", 0, 0, {
			trans = {
				"fadeBL",
				1
			}
		})
		showText("�Դˣ����ϵ�������Ϣ")
		playSound("dubbing/11", true)

		buildimg = createImage("helperScript/stage6Build4.jpg"):center()

		buildimg:run(action.fadeIn(1))

		if delay(2) then
			return
		end

		buildimg = createImage("helperScript/stage6Build5.jpg"):center()

		buildimg:setOpacity(0)
		buildimg:run(action.fadeIn(1))

		if delay(2) then
			return
		end

		buildimg = createImage("helperScript/stage6Build6.jpg"):center()

		buildimg:setOpacity(0)
		buildimg:run(action.fadeIn(1))

		if delay(3) then
			return
		end

		stageIndex = "stage7"
	end

	if stageIndex == "stage7" then
		createColorLayer(color(0, 0, 0, 255)):opacity(0):runs({
			action.fadeIn(1.5)
		})

		if delay(1.5) then
			return
		end

		enterStage("0", 276, 317)
		createColorLayer(color(0, 0, 0, 255)):runs({
			action.fadeOut(1.5),
			action.removeSelf()
		})
		showText("����Ȼ�������ٸ��ĵı��棬�����崹�Ѳ���")
		playSound("dubbing/12", true)
		showEffect(EFFIDS.ET_FIRE, pos(273, 323), 10)
		showEffect(EFFIDS.ET_FIRE, pos(274, 316), 10)
		showEffect(EFFIDS.ET_FIRE, pos(272, 316), 10)
		showEffect(EFFIDS.ET_FIRE, pos(279, 315), 10)

		one1 = noInfoRole("��", 19, 70, 0, 0, 0, nil, pos(281, 323))
		one1.dir = DIR.left

		one1:playAct(ACTS.DEATH)

		one2 = noInfoRole("����ս��", 19, 33, 0, 0, 0, nil, pos(270, 313))
		one2.dir = DIR.rightUp
		one9 = noInfoRole("��Ұ��", 19, 110, 0, 0, 0, nil, pos(281, 315))
		one9.dir = DIR.rightUp
		one4 = noInfoRole("��Ұ��", 19, 111, 0, 0, 0, nil, pos(281, 322))
		one4.dir = DIR.left
		one5 = noInfoRole("������ʿ", 19, 102, 0, 0, 0, nil, pos(274, 319))
		one5.dir = DIR.bottom
		one7 = noInfoRole("���깭����", 45, 47, 0, 0, 0, nil, pos(276, 320))
		one7.dir = DIR.rightBottom

		one7:playAct(ACTS.DEATH)

		one10 = noInfoRole("��Ұ��ʬ��", 19, 111, 0, 0, 0, nil, pos(282, 316))
		one10.dir = DIR.leftUp

		one10:playAct(ACTS.DEATH)

		one12 = noInfoRole("��ħ����", 19, 181, 0, 0, 0, nil, pos(275, 313))
		one12.dir = DIR.rightBottom
		one15 = noInfoRole("���깭����", 45, 47, 0, 0, 0, nil, pos(278, 318))
		one15.dir = DIR.rightBottom
		one19 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(275, 320))
		one19.dir = DIR.leftBottom

		one19:playAct(ACTS.DEATH)

		one18 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(279, 322))
		one18.dir = DIR.right
		one20 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(276, 315))
		one20.dir = DIR.leftUp
		one22 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(280, 320))
		one22.dir = DIR.leftUp
		one23 = noInfoRole("��������", 45, 71, 0, 0, 0, nil, pos(273, 312))
		one23.dir = DIR.leftBottom
		one24 = noInfoRole("��������", 45, 71, 0, 0, 0, nil, pos(279, 316))
		one24.dir = DIR.rightBottom

		one24:playAct(ACTS.DEATH)

		one26 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(274, 314))
		one26.dir = DIR.rightBottom

		one26:playAct(ACTS.DEATH)

		one27 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(272, 313))
		one27.dir = DIR.left

		one27:playAct(ACTS.DEATH)

		one28 = noInfoRole("��������", 45, 71, 0, 0, 0, nil, pos(274, 320))
		one28.dir = DIR.up
		one29 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(282, 314))
		one29.dir = DIR.leftBottom
		one31 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(276, 317))
		one31.dir = DIR.leftBottom

		one31:playAct(ACTS.DEATH)

		if delay(0.3) then
			return
		end

		runActs({
			one23:actAssign("dir", DIR.leftBottom),
			action.rep(action.seq({
				one23:actAttack(3),
				one23:actDelay(0.5),
				one2:actPlayAct(ACTS.STRUCK),
				one23:actDelay(1)
			}), 100)
		})

		if delay(0.4) then
			return
		end

		runActs({
			one9:actAssign("dir", DIR.rightUp),
			action.rep(action.seq({
				one9:actAttack(3),
				one9:actDelay(0.5),
				one29:actPlayAct(ACTS.STRUCK),
				one9:actDelay(1)
			}), 100)
		})

		if delay(0.3) then
			return
		end

		runActs({
			one12:actAssign("dir", DIR.rightBottom),
			action.rep(action.seq({
				one12:actAttack(3),
				one12:actDelay(0.5),
				one20:actPlayAct(ACTS.STRUCK),
				one12:actDelay(1)
			}), 100)
		})

		if delay(0.3) then
			return
		end

		runActs({
			one15:actAssign("dir", DIR.rightBottom),
			action.rep(action.seq({
				one15:actAttack(3),
				one15:actDelay(0.5),
				one22:actPlayAct(ACTS.STRUCK),
				one15:actDelay(1)
			}), 100)
		})

		if delay(0.4) then
			return
		end

		runActs({
			one4:actAssign("dir", DIR.left),
			action.rep(action.seq({
				one4:actAttack(3),
				one4:actDelay(0.5),
				one18:actPlayAct(ACTS.NOWDEATH),
				one4:actDelay(1),
				one4:actAssign("dir", DIR.up),
				one4:actDelay(0.5),
				one4:actPlayAct(ACTS.WALK, pos(0, -4))
			}), 1)
		})

		if delay(0.4) then
			return
		end

		runActs({
			one5:actAssign("dir", DIR.bottom),
			action.rep(action.seq({
				one5:actAttack(3),
				one5:actDelay(0.5),
				one28:actPlayAct(ACTS.STRUCK),
				one5:actDelay(1)
			}), 10)
		})

		if delay(2) then
			return
		end

		stageIndex = "stage7-1"
	end

	if stageIndex == "stage7-1" then
		createColorLayer(color(0, 0, 0, 255)):opacity(0):runs({
			action.fadeIn(0.75)
		})

		if delay(0.75) then
			return
		end

		enterStage("0", 270, 276)
		createColorLayer(color(0, 0, 0, 255)):runs({
			action.fadeOut(0.75),
			action.removeSelf()
		})

		function toff(x, y)
			return pos(x + 313, y + 278)
		end

		showText("�����������һ��")
		playSound("dubbing/13", true)
		showEffect(EFFIDS.ET_FIRE, pos(272, 275), 10)
		showEffect(EFFIDS.ET_FIRE, pos(271, 278), 10)
		showEffect(EFFIDS.ET_FIRE, pos(265, 278), 10)

		one1 = noInfoRole("��", 19, 70, 0, 0, 0, nil, pos(270, 275))
		one1.dir = DIR.left

		one1:playAct(ACTS.DEATH)

		one2 = noInfoRole("����ս��", 19, 33, 0, 0, 0, nil, pos(260, 271))
		one2.dir = DIR.rightBottom
		one3 = noInfoRole("��Ұ��", 19, 111, 0, 0, 0, nil, pos(275, 280))
		one3.dir = DIR.up

		one3:playAct(ACTS.DEATH)

		one4 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(270, 276))
		one4.dir = DIR.leftUp

		one4:playAct(ACTS.DEATH)

		one5 = noInfoRole("��������", 20, 31, 0, 0, 0, nil, pos(276, 276))
		one5.dir = DIR.leftBottom
		one6 = noInfoRole("���깭����", 45, 47, 0, 0, 0, nil, pos(270, 279))
		one6.dir = DIR.leftBottom

		one6:playAct(ACTS.DEATH)

		one7 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(269, 271))
		one7.dir = DIR.left

		one7:playAct(ACTS.DEATH)

		one8 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(268, 275))
		one8.dir = DIR.up

		one8:playAct(ACTS.DEATH)

		one9 = noInfoRole("��������", 45, 71, 0, 0, 0, nil, pos(274, 278))
		one9.dir = DIR.rightUp
		one10 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(268, 275))
		one10.dir = DIR.up

		one10:playAct(ACTS.DEATH)

		if delay(0.3) then
			return
		end

		runActs({
			one5:actAssign("dir", DIR.leftBottom),
			action.rep(action.seq({
				one5:actAttack(3),
				one5:actDelay(0.5),
				one9:actPlayAct(ACTS.STRUCK),
				one5:actDelay(1)
			}), 10)
		})

		if delay(2) then
			return
		end

		createColorLayer(color(0, 0, 0, 255)):opacity(0):runs({
			action.fadeIn(0.75)
		})

		if delay(0.75) then
			return
		end

		enterStage("0", 306, 319)
		createColorLayer(color(0, 0, 0, 255)):runs({
			action.fadeOut(0.75),
			action.removeSelf()
		})

		function toff(x, y)
			return pos(x + 306, y + 319)
		end

		showText("ȴ�ֲ�ס������������")
		playSound("dubbing/14", true)
		showEffect(EFFIDS.ET_FIRE, pos(303, 317), 10)
		showEffect(EFFIDS.ET_FIRE, pos(300, 319), 10)
		showEffect(EFFIDS.ET_FIRE, pos(308, 323), 10)

		one1 = noInfoRole("��", 19, 70, 0, 0, 0, nil, pos(309, 312))
		one1.dir = DIR.leftUp

		one1:playAct(ACTS.DEATH)

		one2 = noInfoRole("���깭����", 45, 47, 0, 0, 0, nil, pos(306, 318))
		one2.dir = DIR.leftBottom
		one3 = noInfoRole("��Ұ��", 19, 111, 0, 0, 0, nil, pos(310, 323))
		one3.dir = DIR.leftUp

		one3:playAct(ACTS.DEATH)

		one4 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(308, 316))
		one4.dir = DIR.left

		one4:playAct(ACTS.DEATH)

		one5 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(301, 318))
		one5.dir = DIR.up

		one5:playAct(ACTS.DEATH)

		one6 = noInfoRole("����ս��", 19, 33, 0, 0, 0, nil, pos(303, 315))
		one6.dir = DIR.left

		one6:playAct(ACTS.DEATH)

		one7 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(307, 319))
		one7.dir = DIR.left

		one7:playAct(ACTS.DEATH)

		one8 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(303, 322))
		one8.dir = DIR.up

		one8:playAct(ACTS.DEATH)

		one9 = noInfoRole("��������", 45, 71, 0, 0, 0, nil, pos(305, 320))
		one9.dir = DIR.rightUp
		one10 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(307, 318))
		one10.dir = DIR.up

		one10:playAct(ACTS.DEATH)

		if delay(0.3) then
			return
		end

		runActs({
			one2:actAssign("dir", DIR.leftBottom),
			action.rep(action.seq({
				one2:actAttack(3),
				one2:actDelay(0.5),
				one9:actPlayAct(ACTS.NOWDEATH),
				one9:actDelay(1),
				one2:actAssign("dir", DIR.right),
				one2:actDelay(0.5),
				one2:actPlayAct(ACTS.WALK, pos(5, 0))
			}), 1)
		})

		stageIndex = "stage7-2"
	end

	if stageIndex == "stage7-2" then
		if delay(2) then
			return
		end

		createColorLayer(color(0, 0, 0, 255)):opacity(0):runs({
			action.fadeIn(0.75)
		})

		if delay(0.75) then
			return
		end

		enterStage("0", 314, 276)
		createColorLayer(color(0, 0, 0, 255)):runs({
			action.fadeOut(0.75),
			action.removeSelf()
		})

		function toff(x, y)
			return pos(x + 313, y + 278)
		end

		showText("�ۿ����漴������ʧ��")
		playSound("dubbing/15", true)
		showEffect(EFFIDS.ET_FIRE, pos(-5, -4), 10)
		showEffect(EFFIDS.ET_FIRE, pos(5, 4), 10)

		one1 = noInfoRole("�������", 21, 34, 0, 0, 0, nil, toff(0, -1))
		one1.dir = DIR.rightUp
		one2 = noInfoRole("����ս��", 19, 33, 0, 0, 0, nil, toff(-2, 1))
		one2.dir = DIR.rightUp
		one3 = noInfoRole("����ս��", 19, 33, 0, 0, 0, nil, toff(1, 1))
		one3.dir = DIR.rightUp
		one4 = noInfoRole("����ս��", 19, 33, 0, 0, 0, nil, toff(-2, -2))
		one4.dir = DIR.rightUp
		one5 = noInfoRole("��С��", 50, 13, 0, 0, 0, nil, toff(5, -4))
		one5.dir = DIR.up
		one6 = noInfoRole("��С��", 50, 12, 0, 0, 0, nil, toff(3, -3))
		one6.dir = DIR.leftBottom
		one7 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, toff(4, -2))
		one7.dir = DIR.rightUp

		one7:playAct(ACTS.DEATH)

		one8 = noInfoRole("��үү", 50, 9, 0, 0, 0, nil, toff(2, -3))
		one8.dir = DIR.leftBottom
		one9 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, toff(1, 5))
		one9.dir = DIR.leftBottom

		one9:playAct(ACTS.DEATH)

		one10 = noInfoRole("��������", 45, 71, 0, 0, 0, nil, toff(-2, -5))
		one10.dir = DIR.rightBottom

		one10:playAct(ACTS.DEATH)

		one11 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, toff(-6, -3))
		one11.dir = DIR.leftBottom

		one11:playAct(ACTS.DEATH)

		one12 = noInfoRole("��������", 45, 71, 0, 0, 0, nil, toff(-2, 4))
		one12.dir = DIR.leftBottom

		one12:playAct(ACTS.DEATH)

		if delay(1) then
			return
		end

		one6:sayDR("�𣬲�Ҫ������")

		if delay(0.8) then
			return
		end

		one1:sayDL("ȫ����ץ����")

		if delay(2) then
			return
		end

		showText("������λӢ��������o���������")
		playSound("dubbing/16", true)
		stage:moveTo(307, 283, true, 1)

		hero1 = noInfoRole("������ʦ", "hero", fsdress, fsweapon, 1, 1, nil, pos(303, 285))
		hero1.dir = DIR.rightUp
		hero2 = noInfoRole("������ʿ", "hero", dsdress, dsweapon, 0, 1, nil, pos(306, 287))
		hero2.dir = DIR.rightUp
		hero3 = noInfoRole("����սʿ", "hero", zsdress, zsweapon, 0, 1, nil, pos(305, 285))
		hero3.dir = DIR.rightUp

		if delay(1) then
			return
		end

		hero3:sayDL("ס�֣�")

		if delay(0.5) then
			return
		end

		stage:moveTo(311, 279, true, 1.2)

		for k = 1, 2 do
			hero1:playAct(ACTS.RUN, pos(2, -2), DIR.rightUp)
			hero2:playAct(ACTS.RUN, pos(2, -2), DIR.rightUp)
			hero3:playAct(ACTS.RUN, pos(2, -2), DIR.rightUp)

			if delay(0.6) then
				return
			end
		end

		hero3:playBigSkill1()

		if delay(0.5) then
			return
		end

		for _ = 1, 1 do
			one2:playAct(ACTS.STRUCK)

			one2.dir = DIR.rightUp

			one3:playAct(ACTS.STRUCK)

			one3.dir = DIR.rightUp

			one4:playAct(ACTS.STRUCK)

			one4.dir = DIR.rightUp

			if delay(0.3) then
				return
			end
		end

		one2:playAct(ACTS.NOWDEATH)

		one2.dir = DIR.rightUp

		one3:playAct(ACTS.NOWDEATH)

		one3.dir = DIR.rightUp

		one4:playAct(ACTS.NOWDEATH)

		one4.dir = DIR.rightUp

		hero3:sayDL("�˴������ң�")

		if delay(0.5) then
			return
		end

		one1:sayDR("໣���������������㣡")
		runActs({
			one1:actAssign("dir", DIR.leftBottom),
			one1:actPlayAct(ACTS.WALK, pos(-2, 1)),
			one1:actDelay(0.8)
		})

		if delay(2) then
			return
		end

		enterStage("image", 0, 0)

		hero3 = noInfoRole("����սʿ", "hero", zsdress, zsweapon, 0, 1, nil, pos(-2, 0))
		hero3.dir = DIR.right
		one1 = noInfoRole("�������", 21, 34, 0, 0, 0, nil, pos(1, 0))
		one1.dir = DIR.left

		if delay(0.5) then
			return
		end

		hero3:playBigSkill()

		if delay(0.3) then
			return
		end

		one1:playAct(ACTS.STRUCK)

		if delay(0.3) then
			return
		end

		one1:playAct(ACTS.STRUCK)

		if delay(0.3) then
			return
		end

		one1:playAct(ACTS.NOWDEATH)
		one1:sayDL("ʲ��ô����")

		stageIndex = "stage8"

		if delay(2) then
			return
		end
	end

	if stageIndex == "stage8" then
		createColorLayer(color(0, 0, 0, 255)):opacity(0):runs({
			action.fadeIn(0.5)
		})

		if delay(0.5) then
			return
		end

		enterStage("image", 0, 0, "stage8fight1.jpg")
		createColorLayer(color(0, 0, 0, 255)):runs({
			action.fadeOut(0.5),
			action.removeSelf()
		})
		showEffect(EFFIDS.ET_FIRE, pos(5, 4), 10)
		showEffect(EFFIDS.ET_FIRE, pos(-4, 6), 10)
		showEffect(EFFIDS.ET_FIRE, pos(2, 5), 10)

		one1 = noInfoRole("��ħ����", 37, 182, 0, 0, 0, nil, pos(2, -2))
		one1.dir = DIR.leftBottom

		one1:sayDR("໡���������Ѱ��·��")

		one2 = noInfoRole("������ʦ", "hero", fsdress, fsweapon, 1, 1, nil, pos(-2, 3))
		one2.dir = DIR.rightUp

		one2:sayDL("�٣����ǡ������꣡")

		one11 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(4, -3))
		one11.dir = DIR.leftBottom

		one11:playAct(ACTS.DEATH)

		one12 = noInfoRole("��������", 45, 71, 0, 0, 0, nil, pos(-2, 4))
		one12.dir = DIR.leftBottom

		one12:playAct(ACTS.DEATH)

		one7 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(-2, -5))
		one7.dir = DIR.left

		one7:playAct(ACTS.DEATH)

		one8 = noInfoRole("��������", 45, 71, 0, 0, 0, nil, pos(-3, 0))
		one8.dir = DIR.left

		one8:playAct(ACTS.DEATH)

		one9 = noInfoRole("��", 19, 70, 0, 0, 0, nil, pos(-3, 4))
		one9.dir = DIR.bottom

		one9:playAct(ACTS.DEATH)

		one10 = noInfoRole("��Ұ��", 19, 112, 0, 0, 0, nil, pos(-4, -3))
		one10.dir = DIR.bottom
		one10 = noInfoRole("��Ұ��", 19, 111, 0, 0, 0, nil, pos(5, 2))
		one10.dir = DIR.leftUp
		one10 = noInfoRole("��Ұ��", 19, 110, 0, 0, 0, nil, pos(3, 4))
		one10.dir = DIR.leftUp

		if delay(1) then
			return
		end

		one2:magic(59, one1)

		if delay(2) then
			return
		end

		one1:playAct(ACTS.STRUCK)
		one1:sayDR("�̡����̰�")

		if delay(2) then
			return
		end

		stageIndex = "stage9"
	end

	if stageIndex == "stage9" then
		createColorLayer(color(0, 0, 0, 255)):opacity(0):runs({
			action.fadeIn(0.5)
		})

		if delay(0.5) then
			return
		end

		enterStage("image", 0, 0, "stage8fight2.jpg")
		createColorLayer(color(0, 0, 0, 255)):runs({
			action.fadeOut(0.5),
			action.removeSelf()
		})
		showEffect(EFFIDS.ET_FIRE, pos(5, -5), 10)
		showEffect(EFFIDS.ET_FIRE, pos(3, 6), 10)
		showEffect(EFFIDS.ET_FIRE, pos(4, -4), 10)
		showEffect(EFFIDS.ET_FIRE, pos(5, 6), 10)

		one1 = noInfoRole("�������", 49, 63, 0, 0, 0, nil, pos(-2, -2))
		one1.dir = DIR.rightBottom
		one4 = noInfoRole("���깭����", 45, 47, 0, 0, 0, nil, pos(-5, -4))
		one4.dir = DIR.rightBottom
		one5 = noInfoRole("���깭����", 45, 47, 0, 0, 0, nil, pos(0, -4))
		one5.dir = DIR.bottom
		one6 = noInfoRole("�������", 47, 61, 0, 0, 0, nil, pos(-6, -1))
		one6.dir = DIR.rightBottom
		one11 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(4, -3))
		one11.dir = DIR.leftBottom

		one11:playAct(ACTS.DEATH)

		one12 = noInfoRole("��������", 45, 71, 0, 0, 0, nil, pos(-2, 4))
		one12.dir = DIR.leftBottom

		one12:playAct(ACTS.DEATH)

		one7 = noInfoRole("��������", 19, 72, 0, 0, 0, nil, pos(-2, -5))
		one7.dir = DIR.left

		one7:playAct(ACTS.DEATH)

		one8 = noInfoRole("��������", 45, 71, 0, 0, 0, nil, pos(-4, 0))
		one8.dir = DIR.bottom

		one8:playAct(ACTS.DEATH)

		one8 = noInfoRole("��", 19, 70, 0, 0, 0, nil, pos(3, 0))
		one8.dir = DIR.bottom

		one8:playAct(ACTS.DEATH)

		one2 = noInfoRole("������ʿ", "hero", dsdress, dsweapon, 0, 1, nil, pos(2, 3))
		one2.dir = DIR.leftUp

		if delay(0.8) then
			return
		end

		one1:sayDL("��Ŷ����Ҫ�ڳ��������")
		one2:sayDR("�ǣ���ħ�䣡")

		if delay(1.5) then
			return
		end

		one2:magic(16, one1)
		one1:sayDL("������ô�����ˡ���")

		if delay(3) then
			return
		end

		stageIndex = "stage10"
	end

	if stageIndex == "stage10" then
		createColorLayer(color(0, 0, 0, 255)):opacity(0):runs({
			action.fadeIn(0.5)
		})

		if delay(0.5) then
			return
		end

		enterStage("image", 0, 0, "stage7fight1.jpg")
		createColorLayer(color(0, 0, 0, 255)):runs({
			action.fadeOut(0.5),
			action.removeSelf()
		})
		showText("������ס�ˣ�����λӢ��Ҳ��������")
		playSound("dubbing/17", true)

		if delay(0.5) then
			return
		end

		hero1 = noInfoRole("������ʦ", "hero", fsdress, fsweapon, 1, 1, nil, pos(-1, -2))
		hero1.dir = DIR.leftBottom
		hero2 = noInfoRole("������ʿ", "hero", dsdress, dsweapon, 0, 1, nil, pos(1, 0))
		hero2.dir = DIR.leftBottom
		hero3 = noInfoRole("����սʿ", "hero", zsdress, zsweapon, 0, 1, nil, pos(0, -1))
		hero3.dir = DIR.leftBottom

		hero3:sayDR("������һ���ػ����棡")

		if delay(4) then
			return
		end

		stageIndex = "stage11"
	end

	if stageIndex == "stage11" then
		enterStage(nil, 0, 0, {
			trans = {
				"fade",
				0.4
			}
		})
		waitEvt("stage_onTransFinish")
		playVideo("flower", false)
		waitEvt("VideoComplete")
		showText("���ȵ�����û�г���̫��")
		playSound("dubbing/18", true)

		if delay(2) then
			return
		end

		stageIndex = "stage12"
	end

	if stageIndex == "stage12" then
		createColorLayer(color(0, 0, 0, 255)):opacity(0):runs({
			action.fadeIn(0.5)
		})

		if delay(0.5) then
			return
		end

		enterStage("image", 0, 0, "stage12.jpg")
		createColorLayer(color(0, 0, 0, 255)):runs({
			action.fadeOut(0.5),
			action.removeSelf()
		})
		showText("���泯ҰȨ������������")
		playSound("dubbing/19", true)

		one1 = noInfoRole("�ߴ���", 50, 16, 0, 0, 0, nil, pos(2, -2))
		one1.dir = DIR.leftBottom
		hero1 = noInfoRole("������ʦ", "hero", fsdress, fsweapon, 1, 1, nil, pos(-2, 1))
		hero1.dir = DIR.leftBottom
		hero2 = noInfoRole("������ʿ", "hero", dsdress, dsweapon, 0, 1, nil, pos(0, 3))
		hero2.dir = DIR.leftBottom
		hero3 = noInfoRole("����սʿ", "hero", zsdress, zsweapon, 0, 1, nil, pos(-1, 2))
		hero3.dir = DIR.leftBottom

		one1:sayDR("��ѽ�����ң����ϲ���")

		for k = 1, 6 do
			hero1:playAct(ACTS.WALK, pos(-2, 2))
			hero2:playAct(ACTS.WALK, pos(-2, 2))
			hero3:playAct(ACTS.WALK, pos(-2, 2))

			if delay(0.55) then
				return
			end
		end

		if delay(1.5) then
			return
		end

		one1:sayDR("������Ʀ���������ˣ��ޣ�")

		stageIndex = "stage13"

		if delay(2) then
			return
		end
	end

	if stageIndex == "stage13" then
		enterStage(nil)
		showText("����������Ӣ�ۣ�����Ȩ���ѹ���ڰ�����һ������")
		playSound("dubbing/20", true)

		worldImg = createImage("helperScript/world_building.jpg"):center()
		scale = math.min(display.width / worldImg:getw(), display.height / worldImg:geth())

		worldImg:scale(scale)
		focus(worldImg, 1250, 990, 960, 640, 0)

		if delay(1.5) then
			return
		end

		focus(worldImg, 650, 1220, 960, 640, 2)

		if delay(1.5) then
			return
		end

		local img = "panels/bigmap/labeln-bairi.png"

		createImage(img, worldImg):pos(646, 1180):scale(1.7):runs({
			action.delay(0.1),
			action.fadeIn(0.5)
		}):setOpacity(0)

		if delay(2) then
			return
		end

		focus(worldImg, 1250, 950, 1600, 1400, 2)

		if delay(1.5) then
			return
		end

		showText("�����귨��½�ϵأ���ν�����������ӡ���")
		playSound("dubbing/21", true)

		local img = "panels/bigmap/labeln-mengzhong.png"

		createImage(img, worldImg):pos(1136, 955):scale(1.7):runs({
			action.delay(0.1),
			action.fadeIn(0.5)
		}):setOpacity(0)

		if delay(0.5) then
			return
		end

		local img = "panels/bigmap/labeln-shabake.png"

		createImage(img, worldImg):pos(1342, 950):scale(1.15):runs({
			action.delay(0.1),
			action.fadeIn(0.5)
		}):setOpacity(0)

		if delay(0.5) then
			return
		end

		local img = "panels/bigmap/labeln-zuma.png"

		createImage(img, worldImg):pos(1480, 1010):scale(1.15):runs({
			action.delay(0.1),
			action.fadeIn(0.5)
		}):setOpacity(0)

		if delay(0.5) then
			return
		end

		local img = "panels/bigmap/labeln-dushe.png"

		createImage(img, worldImg):pos(1140, 780):scale(1.7):runs({
			action.delay(0.1),
			action.fadeIn(0.5)
		}):setOpacity(0)

		if delay(0.5) then
			return
		end

		local img = "panels/bigmap/labeln-biqi.png"

		createImage(img, worldImg):pos(867, 570):scale(1.7):runs({
			action.delay(0.1),
			action.fadeIn(0.5)
		}):setOpacity(0)

		if delay(0.5) then
			return
		end

		local img = "panels/bigmap/labeln-woma.png"

		createImage(img, worldImg):pos(690, 915):scale(1.7):runs({
			action.delay(0.1),
			action.fadeIn(0.5)
		}):setOpacity(0)

		if delay(0.5) then
			return
		end

		local img = "panels/bigmap/labeln-fengmo.png"

		createImage(img, worldImg):pos(416, 1040):scale(1.7):runs({
			action.delay(0.1),
			action.fadeIn(0.5)
		}):setOpacity(0)

		if delay(0.5) then
			return
		end

		local img = "panels/bigmap/labeln-cangyue.png"

		createImage(img, worldImg):pos(613, 1510):scale(1.7):runs({
			action.delay(0.1),
			action.fadeIn(0.5)
		}):setOpacity(0)

		if delay(0.5) then
			return
		end

		local img = "panels/bigmap/labeln-bianjie.png"

		createImage(img, worldImg):pos(989, 285):scale(1.7):runs({
			action.delay(0.1),
			action.fadeIn(0.5)
		}):setOpacity(0)

		if delay(2) then
			return
		end

		stageIndex = "stage14"
	end

	if stageIndex == "stage14" then
		enterStage(nil, 0, 0, {
			trans = {
				"fade",
				0.5
			}
		})
		waitEvt("stage_onTransFinish")
		playVideo("bird")
		playSound("dubbing/22", true)
		waitEvt("VideoComplete")

		stageIndex = "stage15"
	end

	if stageIndex == "stage15" then
		createColorLayer(color(0, 0, 0, 255)):opacity(0):runs({
			action.fadeIn(0.5)
		})

		if delay(0.5) then
			return
		end

		enterStage("image", 0, 0, "stage15.jpg")
		createColorLayer(color(0, 0, 0, 255)):runs({
			action.fadeOut(0.5),
			action.removeSelf()
		})
		showText("�������������������Ѱ�Ҿɲ��ָ���ϵ")
		playSound("dubbing/23", true)

		one5 = noInfoRole("��С��", 50, 13, 0, 0, 0, nil, pos(-4, 3))
		one5.dir = 0
		one6 = noInfoRole("��С��", 50, 12, 0, 0, 0, nil, pos(-3, 2))
		one6.dir = 0
		one7 = noInfoRole("����", 50, 4, 0, 0, 0, nil, pos(-3, 1))
		one7.dir = 0
		one8 = noInfoRole("ƽ�ϲ�", 50, 1, 0, 0, 0, nil, pos(-1, 3))
		one8.dir = 0
		one1 = noInfoRole("��С��", 50, 2, 0, 0, 0, nil, pos(-2, -2))
		one1.dir = 0
		one2 = noInfoRole("���", 50, 3, 0, 0, 0, nil, pos(-4, -2))
		one2.dir = 0
		one3 = noInfoRole("��С��", 50, 20, 0, 0, 0, nil, pos(-5, -1))
		one3.dir = 0
		one4 = noInfoRole("��С��", 50, 17, 0, 0, 0, nil, pos(-1, 0))
		one4.dir = 2
		one5 = noInfoRole("ǮС��", 50, 13, 0, 0, 0, nil, pos(-2, 0))
		one5.dir = 0
		one6 = noInfoRole("��С��", 50, 12, 0, 0, 0, nil, pos(-3, -2))
		one6.dir = 0
		one7 = noInfoRole("��С��", 50, 4, 0, 0, 0, nil, pos(-3, 0))
		one7.dir = 0
		one8 = noInfoRole("��С��", 50, 1, 0, 0, 0, nil, pos(-1, 2))
		one8.dir = 2
		one1 = noInfoRole("�ӷ���", 50, 2, 0, 0, 0, nil, pos(-2, -3))
		one1.dir = 0
		one2 = noInfoRole("��С��", 50, 3, 0, 0, 0, nil, pos(-2, -1))
		one2.dir = 0
		one3 = noInfoRole("��С��", 50, 20, 0, 0, 0, nil, pos(-5, -3))
		one3.dir = 0
		one4 = noInfoRole("��С��", 50, 17, 0, 0, 0, nil, pos(-4, 0))
		one4.dir = 0

		one6:sayDL("���ǿ��������������")

		if delay(0.6) then
			return
		end

		one8:sayDL("��Ҫ�ξ�����Ҫ�ξ���")

		if delay(0.6) then
			return
		end

		one5:sayDR("�����Զ�����������ڣ�")

		if delay(4) then
			return
		end

		stageIndex = "stage16"
	end

	if stageIndex == "stage16" then
		enterStage(nil, 0, 0, {
			trans = {
				"fade",
				0.5
			}
		})
		waitEvt("stage_onTransFinish")
		playSound("dubbing/24", true)
		showText("�Թ��˵�˼���Զ����ִ�š����ϵص��㽡���")
		playSound("CG_bulletin", true)

		local bu = createImage("helperScript/bulletin.png"):scale(display.height / 480):pos(display.cx + 40, display.cy + 30)
		local ani = createFrameAni("bulletin/gaoshi00", 0, 58, 24):center()

		ani:scale(display.height / 480)
		waitEvt("frameAniFinish")
		bu:run(action.fadeOut(2))

		if delay(2.5) then
			return
		end

		showText("������˼���һ��磬�����������۹�����")
		playSound("dubbing/25", true)

		if delay(3.8) then
			return
		end

		stageIndex = "stage17"
	end

	if stageIndex == "stage17" then
		enterStage(nil, 0, 0, {
			trans = {
				"fade",
				1.5
			}
		})
		waitEvt("stage_onTransFinish")
		sound.stopMusic()
		showText("")
		playVideo("LOGO")
		playSound("dubbing/26", true)
		waitEvt("VideoComplete")

		if delay(1) then
			return
		end
	end

	exitStage()
end
