class ArchiveTrip < ActiveRecord::Base
  establish_connection "#{Rails.env}_sec"
end
