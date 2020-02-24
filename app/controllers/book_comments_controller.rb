class BookCommentsController < ApplicationController

	def create
	    @book = Book.find(params[:book_id])
	    @book_comment = current_user.book_comments.new(book_comment_params)
	    @book_comment.book_id = @book.id
	    #comment = Book.new(book_comment_params)
	    #comment.user_id = current_user.id  ※上記２行はこの記述でもOK
    if @book_comment.save
    redirect_to book_path(@book)
    else
    	@user = current_user
    	render 'books/show'
	end
end

	# def destroy
	# 	@comment = BookComment.find_by(id: params[:id],book_id: params[:book_id])
	# 	@comment.destroy
	# 	@book = @comment.book
	# 	redirect_to book_path(@book), notice: "successfully delete book!"
	# end
	# resourcesバージョン


	def destroy
		@comment = BookComment.find(params[:book_id])
		@book = @comment.book
		if @comment.user != current_user
			redirect_to book_path(@book)
		end
	  	@comment.destroy
	  	redirect_to book_path(@book), notice: "successfully delete book!"
		end
	# resourceバージョン

private

	def book_comment_params
	    params.require(:book_comment).permit(:comment)
	end
end