class GameSeriesController < ApplicationController
  before_filter :load_game_series, :only => [:update, :destroy]
  before_filter :require_admin
  
  
  def create
    @game_series = GameSeries.new game_series_params
    if @game_series.save
      render :json => @game_series
      return
    end
    render :text => "Failed to create game_series: #{@game_series.errors.full_messages.join(", ")}",
      :status => 400
  end
  
  def update
    @game_series.attributes = game_series_params
    if @game_series.save
      render :json => @game_series
      return
    end
    render :text => "Failed to save: #{@game_series.errors.full_messages.join(", ")}",
      :status => 400
  end
  
  def destroy
    @game_series.destroy
    render :text => '"Deleted"'
  end
  
  private
  
  def game_series_params
    params.require(:game_series).permit(:game_id, :series_name)
  end
end
