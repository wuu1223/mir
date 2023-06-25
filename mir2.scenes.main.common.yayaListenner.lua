local common = import(".common")
local yayaListenner = {
	authEnd = function (dic)
	end,
	loginEnd = function (dic)
		main_scene.ui.console:call("btnVoiceJIT", "voice_call", "stateHasChanged")
	end,
	micEnd = function (dic)
		if result ~= 0 then
			main_scene.ui:tip(dic.msg or "")
		elseif dic.ison then
			main_scene.ui:tip("����ɹ�, �����ڿ���˵����...")
		end

		main_scene.ui.console:call("btnVoiceJIT", "voice_call", "setSaying", yaya.isonMic)
	end,
	micModeEnd = function (dic)
		main_scene.ui.console:call("btnVoiceJIT", "voice_call", "loadingCheck")
	end,
	micModeNotify = function (dic)
		main_scene.ui.console:call("btnVoiceJIT", "voice_call", "loadingCheck")
	end,
	realtimeVoice = function (dic)
		if main_scene.ui.panels.voice then
			main_scene.ui.panels.voice:addOnMicMember(dic.gamedata)
		end
	end,
	realtimeVoiceErr = function (dic)
		main_scene.ui:tip("ʵʱ��������: " .. dic.msg)
	end
}

return yayaListenner
