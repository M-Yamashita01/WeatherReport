class ArticlesController < ApplicationController
  def index
    #creator = URLCreator.new
    #reader = DataReader.new
    #weather_collection = WeatherCollection.new(creator, reader)
    #location_weather_list = weather_collection.get_main_location_weather

    #@locations = Location.all
    #@location_weather_arr = location_weather_list.get_list
    #@location_weather_arr.reverse!  
  end

  def create
    # nothing
  end

  def update
    # nothing
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  def redirect_to_root
    redirect_to :root
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end
end
