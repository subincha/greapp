class MobileLoginController < ApplicationController
	skip_before_action :verify_authenticity_token
	def mobile_login
		#@user = User.new(user_params)
		found_user = User.where(:username => params[:username]).first
		if found_user
			authorized_user = found_user.authenticate(params[:password])
			if authorized_user
				if found_user.logged_in
					render json: {:error => 'user already logged in other device'}
				else
					found_user.logged_in = true
					found_user.save
					if params[:load] == "true"
						@words = Word.all
						@meanings = Meaning.all
						render json: {:words => @words, :meanings => @meanings} 
					else
						render json: {:sucess => "sucessfully logged in"}
					end	
				end
			else 
				render json: {:error => 'unautherized error'}
			end
		else 
			render json: {:error => "invalid username"}
		end
	end

	def mobile_getall

	end

	def mobile_logout
		#user = User.new(user_params)
		found_user = User.where(:username => params[:username]).first
		if found_user
			found_user.logged_in = false
			found_user.save
			render json: {:success => "sucessfully logged out"}
		end

	end

	def mobile_update
		last_word = Word.last
		last_meaning = Meaning.last
		updated_words = Word.where("updated_at > created_at")
		updated_meanings = Meaning.where("updated_at > created_at")
		deleted_words = Word.ids
		deleted_meanings = Meaning.ids
		if last_word != nil && last_meaning != nil
			if last_word.id > params[:word_id].to_i || last_meaning.id > params[:meaning_id].to_i
				words = Word.where("id > ?", params[:word_id].to_i)
				meanings = Meaning.where("id > ?", params[:meaning_id].to_i)
				
				render json: {:words => words, :meanings => meanings, :updated_words => updated_words, :updated_meanings => updated_meanings, :deleted_words => deleted_words, :deleted_meanings => deleted_meanings}
			else
				render json: {:words => [], :meanings => [], :updated_words => updated_words, :updated_meanings => updated_meanings, :deleted_words => deleted_words, :deleted_meanings => deleted_meanings}
			end
		else
			render json: {:error => 'no words found'}
		end
	end

	private
	def user_params
		params.require(:user).permit(:username, :password)
	end

	#def word_params
	#	params.permit(:word_id, :meaning_id)
	#end

end
