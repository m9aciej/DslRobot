require 'pi_piper'
require 'rpi_gpio'

# ustawianie pinów biblioteki rpi_gpio dla pwm-a
RPi::GPIO.set_warnings(false)
RPi::GPIO.set_numbering :bcm
RPi::GPIO.setup 17, :as => :output
RPi::GPIO.setup 22, :as => :output

class Robot
				
	def initialize()	
		

		#pola przechowujące impulsy z enkoderów
		@leftEncoder = 0
		@rightEncoder = 0
													
		#pola do sterownika silników
		@out1 = PiPiper::Pin.new(:pin => 26, :direction => :out)
		@out2 = PiPiper::Pin.new(:pin => 19, :direction => :out)
		@out3 = PiPiper::Pin.new(:pin => 13, :direction => :out)
		@out4 = PiPiper::Pin.new(:pin => 6, :direction => :out)	

		#pola do obslugi PWM-a
		@rightPwm = RPi::GPIO::PWM.new(17, 50) #nylo 50
		@leftPwm = RPi::GPIO::PWM.new(22,50)
		@rightPwm.start 100
		@leftPwm.start 100
	
		#pola do obsługi czujników odległości
		@rightSensor = PiPiper::Pin.new(:pin => 2, :direction => :in) #trigger: :falling
		@leftSensor = PiPiper::Pin.new(:pin => 3,  :direction => :in)

		#zdarzenie zliczające impulsy z lewego enkodera
		PiPiper.watch :pin => 20  , :invert => true do |pin|
			
			@leftEncoder=@leftEncoder+1
			
		end
		
		#zdarzenie zliczające impulsy z prawego enkodera
		PiPiper.watch :pin => 21  , :invert => true do |pin|
			
			@rightEncoder=@rightEncoder+1
			
		end
							
	end


	def rightSensor
		@rightSensor.read
	end
	
	def leftSensor
		@leftSensor.read
	end


	#metody zwracajace wartosc impulsów z enkoderów
	def leftEncoder
		@leftEncoder
	end
	
	def rightEncoder
		@rightEncoder
	end	
	
	def leftEncoderSet(leftEncoder)
		@leftEncoder = leftEncoder
	end
	
	def rightEncoderSet(rightEncoder)
		@rightEncoder = rightEncoder
	end	
	
	# metoda do obsługi pwm-a
	def pwm(leftEngine,rightEngine)

	
		if leftEngine>100.0 
			leftEngine=100.0
		elsif leftEngine<0.0 
			leftEngine=0.0
		end

		if rightEngine>100.0
			rightEngine=100.0
		elsif rightEngine<0.0
			rightEngine=0.0
								
		end

		@rightPwm.duty_cycle = rightEngine
		@leftPwm.duty_cycle = leftEngine

	end
	
	#metoda do jazdy prosto
	def prosto()	
			
		@out1.on
		@out2.off
		@out3.on
		@out4.off
		
	end
	
	#metoda do jezdy w tyl
	def tyl()
			
		@out1.off
		@out2.on
		@out3.off
		@out4.on
		
	end

	
	def lewo()

		@out1.on
		@out2.off
		@out3.off
		@out4.on
						
	end
			

	def prawo()
	
		@out1.off
		@out2.on
		@out3.on
		@out4.off		
				
	end

	def stop()
			
		@out1.off
		@out2.off
		@out3.off
		@out4.off
		sleep 0.5 #oczekiwanie na zatrzymanie		
				
	end
	
	
	
end
