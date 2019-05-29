# Project Title

DSL Robot
Język dziedzinowy sterujący robotem mobilnym za pomocą prostych komend
A domain-specific language meant to control the mobile robot with simple commands

## Getting Started

...

## Examples
Kwadrat:
https://www.youtube.com/watch?v=hV12FV0L48M

DslRobot do 
&nbsp;&nbsp;&nbsp;jedz_prosto 50.cm 
&nbsp;&nbsp;&nbsp;skrec_lewo 90 
&nbsp;&nbsp;&nbsp;jedz_prosto 50.cm 
&nbsp;&nbsp;&nbsp;skrec_lewo 90 
&nbsp;&nbsp;&nbsp;jedz_prosto 50.cm 
&nbsp;&nbsp;&nbsp;skrec_lewo 90 
&nbsp;&nbsp;&nbsp;jedz_prosto 50.cm 
&nbsp;&nbsp;&nbsp;skrec_lewo 90 
end 

Omijanie przeszkód:
https://www.youtube.com/watch?v=SjdD8yX0Ud0

DslRobot do 
&nbsp;&nbsp;&nbsp;gdy :czujnikLewy => 1  do  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;jedz_wstecz 5.cm 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;skrec_prawo 90.stopni 
&nbsp;&nbsp;&nbsp;end 
gdy :czujnikPrawy => 1  do  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;jedz_wstecz 5.cm 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;skrec_lewo 90.stopni 
end 
&nbsp;&nbsp;&nbsp;jedz_prosto 1.m 
end



## Authors

m9aciej

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

