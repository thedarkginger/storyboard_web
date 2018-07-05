class RenameAudioFileToAudioInPodcasts < ActiveRecord::Migration[5.2]
  def change
    rename_column :podcasts, :audio_file, :audio
  end
end
