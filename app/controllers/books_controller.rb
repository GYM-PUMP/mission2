class BooksController < ApplicationController

  def show
  	@book = Book.find(params[:id])
    @user = current_user
    @book_comment = BookComment.new
  end

  def index
  	@books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
    @book = Book.new
    @user = current_user
  end

  def create
    	@book = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
      @book.user_id = current_user.id# bookモデルはtitleやbodyのカラムを持っているが1対Nの関係でuser_idも持っている。しかしcreateの時に記入するのはtitleとbodyのみ。なのでここで
    # ブックモデルのuser_idはカレントuser_idと同じと引き渡している。
  	if @book.save #入力されたデータをdbに保存する。
  		redirect_to @book, notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
  		@books = Book.all
      @user = current_user
  		render 'index'
  	end
  end


  def edit
  	  @book = Book.find(params[:id])
    if current_user.id != @book.user.id
      redirect_to books_path
    end
  end



  def update
  	   @book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render "edit"
  	end
  end

  def destroy
    	@book = Book.find(params[:id])
    	@book.destroy
    	redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
    	params.require(:book).permit(:title,:body)
  end

end
