class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def create
    content = linkify_mentions_hashtags_bangbangs(post_params[:content])
    @post = Post.new(content: content)
    
    unless post_params[:tag_ids].nil?
      post_params[:tag_ids].each do |tid|
        @post.tags << Tag.find(tid)
      end
    end

    unless post_params[:new_tag_titles].nil?
      post_params[:new_tag_titles].each do |tt|
        tag = Tag.create!(title: tt)
        @post.tags << tag
      end
    end

    # create new tags for "post[new_goal_titles][]"
    # create taggings for "post[new_goal_titles][]"

    
    respond_to do |format|
      if @post.save
        format.js
      end
    end
  end

  def autocomplete_tags
    @tags = Tag.order(:title).where("title LIKE ?", "%#{params[:term]}%")
    respond_to do |format|
      format.html
      format.json { 
        render json: @tags.map{|tag| {id: tag.id, title: tag.title}}
        # render json: @goals.map(&:title)
      }
    end
  end

  def autocomplete_bangbangs
    @bangbangs = Bangbang.order(:title).where("title LIKE ?", "%#{params[:term]}%")
    respond_to do |format|
      format.html
      format.json { 
        render json: @bangbangs.map{|bangbang| {id: bangbang.id, title: bangbang.title}}
        # render json: @goals.map(&:title)
      }
    end
  end

  def mention_autocomplete
    @users = User.order(:username).where("username LIKE ?", "%#{params[:term]}%")
    respond_to do |format|
      format.html
      format.json { 
        render json: @users.map{|user| {id: user.id, title: user.username}}
        # render json: @goals.map(&:title)
      }
    end
  end

  private

  def linkify_mentions_hashtags_bangbangs(text)    
    text.gsub!(/@([\w]+)(\W)?/, '<a href="/\1" class="pretty-link mention-pretty-link">@\1</a>\2')
    text.gsub!(/#([\w]+)(\W)?/, '<a href="/search?q=%23\1" class="pretty-link tag-pretty-link">#\1</a>\2')
    text.gsub!(/!!([\w]+)(\W)?/, '<a href="/search?q=%21%21\1" class="pretty-link bangbang-pretty-link">!!\1</a>\2')
    text
  end  

  def post_params
    params.require(:post).permit(:content,tag_ids: [], new_tag_titles: [])
  end
end