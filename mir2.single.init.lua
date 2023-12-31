local current = ...

xpcall(function ()
	game = import(".game", current)
	res = import(".res", current)
	net = import(".net", current)
	sound = import(".sound", current)
	cache = import(".cache", current)
	voice = import(".voice", current)
	pic = import(".pic", current)
	m2debug = import(".m2debug", current)
	m2spr = import(".m2spr", current)
	gameEvent = import(".gameEvent", current)
	jpush = import(".jpush", current)
	IAP = import(".iap", current)
end, __G__TRACKBACK__)
