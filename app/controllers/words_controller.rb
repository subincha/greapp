class WordsController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def edit
    @word = Word.find(params[:id])
  end

  def delete
  end

  def update
    @word = Word.find(params[:id])
    if @word.update_attributes(word_params) 
      flash[:notice] = "Word has been updated succesfully"
      redirect_to(:controller => 'words_and_meanings', :action =>'show', :id => @word.id)
    else
      render('new')
    end
  end

  private 
    def word_params
      params.require(:word).permit(:word, :synonym, :antonym)
    end
end
