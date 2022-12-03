class TicketsController < ApplicationController
    before_action :set_ticket, only: %i[ show edit update destroy ]
    def index
       @tickets = Ticket.all
    end 

    def new
        @ticket = Ticket.new
        @rents = Rent.all
    end

    def edit
        @ticket = Ticket.find(params[:id])
    end
    
    def create
        @ticket = Ticket.new(ticket_params)
        @ticket.user_id = current_user.id
        respond_to do |format|
            if @ticket.save
                format.html { redirect_to ticket_url(@ticket), notice: "Ticket creado" }
                format.json { render :show, status: :created, location: @ticket }
             else
                format.html { render :new, status: :unprocessable_entity } #No guarda los params => hay error
                format.json { render json: @ticket.errors, status: :unprocessable_entity }
            end
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
            params.require(:ticket).permit(:mensaje, :opcion, :car_id, :photos => [])
        end  

end
