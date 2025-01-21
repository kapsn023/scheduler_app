# lib/tasks/import.csv.rake

namespace :import do
  # Task to import technicians
  desc "Import technicians from CSV with preassigned IDs"
  task technicians: :environment do
    require "csv"

    # Path to the technicians CSV file (adjust the path to where your CSV is located)
    CSV.foreach(Rails.root.join("public", "csv", "technicians.csv"), headers: true) do |row|
      technician_id = row["id"]  # Assumes "id" column exists in the CSV

      # Check if the technician with the given ID already exists
      technician = Technician.find_by(id: technician_id)

      if technician
        # Update the technician if they already exist
        technician.update(name: row["name"])
      else
        # Create a new technician with the preassigned ID
        Technician.create(id: technician_id, name: row["name"])
      end
    end

    puts "Technicians imported successfully."
  end

  # Task to import locations
  desc "Import locations from CSV with preassigned IDs"
  task locations: :environment do
    require "csv"

    # Path to the locations CSV file
    CSV.foreach(Rails.root.join("public", "csv", "locations.csv"), headers: true) do |row|
      location_id = row["id"]  # Assumes "id" column exists in the CSV

      # Check if the location with the given ID already exists
      location = Location.find_by(id: location_id)

      if location
        # Update the location if it already exists
        location.update(name: row["name"], city: row["city"])
      else
        # Create a new location with the preassigned ID
        Location.create(id: location_id, name: row["name"], city: row["city"])
      end
    end

    puts "Locations imported successfully."
  end

  # Task to import work orders
  desc "Import work orders from CSV with preassigned IDs"
  task work_orders: :environment do
    require "csv"

    # Path to the work orders CSV file
    CSV.foreach(Rails.root.join("public", "csv", "work_orders.csv"), headers: true) do |row|
      technician = Technician.find_by(id: row["technician_id"])  # Assumes technician_id is in the CSV
      location = Location.find_by(id: row["location_id"])  # Assumes location_id is in the CSV
      work_id = row["id"]  # Assumes "id" column exists in the CSV

      # Ensure both technician and location exist before creating work order
      if technician && location
        work_order = WorkOrder.find_by(id: work_id)

        if work_order
          work_order.update(
              technician: technician,
      location: location,
      start_time: row["time"],
      duration: row["duration"],
      price: row["price"]
    )
        else
    WorkOrder.create(
      technician: technician,
      location: location,
      start_time: row["time"],
      duration: row["duration"],
      price: row["price"]
    )
        end
      else
        puts "Skipping work order due to missing technician or location."
      end
    end

    puts "Work orders imported successfully."
  end
end
