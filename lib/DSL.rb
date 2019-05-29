require "robot/robotDsl"

def DslRobot(&block)
	Docile.dsl_eval(RobotDsl.new, &block)
end
