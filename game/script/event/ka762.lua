--武三通 种子 水 粮食
clear();
itemA='種子';
itemB='水';
personID=65;
personSay="有合適的種子和水嗎?我来给你种!";
list1={206,207,208};
list2={209,210};
list3={
	[string.format('%d+%d',206,209)]=223,
	[string.format('%d+%d',206,210)]=223,
	[string.format('%d+%d',207,209)]=224,
	[string.format('%d+%d',207,210)]=224,
	[string.format('%d+%d',208,209)]=225,
	[string.format('%d+%d',208,210)]=225,
};
execevent(241);
exit();
