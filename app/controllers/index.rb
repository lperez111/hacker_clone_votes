get '/' do
  if session[:user_id]
    @user = User.find(session[:user_id])
  end
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
