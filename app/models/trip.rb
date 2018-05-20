class Trip < ActiveRecord::Base
  has_one :user
  has_one :vehicle

  before_save :check_user_vehicle_uniqueness  

  def check_user_vehicle_uniqueness  
    overlapping_trip = Trip.where("user_id = ? and end_time is not null", self.user_id)
    
    if overlapping_trip.present?
      false    
    else
      true
    end

  end

end
