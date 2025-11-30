#include <a_samp>
#include <core>
#include <float>
#include <sampvoice>

#pragma tabsize 0

new SV_LSTREAM:lstream[MAX_PLAYERS] = { SV_NULL, ... };

public SV_VOID:OnPlayerActivationKeyPress(
	SV_UINT:playerid,
	SV_UINT:keyid
) {
	if (keyid == 0x42 && lstream[playerid]) SvAttachSpeakerToStream(lstream[playerid], playerid);
}

public SV_VOID:OnPlayerActivationKeyRelease(
	SV_UINT:playerid,
	SV_UINT:keyid
) {
	if (keyid == 0x42 && lstream[playerid]) SvDetachSpeakerFromStream(lstream[playerid], playerid);
}

public OnPlayerConnect(playerid) {

	if (!SvGetVersion(playerid)) SendClientMessage(playerid, 0xFF0000FF, "� {C2A2DA}You {FF0000}haven't{C2A2DA} installed SAMP Voice plugin.");
	else if (!SvHasMicro(playerid)) SendClientMessage(playerid, 0xFF0000FF, "� {C2A2DA}You {FF0000}don't have{C2A2DA} microphone.");
	else {
	    SendClientMessage(playerid, 0x00FF00FF, "� {C2A2DA}SAMP Voice plugin {00FF00}loaded{C2A2DA}.");
		lstream[playerid] = SvCreateDLStreamAtPlayer(40.0, SV_INFINITY, playerid, 0x00FF00FF, "L");
		SvAddKey(playerid, 0x42);
	}
	return 1;
	
}

public OnPlayerDisconnect(playerid, reason) {
	if (lstream[playerid]) {
		SvDeleteStream(lstream[playerid]);
		lstream[playerid] = SV_NULL;
	}
	return 1;
	
}
