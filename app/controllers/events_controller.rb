class EventsController < ApplicationController
    private
    
    def event_params
      params.require(:event).permit(:title, :date, :location, :description, :attending_count)
    end
    
    public
    
    # Display the events page
    def index
      # Store all of the events from the model in an instance variable so the view can access them
      @events = Event.all.order("attending_count DESC")
      
      @favorite_events
      @favorite_event_ids
      if(logged_in?)
        @favorite_events = FavoriteEvent.where("user_id = #{session[:user_id]}")
        @favorite_event_ids = @favorite_events.map{|event| event.event_id}
      end
    end
    
    # Display the create events page
    def create
      if (session[:user_id] == nil)
        redirect_to login_path
      end
    end
    
    def favorite
      type = params[:type]
      event = Event.find(params[:id])
      current_user = User.find(session[:user_id])
      
      if type == "attend"
        favorite_event = FavoriteEvent.new(user_id: current_user.id, event_id: event.id)
        favorite_event.save
        Event.increment_counter(:attending_count, event.id)
        redirect_to params[:path]
  
      elsif type == "unattend"
        favoriteEntry = FavoriteEvent.find_by(user_id: current_user.id, event_id: event.id)
        if(favoriteEntry != nil)
          favoriteEntry.destroy
        end
        
        if(event.attending_count > 0)
          Event.decrement_counter(:attending_count, event.id)
        end
        redirect_to params[:path]
      else
        # Type missing, nothing happens
        redirect_to "/"
      end
    end
    
    # Submit the info to be create the event
    def submit
      if (session[:user_id] != nil)
        # https://stackoverflow.com/a/13606990
        
        event_params()[:date] = Date.new(
          params[:event]["date(1i)"].to_i,
          params[:event]["date(2i)"].to_i,
          params[:event]["date(3i)"].to_i
        )
        
        event = Event.new(event_params())
        
        event.attending_count = 0
    
        # Check if the validations are successful and return false if they're not
        # If validations fail, abort and do not save
        # http://api.rubyonrails.org/classes/ActiveRecord/Persistence.html#method-i-save
        if event.save
          redirect_to events_path
        else
          # If there are any errors, set the flash warning to include the array of error messages
          if event.errors.any?
            flash[:warning] = event.errors.full_messages.uniq
            
            redirect_to events_create_path
          end
        end
      else
        redirect_to login_path
      end
    end
end
