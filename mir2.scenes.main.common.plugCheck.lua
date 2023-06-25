local common = import(".common")
local plugCheck = {}
local state, loading = nil
local initWait = 1
local initcnt = 0
local initSendMin = 2
local initErrCount = {}
local initErrAllow = 20
local normalWait = 5
local timeout = 60
local timecnt = 0
local allowDiff = 5
local allowErr = 8
local allowSendTimeLong = 10
local errCode = {
	speed = -1,
	timeOut = 1,
	initErr = 2,
	sendTimeLong = 3
}
PLUG_CHECK_DATA = PLUG_CHECK_DATA or {
	inited,
	diff,
	warning,
	errCount,
	sendTimeLongCount
}

function plugCheck.get()
	loading = socket.gettime()

	net.send_old({
		CM_SPEEDHACKUSER
	})
end

function plugCheck.update(dt)
	if state == "kill" then
		return
	end

	if loading then
		timecnt = timecnt + dt

		if timeout < timecnt then
			plugCheck.kill("timeOut", state)
		end

		return
	end

	if PLUG_CHECK_DATA.inited then
		if PLUG_CHECK_DATA.warning then
			state = "warning"
		else
			state = "normal"
		end
	else
		state = "init"
	end

	if state == "init" then
		initcnt = initcnt + dt

		if initWait < initcnt then
			plugCheck.get()
		end
	elseif state == "normal" then
		timecnt = timecnt + dt

		if normalWait < timecnt then
			plugCheck.get()
		end
	elseif state == "warning" then
		plugCheck.get()
	end
end

function plugCheck.verify(serverTime)
	local currentTime = socket.gettime()
	local sendTime = loading
	loading = false
	timecnt = 0
	local clientTime = math.modf(currentTime)

	if not PLUG_CHECK_DATA.inited then
		if currentTime - sendTime < initSendMin then
			PLUG_CHECK_DATA.inited = true
			PLUG_CHECK_DATA.diff = math.abs(clientTime - serverTime)
			PLUG_CHECK_DATA.errCount = {}
			PLUG_CHECK_DATA.sendTimeLongCount = {}
			state = "normal"
		else
			initErrCount[#initErrCount + 1] = currentTime - sendTime

			if initErrAllow < #initErrCount then
				local detail = ""

				for i, v in ipairs(initErrCount) do
					local time = string.format("%.2f", v)
					detail = detail .. time .. "-"
				end

				plugCheck.kill("initErr", detail)
			end
		end

		return
	end

	if allowDiff < currentTime - sendTime then
		PLUG_CHECK_DATA.warning = true
		PLUG_CHECK_DATA.sendTimeLongCount[#PLUG_CHECK_DATA.sendTimeLongCount + 1] = currentTime - sendTime

		if allowSendTimeLong < #PLUG_CHECK_DATA.sendTimeLongCount then
			local detail = ""

			for i, v in ipairs(PLUG_CHECK_DATA.sendTimeLongCount) do
				local time = string.format("%.2f", v)
				detail = detail .. time .. "-"
			end

			plugCheck.kill("sendTimeLong", detail)
		end

		return
	else
		PLUG_CHECK_DATA.sendTimeLongCount = {}
	end

	local diff = math.abs(math.abs(clientTime - serverTime) - PLUG_CHECK_DATA.diff)

	if allowDiff < diff then
		PLUG_CHECK_DATA.warning = true
		PLUG_CHECK_DATA.errCount[#PLUG_CHECK_DATA.errCount + 1] = diff

		if allowErr < #PLUG_CHECK_DATA.errCount then
			local detail = ""

			for i, v in ipairs(PLUG_CHECK_DATA.errCount) do
				local time = string.format("%.2f", v)
				detail = detail .. time .. "-"
			end

			plugCheck.kill("speed", detail)
		end
	else
		PLUG_CHECK_DATA.warning = nil
		PLUG_CHECK_DATA.errCount = {}
	end
end

function plugCheck.kill(key, detail)
	net.send({
		CM_SOFTCLOSE
	})

	if key == "speed" then
		an.newMsgbox({
			{
				"�밮����Ϸ����\n"
			},
			{
				"�˴ο����ٸ����ѱ�ϵͳ��¼��",
				cc.c3b(255, 0, 0)
			}
		}, function ()
			os.exit(0)
		end, {
			fontSize = 17
		})
	else
		an.newMsgbox("��������Ͽ�����. (�������: " .. errCode[key] .. ")", function ()
			os.exit(0)
		end, {
			center = true
		})
	end

	state = "kill"
end

return plugCheck
