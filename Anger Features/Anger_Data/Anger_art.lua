local ascii_art = {}


local All_ASCII_art = {
	["ASCII_2T1"] = {  --2
		[0]=" ",
		[1]="                              ...,,,,*/////////***,,,..",
		[2]="                          .*##(*,,...           .....,/##(*.",
		[3]="                      ,/(/*,..                          ..,*/(*,",
		[4]="                  .,/(*,..                                  ..,/(/,",
		[5]="                .*(*,                                            ,/(*.",
		[6]="              ,((*.       ........                  ...,*(%&@@@#,  .*((.",
		[7]="            .//*.     *(#%%&&&&&&%%#/,.           /(#%&@@@@@@@@#,    .*/*",
		[8]="           ,(/,     /&@@@@@@&%%&@@@@@&(..        (&@@@@@@@@@@@&#,     .,/(,",
		[9]="         /(*.    .#&@@@@@&#**,(&@@@@@%*.        (&@@@@@@@@@@@&#        .*(/",
		[10]="       .*/*      ,#@@@@@@&   *%@@@@@@#,.        (&@@@@@@@@@@@&(         .*/*.",
		[11]="       ,(,.       ****      /&@@@@@@#*               &@@@@@@@&(          .*(,",
		[12]="      .*(,.               *%@@&&%#(*   %&@@@@@%/     &@@@@@@@&(           ,(,.",
		[13]="      ,//.              .*/(###%%(*   (@@@@@@@#*     &@@@@@@@&(           ,/*,",
		[14]="      */*.            ,*%@@@@@@%(,   *#@@@@@@@#,    (&@@@@@@@%(           .*/,",
		[15]="      */*.           *#@@@@@@@#*.   ./%@@@@@@@&&&@@@@@@@@@@@@%/           .*/*",
		[16]="      */*.         ,(&@@@@@@&%###%%&&@@@@@@@@@@@@@@@@@@@@@@@@%/           ,//,",
		[17]="      .*/,       ./%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%/           ,(*.",
		[18]="       ,(,.     .*%@@@@@@@@@@@@@@@@@@@@@@@@@@@&%#((/%@@@@@@@@%/           *(,",
		[19]="       ./*,     .*%@@@&&%%###((//***(%@@@@@@@#*     #@@@@@@@@#*          ,*/.",
		[20]="        .(/..                      .(&@@@@@@&(,     #@@@@@@@@#*        .,(/.",
		[21]="         .*#*.                     ,#&@@@@@@&/,     #@@@@@@@@#*       .*#*.",
		[22]="          .,//..                   ,%@@@@@@@&*      #@@@%#*,         .//,",
		[23]="            .*(*.                  *%@@@@@@@%,      **             ,*(*.",
		[24]="              ./(*..   .           /&@@@@@@@#,                  .,*(/",
		[25]="                .,((*.             (&@@@@@&(*                ../((,.",
		[26]="                   .*//*,...       #@&%#/,              ...*///*.",
		[27]="                       .*((/*,.                  .....,*/(/*.",
		[28]="                            .*/(((((/****,,***//((((//,.",
		[29]="                                    ...,,,,,...."

	},
	
	["ASCII_big_skull"] = {  --3
		[0]=" ",
		[1]="                             ...----....",
		[2]="                         ..-:\"''         ''\"-..",
		[3]="                      .-'                      '-.",
		[4]="                    .'              .     .       '.",
		[5]="                  .'   .          .    .      .    .''.",
		[6]="                .'  .    .       .   .   .     .   . ..:.",
		[7]="              .' .   . .  .       .   .   ..  .   . ....::.",
		[8]="             ..   .   .      .  .    .     .  ..  . ....:IA.",
		[9]="            .:  .   .    .    .  .  .    .. .  .. .. ....:IA.",
		[10]="           .: .   .   ..   .    .     . . .. . ... ....:.:VHA.",
		[11]="           '..  .  .. .   .       .  . .. . .. . .....:.::IHHB.",
		[12]="          .:. .  . .  . .   .  .  . . . ...:.:... .......:HIHMM.",
		[13]="         .:.... .   . .\"::\"'.. .   .  . .:.:.:II;,. .. ..:IHIMMA",
		[14]="         ':.:..  ..::IHHHHHI::. . .  ...:.::::.,,,. . ....VIMMHM",
		[15]="        .:::I. .AHHHHHHHHHHAI::. .:...,:IIHHHHHHMMMHHL:. . VMMMM",
		[16]="       .:.:V.:IVHHANGERMHMHHH::..:\" .:HIHHHHFEATURESHMHHA. .VMMM.",
		[17]="       :..V.:IVHHHANGERHHHHHHB... . .:VPHHMFEATURESHHHHHHAI.:VMMI",
		[18]="       ::V..:VIHHHANGERMHHHHHH. .   .I\":IIMFEATURESHHHHHHHAPI:WMM",
		[19]="       ::\". .:.HHANGERHMMHHHHHI.  . .:..I:MHMFEATURESHHMHV:':H:WM",
		[20]="       :: . :.::IIHHHHHHMMHHHHV  .ABA.:.:IMHMHMMMHMHHHHV:'. .IHWW",
		[21]="       '.  ..:..:.:IHHHHHMMHV\" .AVMHMA.:.'VHMMMMHHHHHV:' .  :IHWV",
		[22]="        :.  .:...:\".:.:TPP\"   .AVMMHMMA.:. \"VMMHHHP.:... .. :IVAI",
		[23]="       .:.   '... .:\"'   .   ..HMMMHMMMA::. .\"VHHI:::....  .:IHW'",
		[24]="       ...  .  . ..:IIPPIH: ..HMMMI.MMMV:I:.  .:ILLH:.. ...:I:IM",
		[25]="     : .   .'\"' .:.V\". .. .  :HMMM:IMMMI::I. ..:HHIIPPHI::'.P:HM.",
		[26]="     :.  .  .  .. ..:.. .    :AMMM IMMMM..:...:IV\":T::I::.\".:IHIMA",
		[27]="     'V:.. .. . .. .  .  .   'VMMV..VMMV :....:V:.:..:....::IHHHMH",
		[28]="       \"IHH:.II:.. .:. .  . . . \" :HB\"\" . . ..PI:.::.:::..:IHHMMV\"",
		[29]="        :IP\"\"HHII:.  .  .    . . .'V:. . . ..:IH:.:.::IHIHHMMMMM\"",
		[30]="        :V:. VIMA:I..  .     .  . .. . .  .:.I:I:..:IHHHHMMHHMMM",
		[31]="        :\"VI:.VWMA::. .:      .   .. .:. ..:.I::.:IVHHHMMMHMMMMI",
		[32]="        :.\"VIIHHMMA:.  .   .   .:  .:.. . .:.II:I:AMMMMMMHMMMMMI",
		[33]="        :..VIHIHMMMI...::.,:.,:!\"I:!\"I!\"I!\"V:AI:VAMMMMMMHMMMMMM'",
		[34]="        ':.:HIHIMHHA:\"!!\"I.:AXXXVVXXXXXXXA:.\"HPHIMMMMHHMHMMMMMV",
		[35]="          V:H:I:MA:W'I :AXXXIXII:IANGERSSSSXXA.I.VMMMHMHMMMMMM",
		[36]="            'I::IVA ASSSSANGERANGERANGERANGERMMBS.VVMMHIMM'\"'",
		[37]="             I:: VPAIANGERANGERANGERANGERANGERMXXI:MMHIMMI",
		[38]="            .I::. \"H:XIIANGERANGERANGERANGERBXIXXMMPHIIMM'",
		[39]="            :::I.  ':XSSXXIIIIFEATURESXXXIIIXXSMMAMI:.IMM",
		[40]="            :::I:.  .VSSSANGERANGERANGERANGERMMB:MI:..:MM",
		[41]="            ::.I:.  ':\"SSSANGERANGERANGERSSBMMB:AHI:..MMM.",
		[42]="            ::.I:. . ..:\"BBSANGERANGERANGERMMB:AHHI::.HMMI",
		[43]="            :..::.  . ..::\":BBANGERANGERMB:MMANGERI::IHHMI",
		[44]="            ':.I:... ....:IHHHANGERANGERANGERANGERIIIHMMV\"",
		[45]="              \"V:. ..:...:.IHHHANGERANGERANGERANGERHHMHP'",
		[46]="               ':. .:::.:.::III::IHHHHMMMANGERMMHHHHMMH\"",
		[47]="                 \"::....::.:::..:..::IIIIIHHHHMMMHHMVH\"",
		[48]="                   \"::.::.. .. .  ...:::IIHHMMMMHMMV\"",
		[49]="Anger Loaded        \"V::... . .I::IHHMMVMMMHHMHM\"\"'",
		[50]="Have Fun! Good Luck.   '\\\"VHVHHHAHHHHMMHMV:\\\"'",
		[51]=" "
	},
	
	["ASCII_small_skull"] = {   --4
		[0]=" ",
		[1]="                     ______",
		[2]="                  .-^      ^-.",
		[3]="                 /   Anger    \\ ",
		[4]="                |   Features   |",
		[5]="                |,  .-.  .-.  ,|",
		[6]="                | )(__/  \\__)( |",
		[7]="                |/     /\\     \\|",
		[8]="      (@_       (_     ^^     _)",
		[9]=" _     ) \\_______\\__|IIIIII|__/__________________________",
		[10]="(_)@8@8{}<________|-\\IIIIII/-|___________________________>",
		[11]="       )_/        \\          /",
		[12]="      (@           `--------` ",
		[13]=" "
	},
	
	["ASCII_Anger"] = {  --1
		[0]=" ",
		[1]="        ##              ##### #     ##          # ###            ##### ##           ##### /##  ",
		[2]="      /####           ###### //#    #### /     //  /###  /     ######  /### /     ###### // ##  ",
		[3]="     /  ###          /#   / // ##    ###/     //  /  ###/     /#   /  / ###/     /#   / //  ##  ",
		[4]="       //##         /    / //  ##    # #     //  ##   ##     /    /  /   ##     /    / //   ##  ",
		[5]="      //  ##            / //    ##   #      //  ###              /  /               / //    //   ",
		[6]="      //  ##           ## ##    ##   #     ##   ##              ## ##              ## ##   //    ",
		[7]="     //    ##          ## ##     ##  #     ##   ##   ###        ## ##              ## ##  //     ",
		[8]="     //    ##          ## ##     ##  #     ##   ##  /###  /     ## ######          ## ###//      ",
		[9]="    //      ##         ## ##      ## #     ##   ## /  ###/      ## #####           ## ##  ###   ",
		[10]="   ///########         ## ##      ## #     ##   ##/    ##      ## ##              ## ##    ##  ",
		[11]="   //        ##        #  ##       ###      ##  ##     #       #  ##              #  ##    ##  ",
		[12]="   #        ##        //  /        ###       ## #      /       //                /         ##  ",
		[13]="  //####      ##     //##/          ##        ###     /       //##/         /   /##/      ### ",
		[14]=" //   ####    ## /  //  #####                  ######/       //  ##########/   / ####    ##  ",
		[15]="//     ##      #/  //     ##                     ###        //     ######     /   ##     #   ",
		[16]="#                 #                                        #                 #               ",
		[17]=" ##                ##                                       ##                ##             ",
		[18]=" "
	}
}


function ascii_art.get_ASCII_art(string_name, index)
	if All_ASCII_art then
		if All_ASCII_art[string_name] then
			if All_ASCII_art[string_name][index] then
				return tostring(All_ASCII_art[string_name][index])
			else
				return nil
			end
		end
	end
end

function ascii_art.get_max_length(string_name)
	if All_ASCII_art then
		if All_ASCII_art[string_name] then
			local i = 0
			
			for key, value in pairs(All_ASCII_art[string_name]) do
				i = i + 1
			end
			
			return i
		end
		
		return -1
	end
	
	return -1
end

return ascii_art