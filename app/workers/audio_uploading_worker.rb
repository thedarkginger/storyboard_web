class AudioUploadingWorker
  include Sidekiq::Worker
  sidekiq_options retry: 5

  def perform(args)
    puts "----- Start uploading audio with params: #{args} -----"
    podcast = Podcast.find_by_id(args["id"])
    podcast.audio = File.open(args["temp_file"])
    if podcast.save
      File.delete(args["temp_file"])
    end
    puts "----- End uploading audio -----"
  end
end
