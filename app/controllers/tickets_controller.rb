class TicketsController < ApplicationController
    def index
       @tickets = Ticket.all
    end 

    def new
        @ticket = Ticket.new
    end

    def edit
    end
    
    def create
        @ticket = Ticket.new(ticket_params)
        @ticket.user_id = current_user.id
        @ticket.creacion = Time.now
        respond_to do |format|
            if @ticket.save
                 redirect_to @ticket
             else
                render new
            end
    end


    def show
        @ticket = Ticket.find(params[:id])
    end

    private
    # Use callbacks to share common setup or constraints between actions.
        def set_ticket
            @ticket = Ticket.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def ticket_params
            params.require(:ticket).permit(:activo, :creacion, :car_id, :user_id)
        end  
    end

    

end
