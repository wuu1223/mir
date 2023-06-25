local messageBox = class("messageBox")

table.merge(messageBox, {
	panel,
	view,
	viewSize = {
		w = 370,
		h = 165
	}
})

function messageBox:messageBox(titlePng, btnList, callback, params)
	params = params or {}
	local scene = cc.Director:getInstance():getRunningScene().s
	local panel = display.newSprite(res.gettex2("pic/common/msgbox.png")):add2(scene, 999):center()

	panel:enableClick(function ()
	end, {
		support = "drag"
	})

	local view = an.newScroll(4, 4, self.viewSize.w, self.viewSize.h):anchor(0, 1):add2(panel):pos(26, 231)
	local title = display.newSprite(res.gettex2(titlePng)):add2(panel)

	title:pos(panel:getw() / 2, panel:geth() - title:geth() / 2 - 5)

	local co = coroutine.running()

	local function onBtn(v)
		sound.playSound("103")

		if v.cb then
			v.cb()
		elseif callback then
			callback(v)
		elseif co then
			coroutine.resume(co, v.evt)
		end

		panel:removeSelf()
	end

	local btnInterval = params.btnInterval or 20
	local btnBase = display.newNode():add2(panel):anchor(0.5, 0.5):pos(panel:getw() / 2, 20)
	local listWidth = 0

	for k, v in ipairs(btnList or {
		{
			title = "ȷ ��",
			evt = "ok"
		},
		{
			title = "ȡ ��",
			evt = "cancel"
		}
	}) do
		local pressImage = v.image and v.press or "pic/common/btn21.png"
		local btn = an.newBtn(res.gettex2(v.image or "pic/common/btn20.png"), handler(v, onBtn), {
			pressImage = res.gettex2(pressImage),
			label = {
				v.title,
				18,
				1,
				{
					color = def.colors.btn30
				}
			}
		}):add2(btnBase):anchor(0, 0):pos(listWidth + btnInterval / 2, 0)
		listWidth = listWidth + btn:getw() + btnInterval
		v.idx = k
	end

	btnBase:setContentSize(listWidth, 20)

	if params.popStyle then
		common.enablePopStyle(panel)
	end

	self.panel = panel
	self.view = view

	return panel, view
end

function messageBox:enableScroll(enable)
	self.view:enableTouch(false)
end

function messageBox.confirm(titlePng, text, btnList, callback, params)
	params = params or {}
	local msgbox = messageBox.new()
	local panel, view = msgbox:messageBox(titlePng, btnList, callback, params)
	local content = nil

	if params.center then
		content = an.newLabel(text, params.fontSize or 18, 1, {
			color = cc.c3b(228, 219, 193)
		}):pos(0, msgbox.viewSize.h):add2(view):anchor(0.5, 0.5):debug()

		content:pos(msgbox.viewSize.w / 2, msgbox.viewSize.h / 2)
	else
		content = an.newLabelM(msgbox.viewSize.w, params.fontSize or 18, 1):pos(0, msgbox.viewSize.h):add2(view):anchor(0, 1):addLabel(text, cc.c3b(228, 219, 193))

		if content:geth() < 160 then
			msgbox:enableScroll(false)
		end
	end

	local co = coroutine.running()

	if co and not callback then
		return coroutine.yield("messageBox")
	end

	return panel, view
end

function messageBox.prompt(titlePng, placeholder, btnList, callback, params)
	params = params or {}
	local msgbox = messageBox.new()
	local input = nil
	local co = coroutine.running()
	local panel, view = msgbox:messageBox(titlePng, btnList, function (event)
		if callback then
			callback(event, input:getString())
		elseif co then
			coroutine.resume(co, event.evt, input:getString())
		end
	end, params)

	msgbox:enableScroll(false)

	local base = display.newScale9Sprite(res.getframe2("pic/scale/scale16.png"), 0, 0, cc.size(view:getw() - 20, 40)):anchor(0.5, 0.5):pos(msgbox.viewSize.w / 2, msgbox.viewSize.h / 2 + 10):add2(view, 2)
	input = an.newInput(10, base:geth() / 2, view:getw() - 40, 40, params.max, {
		label = {
			"",
			20
		},
		tip = {
			placeholder or "",
			20,
			1
		},
		checkCLen = params.max
	}):addTo(base):anchor(0, 0.5)

	if params.tip then
		an.newLabel(params.tip, params.fontSize or 18, 1, {
			color = cc.c3b(228, 219, 193)
		}):pos(-10, 50):anchor(0, 0):add2(input)
	end

	if co and not callback then
		return coroutine.yield("messageBox")
	end

	return panel, view
end

function messageBox.test()
	local i = 1
	local testList = {}

	function nextTest()
		if testList[i] then
			testList[i]()

			i = i + 1
		end
	end

	local function testWithCoroutine()
		local function test()
			print(messageBox.confirm("pic/panels/friend/add.PNG", "����Э��ʵ�ֵ�messagebox����ǰ�߳���Э�̵�����£�ֱ����ť�б�����ʱ����", {
				{
					title = "�������",
					evt = "Ӧ���ڰ��·��ذ�ť��,�ڿ���̨��������ı�"
				}
			}))
			print(messageBox.prompt("pic/panels/friend/add.PNG", "��������", {
				{
					title = "�������",
					evt = "Ӧ���ڰ��·��ذ�ť��,�ڿ���̨��������ı�,�Լ������������"
				}
			}))
			nextTest()
		end

		local co = coroutine.create(function ()
			print(xpcall(test, __G__TRACKBACK__))
		end)

		coroutine.resume(co)
	end

	table.insert(testList, testWithCoroutine)

	local function btnCB(btnData)
		print("btnCB", btnData.evt)
		nextTest()
	end

	local function testScroll()
		print(messageBox.confirm("pic/panels/friend/add.PNG", [[
�����Զ�����===\n
			����������������ʥ���ڷ������ƵĻָ��߿���
			�Է��ᾡ���յ��ظ������յ��ظ������յ��󷿼ۿ���
			�Ļָ������ǵĻ�����������������������������������
			�ķ��ɻ��ʦ�ķ����˼�ʵ�Ŀ��ַ��ֵķ��ۿ��ٴ����
			β�ҿ��˷���Ϊ�Ƽ�������Ƽ����ָ��ͻ�����Ͷ�������
			����������������������������������������������������
			��������������������������������������������������������]], nil, btnCB))
	end

	table.insert(testList, testScroll)

	local function testCenterAlign()
		print(messageBox.confirm("pic/panels/friend/add.PNG", "���Ծ���", nil, btnCB, {
			center = true,
			fontSize = 25
		}))
	end

	table.insert(testList, testCenterAlign)

	local function testBtnList()
		print(messageBox.confirm("pic/panels/friend/add.PNG", "���԰�ť�б�", {
			{
				title = "��ť1",
				evt = "btn1"
			},
			{
				title = "��ť2",
				evt = "btn2"
			},
			{
				title = "��ť3",
				evt = "btn3"
			}
		}, btnCB, {
			center = true
		}))
	end

	table.insert(testList, testBtnList)

	local function testBtnInterval()
		print(messageBox.confirm("pic/panels/friend/add.PNG", "���԰�ť��϶,���0", {
			{
				title = "��ť1",
				evt = "btn1"
			},
			{
				title = "��ť2",
				evt = "btn2"
			}
		}, btnCB, {
			btnInterval = 0
		}))
	end

	table.insert(testList, testBtnInterval)

	local function testBtnInterval2()
		print(messageBox.confirm("pic/panels/friend/add.PNG", "���԰�ť��϶,���100", {
			{
				title = "��ť1",
				evt = "btn1"
			},
			{
				title = "��ť2",
				evt = "btn2"
			}
		}, btnCB, {
			btnInterval = 100
		}))
	end

	table.insert(testList, testBtnInterval2)

	messageBox = import(".messageBox")

	nextTest()
end

return messageBox
