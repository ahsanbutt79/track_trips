desc 'Say hello!'
task :trip_archive do

  trips = Trip.where("created_at > ?", 6.month.ago)
  trips.each do |trip|
    
    ArchiveTrip.create(trip)

  end

end
