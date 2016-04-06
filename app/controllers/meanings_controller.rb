class MeaningsController < ApplicationController
  before_action :confirm_logged_in
  def index
  end

  def show
  end

  def new
    @meaning = Meaning.new
    @word = Word.find(params[:id])
  end

  def edit
    @meaning = Meaning.find(params[:id])
    @word = Word.find(params[:word_id])
  end

  def delete
    meaning = Meaning.find(params[:id])
  end

  def create
    @meaning = Meaning.new(meaning_params)
    @meaning.word_id = params[:id]
    if @meaning.save
      flash[:notice] = "Meaning has been saved succesfully"
      redirect_to(:controller => 'words_and_meanings', :action =>'show', :id => params[:id])
    else
      render('new')
    end
  end

  def update
    @meaning = Meaning.find(params[:id])
    if @meaning.update_attributes(meaning_params)
      flash[:notice] = "Meaning has been updated succesfully"
        redirect_to(:controller => 'words_and_meanings', :action =>'show', :id => @meaning.word_id)
    else
      render('new')
    end
  end

  def destroy
    meaning = Meaning.find(params[:id]).destroy
    flash[:notice] = "Meaning has been destroyed succesfully"
    redirect_to(:controller => 'words_and_meanings', :action => 'show', :id => params[:word_id])
  end

  private
    def meaning_params
      params.require(:meaning).permit(:figurative, :meaning, :example, :form)
    end
end
