require 'sinatra' 
require 'sinatra/reloader'

SECRET_NUMBER = rand(100)
turn = 0

def check_guess(guess)
	case guess - SECRET_NUMBER 
	when -Float::INFINITY..-5 then $sentence = "Way too low!"
	when -5..-1 then $sentence = "Too low!"
	when 0 then $sentence = "Correct!"
	when 0..5 then $sentence = "Too high!"
	when 5..Float::INFINITY then $sentence = "Way too high!" end 
end

get '/' do
	guess = params["guess"].to_i
	if turn == 0 then $sentence = "" else check_guess(guess) end
	turn += 1
	erb :index, :locals => {:secret_number => SECRET_NUMBER, :sentence => $sentence}
end