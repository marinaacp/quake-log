module Api
  class PlayersController < ApplicationController

    def index
      players = Player.all

      render json: players.as_json(methods: [:kills_data])
    rescue Exception => e
      Rails.logger.error(YAML::dump(e))
      render json: e.message, status: :unprocessable_content and return
    end

    def show
      player = Player.find(params[:id])

      render json: player.as_json(methods: [:kills_data])
    rescue Exception => e
      Rails.logger.error(YAML::dump(e))
      render json: e.message, status: :unprocessable_content and return
    end

  end
end
