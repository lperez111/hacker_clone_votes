get '/' do
  if session[:user_id]
    @user = User.find(session[:user_id])
  end
  @all_posts = Post.all
  @all_posts.sort! { |a,b| b.postvotes.size <=> a.postvotes.size }
  erb :index
end

get "/login" do
  erb :login
end

post "/signup" do
  @user = User.create(username: params[:username], password: params[:password])
  session[:user_id] = @user.id
  redirect("/")
end

post "/login" do
  @user = User.authenticate(params[:username], params[:password])
  session[:user_id] = @user.id
  redirect("/")
end

get "/logout" do
  session.clear
  redirect("/")
end

get "/createpost" do
  erb :createpost
end
post "/createpost" do
  @post = Post.create(params[:newpost])
  @user = User.find(session[:user_id])
  @user.posts << @post
  redirect("/")
end

get "/comments/:post_id" do
  if session[:user_id]
    @user = User.find(session[:user_id])
  end
  @all_comments = Comment.all
  @all_comments.sort! { |a,b| b.commentvotes.size <=> a.commentvotes.size }
  @post = Post.find(params[:post_id])
  @comments = @post.comments
  erb :comments
end

post "/addcomment/:post_id" do
  @comment = Comment.create(content: params[:content])
  @user = User.find(session[:user_id])
  @post = Post.find(params[:post_id])
  @post.comments << @comment
  @user.comments << @comment
  redirect("/comments/#{@post.id}")
end

post "/createvote" do
  @postvote = Postvote.create
  @user = User.find(session[:user_id])
  @post = Post.find(params[:post_id])
  @user.postvotes << @postvote
  @post.postvotes << @postvote
  return @post.postvotes.size.to_s
end

post "/createcvote" do
  @commentvote = Commentvote.create
  @user = User.find(session[:user_id])
  @comment = Comment.find(params[:comment_id])
  @user.commentvotes << @commentvote
  @comment.commentvotes << @commentvote
  return @comment.commentvotes.size.to_s
end




