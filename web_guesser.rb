require 'sinatra' 
require 'sinatra/reloader'

$secret_number = rand(100)
turn = 0
$color = "white"
first_run = true

def check_guess(guess)
	case guess - $secret_number 
	when -Float::INFINITY..-5 then $sentence = "Way too low!"; $color = "Tomato"
	when -5..-1 then $sentence = "Too low!"; $color = "LightPink"
	when 0 then $sentence = "Correct!"; $color = "Green"; turn = -1, $secret_number = rand(100)
	when 0..5 then $sentence = "Too high!"; $color = "LightPink"
	when 5..Float::INFINITY then $sentence = "Way too high!"; $color = "Tomato" end 
end

get '/' do
	guess = params["guess"].to_i
	$color = "White"
		if first_run then $sentence = "" 
		elsif turn == 5 then
		$sentence = "Too many tries! You lost! Play with a new secret number"
		turn = -1
		$secret_number = rand(100)
	else
		 check_guess(guess) 
	end
	if params['cheat'] == "true" then $secret = "The secret number is #{$secret_number}!" end
	turn += 1
	first_run = false
	erb :index, :locals => {:secret_number => $secret_number, :sentence => $sentence, :color => $color, :cheat => $cheat, :secret => $secret}
	$secret = ""
end