Talk(422, "哇，這裡花開似錦，滿園芬芳，如仙境一般，姑娘不愧是傳說中的蒔花聖手。", -2, 0, 0, 0);
Talk(96, "唯手熟爾，少俠過獎了。", -2, 1, 0, 0);
Talk(0, "在下與一些好友居住的江南歸雲莊有座花園，因為我們都不太精於此道，現下滿園荒涼。在下冒昧，可否麻煩姑娘同去歸雲莊，幫忙打理花園？", -2, 0, 0, 0);
Talk(96, "此事也不難，不過我要先考考你。我說一句詩，詩中描述了一種花，如果你看得出是什麼花，我就幫你這個忙。", -2, 1, 0, 0);
Talk(0, "姑娘請儘管出題。", -2, 0, 0, 0);
Talk(96, "聽好了：三生石上舊精魂，賞月吟風莫要論。請問此句說的是什麼花？", -2, 1, 0, 0);
instruct_50(43, 0, 351, 9593, 4, 0, 0);
instruct_50(4, 0, 2, 28931, 2, 0, 0);
if CheckJumpFlag() == true then goto label0 end;
    Talk(96, "看來少俠對花還知之甚少，我暫時不能幫你。", -2, 1, 0, 0);
    exit();
::label0::
    Talk(96, "三生石上彼岸花，確是蔓珠沙華沒錯。沒想到少俠對花也有些瞭解，我就隨你去歸雲莊。這“百花清露”是採自我園中百花，清香雋永，就送與少俠。", -2, 0, 0, 0);
    DarkScence();
    ModifyEvent(65, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, -2);
    LightScence();
    instruct_50(43, 0, 209, 72, 2, 0, 0);
    instruct_50(43, 0, 228, 72, 96, 0, 0);
    ModifyEvent(15, 45, 1, 0, 793, 0, 0, 7064, 7064, 7064, 0, -2, -2);
    GetItem(251, 1);
exit();