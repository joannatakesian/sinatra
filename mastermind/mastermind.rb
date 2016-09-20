require 'sinatra'
require 'sinatra/reloader'

enable :sessions

helpers do
    def new_game
        session[:code] = []
        session[:guesses] = 0
        session[:gameover] = false
        session[:guesses] = []
        
        4.times do
            session[:code] << rand(1..4)
        end
    end
end

get '/' do
    erb :index
end

post '/' do
    redirect to('/new')
end

get '/new' do
    new_game
    redirect to('/game')
end

get '/game' do
    guesses = session[:guesses]
    erb :game, :locals => { :guesses => guesses }
end

post '/game' do
    guess = params['guess']
    session[:guesses] << guess
    redirect to('/game')
end

=begin
class Game
    
    def initialize(turns)
        @turns = turns
        @code = []
        @guess = []
        @feedback = []
    end
    
    def generate()
        4.times do
            @code.push(rand(1..4))
        end
    end
    
    def game_loop()
        @turns.times do
            puts "Enter your guess (no spaces):"
            @this_guess = gets.chomp.split('').map {|x| @guess.push(x)}
            puts "Ok, let's see..."
            feedback
            break if @guess.join == @code.join
            @guess.clear
        end
        
        if @code.join == @guess.join
            puts "Congrats! You guessed the code!"
        else
            puts "Sorry, the code was #{@code.join}."
        end
        
    end
    
    def feedback()
        
        if @code.join != @guess.join
            
            checker = []
            checker.clear
            checker.push(*@code)
            counter = 0
            
            @guess.each do |x|
                if checker.include?(x.to_i)
                    counter += 1
                    checker.delete_at(checker.find_index(x.to_i))
                end
            end
            
            right_space = 0
            
            i = 0
            right_space = 0
            @guess.each do |y|
                if @guess[i].to_i == @code[i].to_i
                    @feedback.push("X")
                    right_space += 1
                end
                i += 1
            end
            
            wrong_space = (counter - right_space)
            
            wrong_space.times do
                @feedback.push("O")
            end
            
            puts "Here are your hints:"
            puts "#{@guess.join} - #{@feedback.join}"
            
        end
        
        @feedback.clear
    
    end
    
end

def welcome
    puts "Welcome to Mastermind!"
    puts "=========="
    puts "Would you like to play easy, medium, or hard?"
end

welcome

difficulty = gets.chomp.downcase
turns = 0

while turns == 0
    case difficulty
    when "easy"
        turns = 14
    when "medium"
        turns = 12
    when "hard"
        turns = 10
    else
        puts "That's not an option."
        puts "Enter easy, medium, or hard:"
        difficulty = gets.chomp.downcase
    end
end

game = Game.new(turns)
game.play()

=end