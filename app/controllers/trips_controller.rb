class TripsController < ApplicationController
  protect_from_forgery with: :null_session

  def getting_trips_api
    trips = Trip.where('company_id = ? and date(start_time) >= ? and date(start_time) <= ? and user_id = ?', params[:company_id].to_i, params[:start_date].to_date.strftime("%F"), params[:end_date].to_date.strftime("%F"), params[:filter_id].to_i) if params[:filter_type] == 'user'
    trips = Trip.where('company_id = ? and date(start_time) >= ? and date(start_time) <= ? and vehicle_id = ?', params[:company_id].to_i, params[:start_date].to_date.strftime("%F"), params[:end_date].to_date.strftime("%F"), params[:filter_id].to_i) if params[:filter_type] == 'vehicle'
    
    render json: {status: 'SUCCESS', message: 'Loaded all trips', data: trips}, status: :ok
  end

  def create_trips
    
    if params[:user_type] == 'admin'
      begin
      params[:trips].each do |trip|
       	
        Trip.create(name: trip['name'], user_id: trip['user_id'], vehicle_id: trip['vehicle_id'], start_time: trip['start_time'], end_time: trip['end_time'], company_id: trip['company_id'])
        
      end
      
      rescue ActiveRecord::ActiveRecordError
        raise ActiveRecord::Rollback #force a rollback
      end

      render json: {status: 201, message: 'All trips created'}, status: :ok

    end 
    
    render json: {status: 400, message: 'Error while creating trips'}, status: :failure
       
  end

  def trip_summary
    total_distance = Trip.where('company_id = ? and date(start_time) >= ? and date(start_time) <= ? and user_id = ?', params[:company_id].to_i, params[:start_date].to_date.strftime("%F"), params[:end_date].to_date.strftime("%F"), params[:filter_id].to_i).select("sum(distance) as total_distance").group("user_id").last.total_distance if params[:filter_type] == 'user'

    total_distance = Trip.where('company_id = ? and date(start_time) >= ? and date(start_time) <= ? and user_id = ?', params[:company_id].to_i, params[:start_date].to_date.strftime("%F"), params[:end_date].to_date.strftime("%F"), params[:filter_id].to_i).select("sum(distance) as total_distance").group("vehicle_id").last.total_distance if params[:filter_type] == 'vehicle'

    render json: {status: 'SUCCESS', message: 'Total distance returned', data: total_distance}, status: :ok
  
  end

  private
  def trip_params
    params.require(:trip).permit(:name, :user_id, :vehicle_id, :start_time, :end_time, :company_id)
  end 
  
end
