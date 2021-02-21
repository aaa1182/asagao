class ArticlesController < ApplicationController
  # 記事一覧
  def index
    @articles = Article.visible.order(released_at: :desc)
    @articles = @article.open_to_the_public unless current_member
    @articles = @articles.page(params[:page]).per(5)
  end

  # 記事詳細
  def show
    articles = Article.visible
    articles = articles.open_to_the_publec unless current_member
    @article = articles.find(params[:id])
  end
end
