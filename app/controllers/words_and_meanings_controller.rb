class WordsAndMeaningsController < ApplicationController
  
  def index
    @words = Word.all.order("words.word ASC")
  end

  def show
    @word = Word.find(params[:id])
    @meanings = Meaning.where("word_id=?",params[:id])
  end

  def new
    # @word = Word.new
    @meaning = Meaning.new
  end

  def edit
    @word = Word.find(params[:id])
  end

  def delete
    @word = Word.find(params[:id])
  end

  def create
    @word = Word.new(word_params)
    @meaning = Meaning.new(meaning_params)
    
    if @word.save 
      @meaning.word_id = @word.id
      if @meaning.save
        flash[:notice] = "Word has been saved succesfully"
        redirect_to(:action =>'show', :id => @word.id)
      end
    else
      render('new')
    end
  end

  def destroy
    word = Word.find(params[:id]).destroy
    flash[:notice] = "Word '#{word.word}' has been destroyed succesfully"
    redirect_to(:action => 'index')
  end

  private 
    def word_params
      params.require(:word).permit(:word, :synonym, :antonym)
    end

  private
    def meaning_params
      params.require(:word).permit(:figurative, :meaning, :example, :form)
    end
end
