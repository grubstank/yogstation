/datum/pai/software/remote_control
	name = "IPv18 External Console Control Interface"
	description = "Allows handshaking and remote use of many station-bound consoles regardless of distance. RAM intensive."
	category = "Advanced"
	sid = "remotecontrol"
	ram = 60

/datum/pai/software/remote_control/action_menu(mob/living/silicon/pai/user)
	var/dat = "<h3>Remote control</h3>"
	dat += "Connection status: "
	if(!user.paired)
		if(!user.pairing)
			dat += "<font color=$FF5555>Disconnected</font> <br>"
			dat += "<a href='byond://?src=\ref[user];software=remote;pair=1;sub=0'>Initiate connection</a> <br>"
			return dat
		else
			dat += "<font color=#FFFF55>Waiting for connection...</font> <br>"
			dat += "<a href='byond://?src=\ref[user];software=remote;abort=1;sub=0'>Abort</a> <br>"
			dat += "Request to be swiped near the computer's network card to begin remote control handshake.<br>"
			return dat
	dat += "<font color=#55FF55>Connected to [user.paired.name]</font> <br>"
	dat += "<a href='byond://?src=\ref[user];software=remote;control=1;sub=0'>Access remote interface</a> <br>"
	dat += "<a href='byond://?src=\ref[user];software=remote;disconnect=1;sub=0'>Disconnect</a> <br>"
	return dat

/datum/pai/software/remote_control/action_use(mob/living/silicon/pai/user, var/args)
	if(args["pair"])
		user.pairing = 1
	if(args["abort"])
		user.pairing = 0
	if(args["control"])
		if(user.paired)
			user.paired.attack_hand(src)
	if(args["disconnect"])
		user.unpair(1)
		user.pairing = 0
