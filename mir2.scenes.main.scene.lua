local current = ...
local ui = import(".ui")
local ground = import(".ground")
local common = import(".common.common")
local operate = import(".pc.operate")
local baseScene = import("..baseScene", current)
local scene = class("main", baseScene)

table.merge(scene, {})

function scene:ctor()
	main_scene = self
	self.ground = ground.new():addto(self)
	self.ui = ui.new():addto(self):hide()

	pic.setListenner(import(".common.picListenner", current))
	voice.setListenner(import(".common.voiceListenner", current))
	net.add(self)
	net.add(self.ui)
	net.add(self.ground)
	net.send({
		CM_LOGINNOTICEOK
	}, nil, getRecord("TOsVersion3"))
	net.setWaitMsg(SM_NEWMAP, SM_MAPINFO_EX)

	if device.platform == "android" then
		self:setKeypadEnabled(true)
		self:addNodeEventListener(cc.KEYPAD_EVENT, function (event)
			if event.key == "back" then
				an.newMsgbox("ȷ��Ҫ�˳���Ϸ��?", function (idx)
					if idx == 1 then
						net.send({
							CM_SOFTCLOSE
						})
						os.exit(1)
					end
				end, {
					center = true,
					hasCancel = true
				})
			end
		end)
	end

	self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, function (...)
		self.ground:update(...)
		self.ui:update(...)
	end)
	self:scheduleUpdate()

	if DEBUG > 0 then
		net.sendPing()
		g_data.client:setLastTime("ping", true)
	end

	if WIN32_OPERATE then
		operate.init()
		self:initHotKey()
	end
end

function scene:onEnter()
	print("main.scene:onEnter")
	self.super.onEnter(self)
	g_data.shop:init()
end

function scene:onExit()
	print("main.scene:onExit")
	self.super.onExit(self)
end

function scene:smallExit()
	self.smallExitState = true

	net.send({
		CM_SOFTCLOSE
	})
end

function scene:bigExit()
	self:clearGameData()
	common.gotoLogin({
		logout = true
	})
end

function scene:clearGameData()
	if IS_PLAYER_DEBUG then
		package.loaded["mir2.scenes.main.scene"] = nil
		package.loaded["mir2.scenes.main.ground"] = nil
		package.loaded["mir2.scenes.main.ui"] = nil
	end

	local function createProgress()
		if self.reprogress then
			self.reprogress:stopAllActions()
			self.reprogress:removeSelf()

			self.reprogress = nil
		end

		self.reprogress = an.newProgress(res.gettex2("pic/console/bottom/pro2.png"), res.gettex2("pic/console/bottom/probg.png"), {
			x = 43,
			y = 4
		}):anchor(0.5, 0):pos(display.width * 0.5, 0):add2(self, 1)

		self.reprogress:setp(0)

		local prodata = 0

		self.reprogress:runForever(transition.sequence({
			cc.DelayTime:create(0.1),
			cc.CallFunc:create(function ()
				prodata = prodata + 0.02

				self.reprogress:setp(prodata > 1 and 1 or prodata)

				if prodata > 1 and prodata < 1.1 and self.reprogress then
					self.reprogress:stopAllActions()
					self.reprogress:removeSelf()

					self.reprogress = nil
				end
			end)
		}))
	end

	if not main_scene then
		createProgress()

		return
	end

	self.ui.console.controller.autoFindPath:multiMapPathStop()
	self:removeAllNodeEventListeners()
	self.ui:removeSelf()
	self.ground:removeSelf()

	if g_data.login.reconnectState then
		self:add(an.newLabel("����������..", 20, 1, {
			color = cc.c3b(255, 255, 0),
			sc = display.COLOR_BLACK
		}):anchor(0.5, 0):pos(display.cx, 30))
		createProgress()
	else
		self:add(an.newLabel("�����˳�..", 20, 1, {
			color = cc.c3b(255, 255, 0),
			sc = display.COLOR_BLACK
		}):anchor(0.5, 0):pos(display.cx, 30))
	end

	main_scene = nil

	net.clearMsgs()
	g_data.cleanup()
	g_data.reset()
	audio.stopAllSounds()
	res.purgeCachedData()
	pic.removeListenner()
	voice.removeListenner()
end

function scene:phone_listenner(state, number)
	if state == 1 then
		-- Nothing
	end
end

function scene:reconectFuc(info)
	if not tolua.isnull(self.reconnectBox) then
		self.reconnectBox:removeSelf()

		self.reconnectBox = nil
	end

	if not self.reconnectBox then
		self.reconnectBox = an.newMsgbox(info .. "\nȷ������?", function (idx)
			print(idx)

			if idx == 0 then
				self:bigExit()
			elseif idx == 1 then
				self.reconnect = true
				g_data.login.reconnectState = true

				scheduler.performWithDelayGlobal(function ()
					net.connect(g_data.login.recIP, g_data.login.recPort, self, g_data.login.recSession)
				end, 0)
			end

			self.reconnectBox = nil
		end, {
			center = true,
			hasCancel = true
		})
	end
end

function scene:socketEvent(data, status)
	if status == 3 then
		self:reconectFuc(self.reconnect and "���ӳ�ʱ�жϣ�����ʧ��" or "��������Ͽ�����")
	elseif status == 2 then
		self:reconectFuc("���ӷ�����ʧ�ܣ��������粢�Ժ�����")
	end
end

function scene:onLoseConnect()
	print("scene:onLoseConnect")

	if not tolua.isnull(self.reconnectBox) then
		self.reconnectBox:removeSelf()

		self.reconnectBox = nil
	end

	self.reconnectBox = self:reconectFuc("���������ѶϿ�!")
end

if device.platform == "android" then
	function scene:onNetworkStateChange(currentState)
		print("android,scene:onNetworkStateChange", currentState)

		if not tolua.isnull(self.reconnectBox) then
			self.reconnectBox:removeSelf()

			self.reconnectBox = nil
		end

		self:reconectFuc("�л��� " .. (currentState == cc.kCCNetworkStatusReachableViaWiFi and "WIFI����" or "��������"))
	end
else
	function scene:onNetworkStateChange(currentState)
		print("ios,scene:onNetworkStateChange", currentState)

		if network.isHostNameReachable("www.baidu.com") then
			if not tolua.isnull(self.reconnectBox) then
				self.reconnectBox:removeSelf()

				self.reconnectBox = nil

				self:reconectFuc("�л��� " .. (currentState == cc.kCCNetworkStatusReachableViaWiFi and "WIFI����" or "��������"))
			end

			if currentState == cc.kCCNetworkStatusReachableViaWiFi then
				if self.ui then
					self.ui:tip("�л���WIFI����")
				end
			elseif self.ui then
				self.ui:tip("�л�����������")
			end
		else
			self:reconectFuc("���������ѶϿ�")
		end
	end
end

function scene:enterSelectScene(msg, buf, bufLen)
	if msg.recog == 1 then
		net.remove(self.ui)
		net.remove(self.ground)
		g_data.select:receiveChrs(msg, buf, bufLen)
		self:clearGameData()

		if self.reconnect then
			self.reconnect = false
			g_data.login.reconnectState = false

			self:runs({
				cc.DelayTime:create(5),
				cc.CallFunc:create(function ()
					net.remove(self)

					if not self.reconnectBox then
						print("ReIn Game ")

						if self.isLoginQueue then
							game.gotoscene("select", nil, "fade", 0.5, display.COLOR_BLACK)
						else
							net.send({
								CM_SELCHR
							}, {
								g_data.select:getCurName()
							})
							game.gotoscene("notice", nil, "fade", 0.5, display.COLOR_BLACK)
						end
					end
				end)
			})
		else
			net.remove(self)
			game.gotoscene("select", nil, "fade", 0.5, display.COLOR_BLACK)
		end
	end
end

function scene:processMsg(msg, buf, bufLen)
	if not msg then
		return
	end

	local function tip(str, func)
		an.newMsgbox(str, func)
	end

	local ident = msg.ident

	if SM_CHR_LIST == ident then
		self.isLoginQueue = false

		if not self.smallExitState then
			g_data.login.roleInfo = {
				msg = msg,
				buf = buf,
				bufLen = bufLen
			}
		else
			self.smallExitState = false

			self:enterSelectScene(msg, buf, bufLen)

			if WIN32_OPERATE then
				operate.unRegisterEvent()
			end
		end
	elseif SM_New_Version == ident then
		-- Nothing
	elseif SM_LOGIN == ident then
		net.send({
			CM_RECONNECT
		}, {
			g_data.reconnctID
		})
	elseif SM_LOGIN_AUTH == ident then
		if msg.param == 2 then
			-- Nothing
		elseif msg.param == 1 then
			local ret1 = getRecord("TLoginIdResult")
			local ret2 = getRecord("TLoginIdResult2")

			if ret1:size() < bufLen then
				net.record(ret2, buf, bufLen)

				g_data.reconnctID = ret2:get("reconnectID")
				g_data.login.loginRet2 = ret2
			else
				net.record(ret1, buf, bufLen)

				g_data.login.loginRet1 = ret1
			end
		end
	elseif SM_OUTOFCONNECTION == ident then
		-- Nothing
	elseif SM_OUTOFCONNECTION_KICKOUT == ident then
		self:reconectFuc("�Ѿ��������û�������")
	elseif SM_RECONNECT == ident then
		-- Nothing
	elseif SM_LOGIN_ALREADY_ONLINE == ident then
		if msg.recog == 1 then
			self.kickoutBox = an.newMsgbox("���˺�Ŀǰ���ߣ��Ƿ�ǿ�е�¼?", function (idx)
				if idx == 1 then
					self:enterSelectScene(g_data.login.roleInfo.msg, g_data.login.roleInfo.buf, g_data.login.roleInfo.bufLen)
				end

				self.kickoutBox = nil

				net.send({
					CM_LOGIN_ALREADY_ONLINE,
					param = idx == 1 and 1 or 0
				})
			end, {
				center = true,
				hasCancel = true
			})
		else
			self:enterSelectScene(g_data.login.roleInfo.msg, g_data.login.roleInfo.buf, g_data.login.roleInfo.bufLen)
		end
	elseif SM_LOGIN_QUEUE == ident then
		self.isLoginQueue = true

		g_data.login:setQueueData(msg)
	elseif SM_SELCHR_ERR == ident then
		an.newMsgbox("������ά���У����Ժ�����", function ()
			self:bigExit()
		end, {
			center = true
		})
	elseif ident == 11706 then
		an.newMsgbox("����ʧ��,�����µ�½", function ()
			self:bigExit()
		end, {
			center = true
		})
	elseif SM_JPUSH_SETALIAS == ident then
		local alias = net.str(buf)

		jpush.setAlias(alias)
	end

	return true
end

function scene:initHotKey()
	local data = cache.getHotKey(common.getPlayerName())
	data = data or def.operate.hotKey

	g_data.hotKey:setKeyInfos(data)
end

return scene
