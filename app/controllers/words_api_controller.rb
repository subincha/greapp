class WordsApiController < ApplicationController
	def show_by_id
		@word = Word.find_by_id(params[:id])
 		if !@word.nil?
	  		if stale?(last_modified: @word.updated_at)
	    		render json: @word
	  		end
	  	else
	  		render json: {}
	  	end
	end

	def show
		@words = Word.all
 		render json: @words
	end
end
