instruct_50(5, 0, 0, 0, 0, 0, 0);
instruct_50(43, 0, 369, 300, 1797, 200, 200);
instruct_50(3, 0, 0, 100, 15205, 0, 0);
if UseItem(266) == false then goto label0 end;
    instruct_50(0, 101, 0, 0, 0, 0, 0);
    instruct_50(22, 0, 68, 36, 8, 102, 0);
::label0::
    if UseItem(267) == false then goto label1 end;
        instruct_50(0, 101, 1, 0, 0, 0, 0);
        instruct_50(22, 0, 84, 16, 8, 102, 0);
::label1::
        if UseItem(268) == false then goto label2 end;
            instruct_50(0, 101, 2, 0, 0, 0, 0);
            instruct_50(22, 0, 14, 39, 8, 102, 0);
::label2::
            if UseItem(269) == false then goto label3 end;
                instruct_50(0, 101, 3, 0, 0, 0, 0);
                instruct_50(22, 0, 13, 16, 8, 102, 0);
::label3::
                if UseItem(270) == false then goto label4 end;
                    instruct_50(0, 101, 4, 0, 0, 0, 0);
                    instruct_50(22, 0, 23, 1, 8, 102, 0);
::label4::
                    if UseItem(271) == false then goto label5 end;
                        instruct_50(0, 101, 5, 0, 0, 0, 0);
                        instruct_50(22, 0, 61, 64, 8, 102, 0);
::label5::
                        if UseItem(272) == false then goto label6 end;
                            instruct_50(0, 101, 6, 0, 0, 0, 0);
                            instruct_50(22, 0, 62, 5, 8, 102, 0);
::label6::
                            if UseItem(273) == false then goto label7 end;
                                instruct_50(0, 101, 7, 0, 0, 0, 0);
                                instruct_50(22, 0, 105, 80, 8, 102, 0);
::label7::
                                instruct_50(4, 0, 2, 102, 0, 0, 0);
                                if CheckJumpFlag() == true then goto label8 end;
                                    instruct_50(4, 1, 2, 100, 102, 0, 0);
                                    if CheckJumpFlag() == false then goto label9 end;
                                        instruct_50(3, 0, 0, 103, 101, 266, 0);
                                        instruct_50(17, 1, 1, 103, 188, 104, 0);
                                        instruct_50(4, 0, 2, 104, 1, 0, 0);
                                        if CheckJumpFlag() == true then goto label10 end;
                                            instruct_50(16, 1, 1, 103, 188, 1, 0);
                                            instruct_50(22, 0, 107, 0, 8, 104, 0);
                                            instruct_50(3, 0, 0, 104, 104, 1, 0);
                                            instruct_50(21, 8, 107, 0, 8, 104, 0);
                                            instruct_50(4, 0, 2, 104, 8, 0, 0);
                                            if CheckJumpFlag() == false then goto label11 end;
                                                instruct_50(23, 0, 107, 1, 40, 13, 0);
                                                instruct_50(23, 0, 107, 1, 39, 35, 0);
::label10::
::label11::
                                                instruct_50(3, 0, 0, 105, 101, 13335, 0);
                                                instruct_50(32, 0, 105, 1, 0, 0, 0);
                                                ShowTitle("每行第一個字，從右到左念，似乎有藏字：「大....清....入....關....為....防....漢....人....造....反....特....將....盡....數....寶....藏....置....於....某....處....以....備....不....時....之....需....零口口，口口口」", 1797);
exit();
::label8::
::label9::
                                                ShowTitle("本頁為佛家思想的內容，沒有什麼特別的。", 1797);
exit();
