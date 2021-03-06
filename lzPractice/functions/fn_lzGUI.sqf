/*
 * @Author: MoarRightRudder 
 * @Date: 2018-03-13 14:22:36 
 * @Last Modified by:   MoarRightRudder 
 * @Last Modified time: 2018-03-13 14:22:36 
 */
//lzGUI
//Creates the dialog for lz practice

createDialog "lzGUI";

//add numbers to uh1y combo box
for "_i" from 0 to 4 do {
	lbAdd [2100, (str _i)];
};
lbSetCurSel [2100,0];

//add numbers to ch53 combo box
for "_i" from 0 to 3 do {
	lbAdd [2101, (str _i)];
};
lbSetCurSel [2101,0];

//add options to difficulty combo box
{
	lbAdd [2102, _x];
}forEach ["Cold","Mild","Hot","We Gon' Die"];
lbSetCurSel [2102,1];

//add running lz practices to listbox
if (count (missionNamespace getVariable "lzTasks") > 0) then {
	{
		lbAdd[1500, (_x select 0)];
	}forEach (missionNamespace getVariable "lzTasks");
}else {
	lbAdd[1500, "(None)"];
};
//End selected lz scenario
buttonSetAction[2402,"
	_index = lbCurSel 1500;
	if (count (missionNamespace getVariable 'lzTasks') > 0) then {
		_task = ((missionNamespace getVariable 'lzTasks') select _index) select 1;
		missionNameSpace setVariable ['taskState' + _task, 'Canceled', true];
		closeDialog 1;
	};
"];

//set cancel button to close the dialog
buttonSetAction[2401, "closeDialog 2"];

//set start button to take parameters and forward them to lzPractice.sqf
buttonSetAction[2400, "
	_hueys = lbCurSel 2100;
	_stals = lbCurSel 2101;
	_diff = lbCurSel 2102;
	closeDialog 1;
	[_hueys,_stals,_diff,player] remoteExec ['psq_fnc_lzPractice', 2, false]
"];