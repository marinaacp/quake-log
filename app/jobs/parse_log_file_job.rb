class ParseLogFileJob < ApplicationJob
  queue_as :default

  def perform(file_path)
    # Parse the file
    LogParserService.new(file_path).parse

    # Clean up the temporary file
    File.delete(file_path) if File.exist?(file_path)
  rescue => e
    Rails.logger.error(YAML.dump(e))
  end
end
