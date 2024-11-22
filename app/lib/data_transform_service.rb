require 'csv'
require 'json'
require 'json-schema'

class DataTransformService

  # ==== This method does:
  #
  #  Iterates over the csv and transforms it into JSON documents
  #
  # ==== With params:
  #
  # @param file_path <String> - Path to the csv file to process
  #
  # ==== And returns:
  #
  # @return total_records_processed
  #
  # ==== And is used like:
  #
  # service.transform(csv_path)
  #
  def transform(csv_file_path)
    Rails.logger.info("Processing file from location: [#{csv_file_path}]")
    row_counter = 0

    # Define the path to the JSON file
    json_schema_path = File.join(__dir__, '..', '..', 'spec', 'lib', 'json_schemas', "sample_part_data.json")

    # Read the JSON file
    json_schema_content = File.read(json_schema_path)

    # Parse the JSON content
    json_schema = JSON.parse(json_schema_content)
    
    # Define the folder and file name to save json data
    folder_name = File.join(__dir__, '..', '..', 'spec', 'lib', 'json_doc') 
    Dir.mkdir(folder_name) unless Dir.exist?(folder_name)

    # Read the CSV file 
    #csv_file_path = File.join(__dir__, '..', '..', 'spec', 'csv', 'sample-part-data.csv') 
    csv_data = CSV.read(csv_file_path, headers: true);

    # Process each row and create JSON document
    csv_data.each_with_index do |row, index|
      json_doc = {
        "sku" => row["sku"],
        "display_pn" => row["display_pn"],
        "be_product_cat_name" => row["be_product_cat_name"],
        "short_description" => row["short_description"],
        "lead_time" => row["lead_time"],
        "meta_description" => row["meta_description"],
        "meta_title" => row["meta_title"],
        "part_status" => row["part_status"],
        "images" => [
          {
            "image" => row["image"],
            "prod_drawing" => row["prod_drawing"],
            "datasheet" => row["datasheet"],
            "3d_model_iges" => row["3d_model_iges"]
          }
        ],
        "attributes" => [
          { "key" => "eu_rohs_y", "value" => row["eu_rohs_y"] || ""},
          { "key" => "china_rohs", "value" => row["china_rohs"] || ""},
          { "key" => "reach", "value" => row["reach"] || ""},
          { "key" => "halogen_free", "value" => row["halogen_free"] || ""},
          { "key" => "country_of_manufacture", "value" => row["country_of_manufacture"] || ""},
          { "key" => "package_qty", "value" => row["package_qty"] || ""},
          { "key" => "primary_pack_type", "value" => row["primary_pack_type"] || ""},
          { "key" => "primary_pack_qty", "value" => row["primary_pack_qty"] || ""},
          { "key" => "contact_location_filter", "value" => row["contact_location_filter"] || ""},
          { "key" => "current_rating", "value" => row["current_rating"] || ""},
          { "key" => "dielectric_withstanding_volt", "value" => row["dielectric_withstanding_volt"] || ""},
          { "key" => "material_insulator", "value" => row["material_insulator"] || ""},
          { "key" => "material_shield", "value" => row["material_shield"] || ""},
          { "key" => "material_slider", "value" => row["material_slider"] || ""},
          { "key" => "number_of_contacts_filter", "value" => row["number_of_contacts_filter"] || ""},
          { "key" => "operating_temperature_range", "value" => row["operating_temperature_range"] || ""},
          { "key" => "orientation_filter", "value" => row["orientation_filter"] || ""},
          { "key" => "packaging", "value" => row["packaging"] || ""},
          { "key" => "termination_style_filter", "value" => row["termination_style_filter"] || ""},
          { "key" => "voltage_rating", "value" => row["voltage_rating"] || ""}
        ]
      }

      # Validate JSON document against the schema
      begin
        Rails.logger.debug("Processing row: #{index + 1}")
        
        JSON::Validator.validate!(json_schema, json_doc)

        # Define the full path to the file 
        file_name = "json_doc_#{index + 1}.json"
        file_path = File.join(folder_name, file_name)

        File.open(file_path, 'w') do |file|
            file.write(JSON.pretty_generate(json_doc))
        end

        Rails.logger.debug("JSON document #{index + 1} is valid and has been saved.")

        row_counter += 1
      end
    end

    row_counter 
  end

end