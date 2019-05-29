require "DSL"
DslRobot do 
	gdy :czujnikLewy => 1  do  
		jedz_wstecz 5.cm 
		skrec_prawo 90.stopni 
	end 
	gdy :czujnikPrawy => 1  do  
		jedz_wstecz 5.cm 
		skrec_lewo 90.stopni 
	end 
	jedz_prosto 1.m 
end