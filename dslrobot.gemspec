

Gem::Specification.new do |s|
  s.name        = 'DSL'
  s.version     = '1.0.0'
  s.licenses    = ['MIT']
  s.summary     = "Robot!"
  s.description = "Język dziedzinowy do sterowanie robotem mobilnym!"
  s.authors     = ["Maciej Szczurek"]
  s.email       = 'm9aciej@gmail.com'
  s.files       = ["lib/DSL.rb", "lib/robot/robot.rb", "lib/robot/robotDsl.rb"]
  s.homepage    = ''
  s.metadata    = { "source_code_uri" => "" }
  s.add_dependency 'pi_piper'
  s.add_dependency 'rpi_gpio'
  s.add_dependency 'pid_controller'
  s.add_dependency 'docile'
end
