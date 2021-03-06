class EncryptController < ApplicationController

	def calculate
	end

	def do_calculate
	@data = encrypt_message(params["key"], params["message"])
	respond_to do |format|
		format.js if request.xhr?
		format.html {render or message_path}
	end
	end

	def encrypt_message(key, content)
		key = key.to_i
		content = content.gsub(" ","")
		num = key - 1
		length = content.length - 1
		return "Encryption cannot be done. Please select key less than content length." if num >= length or key <= 1 
		hash = {}	          
		(0..num).each{|n| hash["array#{n}"] = ""}      
		(0..length).step(num).each_with_index do |pos, index|
			(0..num-1).each {|down| hash["array#{down}"] += content[down + pos] unless (down + pos) > length } if index.even?
			(1..num).to_a.reverse.each_with_index {|up,ind| hash["array#{up}"] += content[pos + ind] unless ind + pos > length} unless index.even?              
		end
		new_content = ""
		(0..num).each{|n| new_content += hash["array#{n}"] } 
		new_content	    
	end
end
