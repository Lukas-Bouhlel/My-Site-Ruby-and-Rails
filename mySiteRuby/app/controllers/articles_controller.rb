class ArticlesController < ApplicationController

  def index

  end

  def new
    @articles = Article.new
  end

  def create
    article_params = params.require(:article).permit(:name, :bio, :image, :user_id)
    @article = Article.new(article_params)

    @article.users_id = current_user.id
    if @article.valid?
      @article.save
      redirect_to index_articles_path, success: 'Votre article à bien été créer'
    else
      render 'new'
    end   
  end

  def edit 
    @article = current_user
  end

  def update 
    article_params = params.require(:article).permit(:name, :bio, :image)
    if @article.update(article_params)
      redirect_to edit_articles_path, success: 'Votre article à bien été mis à jour !'
    else
      render :edit
    end
  end

end
