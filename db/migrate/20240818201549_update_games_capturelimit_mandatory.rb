class UpdateGamesCapturelimitMandatory < ActiveRecord::Migration[7.1]
  def change
    change_column_null :games, :capturelimit, false
  end
end
