class SchedulesController < ApplicationController
    def index
        @technicians = Technician.includes(:work_orders)  # Fetch all technicians and their associated work orders
    end
end
