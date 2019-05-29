require 'docile'
require 'robot'
require 'pid_controller'

class Numeric

	def cm
		self
	end

	def m
		self*100
	end
	
	def km
		self*1000
	end
	
	def rad
		self * 57.3
	end
	
	def stopnie
		self
	end
	
	def stopni
		self
	end
	
end


class RobotDsl

	def initialize(robot=nil)
	
		@mutex = Mutex.new
		@cond = ConditionVariable.new
		
		@robot  = robot
		@robot ||= Robot.new
		@wait = 0
	end
	
	def jedz_prosto(distance)

		trackLeft = distance*2 + @robot.leftEncoder
		trackRight = distance*2 + @robot.rightEncoder
		controller = PidController.new(setpoint: 0.0,kp: 8, ki: 3, kd: 1)
		
		while trackLeft>=@robot.leftEncoder&&trackRight>=@robot.rightEncoder

			@mutex.synchronize do
				if @wait == 1
					@cond.wait(@mutex)
				end
			end	
	
			regulacja=controller<<(@robot.leftEncoder - @robot.rightEncoder)		
			@robot.pwm (100 + regulacja),(100 - regulacja)		
			@robot.prosto 
		end
		@robot.stop
				
	end


	def jedz_wstecz(distance)

		trackLeft = distance*2 + @robot.leftEncoder
		trackRight= distance*2 + @robot.rightEncoder
		controller = PidController.new(setpoint: 0.0,kp: 8, ki: 3,kd: 1)
	
		while trackLeft>=@robot.leftEncoder&&trackRight>=@robot.rightEncoder
			@mutex.synchronize do
				if @wait == 1
					@cond.wait(@mutex)
				end
			end			
			regulacja =controller << (@robot.leftEncoder - @robot.rightEncoder)
			@robot.pwm (100 + regulacja),(100 - regulacja)	
			@robot.tyl										
		end
		@robot.stop			
	end	



	def skrec_lewo(angle)

		trackLeft = angle/7.5 + @robot.leftEncoder;
		trackRight = angle/7.5 + @robot.rightEncoder;
	
		while trackLeft>=@robot.leftEncoder&&trackRight>=@robot.rightEncoder
			@mutex.synchronize do
				if @wait == 1
					@cond.wait(@mutex)
				end
			end		
			@robot.lewo
			@robot.pwm 70,70			
		end			
		@robot.stop		
	end		


	def skrec_prawo(angle)
		trackLeft = angle/7.5 + @robot.leftEncoder;
		trackRight = angle/7.5 + @robot.rightEncoder;
	
		while trackLeft>=@robot.leftEncoder&&trackRight>=@robot.rightEncoder
			@mutex.synchronize do
				if @wait == 1
					@cond.wait(@mutex)
				end
			end
			@robot.prawo
			@robot.pwm 70,70			
		end
		@robot.stop	
	end

	def gdy(options,&block)
		@stop = 0 #pole flagi do zatrzymywania pozostałych metod gdy
		options = {:czujnikLewy => 0, :czujnikPrawy => 0,}.merge(options)
		new_thread = Thread.new do	
			loop do		
				if options[:czujnikLewy]==1 && options[:czujnikPrawy]==1
					if @robot.leftSensor==0&&@robot.rightSensor==0
						@wait = 1							
					end 			
				elsif options[:czujnikLewy]==1 && options[:czujnikPrawy]==0 
					if @robot.leftSensor==0&&@robot.rightSensor==1
						@wait = 1
					end 
				elsif options[:czujnikLewy]==0 && options[:czujnikPrawy]==1
					if @robot.leftSensor==1&&@robot.rightSensor==0
						@wait = 1
					end 
				elsif options[:czujnikLewy]==0 && options[:czujnikPrawy]==0 
					if @robot.leftSensor==1&&@robot.rightSensor==1
						@wait = 1				
					end 				
				end	
					
				if @wait == 1 && @stop == 0
					@stop = 1						
					@robot.stop							
					memoryleft = @robot.leftEncoder
					memoryright = @robot.rightEncoder				
					Docile.dsl_eval(RobotDsl.new(@robot), &block)	
					@robot.leftEncoderSet memoryleft 
					@robot.rightEncoderSet memoryright
					@wait = 0
					@stop = 0
					@mutex.synchronize { @cond.broadcast }		
				end					
			end				
			new_thread	
		end	
	end

end
