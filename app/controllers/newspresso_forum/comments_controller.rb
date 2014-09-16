module NewspressoForum
  class CommentsController < ::ApplicationController
    authorize_resource only: [:new, :edit, :update, :create]
    before_action :set_topic
    before_action :set_comment, only: [:show, :edit, :update, :destroy]

    # GET /comments
    def index
      @comments = @topic.comments.all
    end

    # GET /comments/1
    def show
    end

    # GET /comments/new
    def new
      @comment = @topic.comments.build
    end

    # GET /comments/1/edit
    def edit
    end

    # POST /comments
    def create
      @comment = Comment.new(comment_params)
      @comment.user = current_user

      if @comment.save
        redirect_to @topic
      else
        render :new
      end
    end

    # PATCH/PUT /comments/1
    def update
      if @comment.update(comment_params)
        redirect_to @comment, notice: 'Comment was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /comments/1
    def destroy
      @comment.destroy
      redirect_to comments_url, notice: 'Comment was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_comment
        @comment = Comment.find(params[:id])
      end

      def set_topic
        @topic = Topic.find(params[:topic_id])
      end

      # Only allow a trusted parameter "white list" through.
      def comment_params
        params.require(:comment).permit(:user_id, :body, :topic_id)
      end
  end
end