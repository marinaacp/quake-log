module Api
  class GamesController < ApplicationController
    # Disable CSRF protection for stateless API requests
    protect_from_forgery with: :null_session

    def create
      file = params[:file]

      if file && valid_file?(file)
        # Save the uploaded file to a temporary location
        file_path = Rails.root.join('tmp', file.original_filename)
        File.open(file_path, 'wb') do |f|
          f.write(file.read)
        end

        # Call the LogParserService
        LogParserService.new(file_path).parse

        render json: { message: 'File uploaded successfully' }, status: :ok
      else
        render json: { error: 'Invalid file format' }, status: :unprocessable_entity
      end

      # Clean up the temporary file
      File.delete(file_path) if File.exist?(file_path)

    rescue Exception => e
      Rails.logger.error(YAML::dump(e))
    end

    def index
      games = Game.includes(:players, :kills).all

      render json: games.as_json(methods: [:game_data])
    rescue Exception => e
      Rails.logger.error(YAML::dump(e))
    end

    def show
      game = Game.includes(:players, :kills).find(params[:id])

      render json: game.as_json(methods: [:game_data])
    rescue Exception => e
      Rails.logger.error(YAML::dump(e))
    end

    private

    def valid_file?(file)
      %w[text/plain].include?(file.content_type)
    end
  end
end
