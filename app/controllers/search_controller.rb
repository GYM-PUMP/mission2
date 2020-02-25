class SearchController < ApplicationController

  def search
    @model = params["search"]["model"]
    @search_word = params["search"]["search_word"]
    @method = params["search"]["method"]
    @records = search_for(@model, @search_word, @method)
  end

  private
  def search_for(model, search_word, method)
    if model == 'user'
      if method == 'perfect'
        @users = User.where(name: search_word)
      elsif method == 'forward'
        @users = User.where('name LIKE ?', search_word + '%')
      elsif method == 'backward'
        @users = User.where('name LIKE ?', '%' + search_word)
      else
        @users = User.where('name LIKE ?', '%' + search_word + '%')
      end
    elsif model == 'book'
      if method == 'perfect'
        @books = Book.where(title: search_word)
      elsif method == 'forward'
        @books = Book.where('title LIKE ?', search_word + '%')
      elsif method == 'backward'
        @books = Book.where('title LIKE ?', '%' + search_word)
      else
        @books = Book.where('title LIKE ?', '%' + search_word + '%')
      end
    end
  end
end
