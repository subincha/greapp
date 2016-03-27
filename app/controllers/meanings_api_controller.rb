class MeaningsApiController < ApplicationController
	def show_by_id
		@meaning = Meaning.find_by_word_id(params[:id])
 		if !@meaning.nil?
	  		if stale?(last_modified: @meaning.updated_at)
	    		render json: @meaning
	  		end
	  	else
	  		render json: {}
	  	end
	end

	def show
		@meanings = Meaning.all
 		render json: @meanings
	end
end
