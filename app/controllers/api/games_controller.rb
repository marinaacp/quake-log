module Api
  class GamesController < ApplicationController
    # Disable CSRF protection for stateless API requests
    protect_from_forgery with: :null_session, only: [:create]

    def create
      file = params[:file]

      if file && valid_file?(file)
        # Save the uploaded file to a temporary location
        file_path = Rails.root.join('tmp', file.original_filename)
        File.open(file_path, 'wb') do |f|
          f.write(file.read)
        end

        # Call a job for processing the file
        ParseLogFileJob.perform_later(file_path.to_s)

        render json: { message: 'File uploaded successfully. Processing in background.' }, status: :ok
      else
        render json: { error: 'Invalid file format' }, status: :unprocessable_entity
      end

    rescue Exception => e
      Rails.logger.error(YAML::dump(e))
      render json: e.message, status: :unprocessable_entity
    end

    def index
      games = Game.includes(:players, :kills).all

      render json: games.as_json(methods: [:game_data]) and return
    rescue Exception => e
      Rails.logger.error(YAML::dump(e))
      render json: e.message, status: :unprocessable_content and return
    end

    def show
      game = Game.includes(:players, :kills).find(params[:id])

      render json: game.as_json(methods: [:game_data]) and return
    rescue Exception => e
      Rails.logger.error(YAML::dump(e))
      render json: e.message, status: :unprocessable_content and return
    end

    def kills_by_means
      games = Game.includes(:kills).all
      json = {}

      games.each do |game|
        json["game-#{game.id}"] = {
          kills_by_means: game.kills_by_means
        }
      end

      render json: json and return
    rescue => e
      Rails.logger.error(YAML.dump(e))
      render json: e.message, status: :unprocessable_content and return
    end

    private

    def valid_file?(file)
      %w[text/plain].include?(file.content_type)
    end
  end
end
