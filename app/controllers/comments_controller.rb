class CommentsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @comments = Comment.order("#{sort_column} #{sort_direction}")
  end

  def new
    @comment = Comment.new
  end

  def create
    @comments = Comment.order("#{sort_column} #{sort_direction}")
    @comment = Comment.create(comment_params)
  end

  private
    def comment_params
      params.require(:comment).permit(:comment)
    end

    def sortable_columns
      ["comment", "created_at"]
    end

    def sort_column
      sortable_columns.include?(params[:column]) ? params[:column] : "comment"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
