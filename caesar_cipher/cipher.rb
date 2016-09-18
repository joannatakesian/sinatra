require 'sinatra'

def encrypt(string, shift)
    encrypted = []
    alphabet = ('a'..'z').to_a.join
    shifted = alphabet.chars.rotate(shift.to_i).join
    
    string.downcase.split('').each do |letter|
        alphabet.split('').each_with_index do |char, index|
            if char == letter
                encrypted << shifted[index]
            end
        end
    end
    
    return encrypted.join
end

get '/' do
    erb :index
end

post '/' do
    @encrypted = encrypt(params['string'], params['shift'])
    erb :index
end