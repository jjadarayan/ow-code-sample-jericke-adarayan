require 'rails_helper'
require 'csv'
require 'tempfile'
#require_relative '../csv_processor'

RSpec.describe DataTransformService do

    #1
    let!(:csv_path) { 'spec/csv/sample-part-data.csv'}
    let!(:service) { DataTransformService.new}
    
    describe '#transform' do
      it 'should return the number of rows processed to equal number of rows in sample csv file' do
        result = service.transform(csv_path)
        expect(result).to eql(25)
      end
    end
   
    #2
    describe '#transform' do
      let(:csv_content) do
        <<~CSV
          sku,display_pn,be_product_cat_name,short_description,lead_time,meta_description,meta_title,part_status,image,prod_drawing,datasheet,3d_model_iges,eu_rohs_y,china_rohs,reach,halogen_free,country_of_manufacture,package_qty,primary_pack_type,primary_pack_qty,contact_location_filter,current_rating,dielectric_withstanding_volt,material_insulator,material_shield,material_slider,number_of_contacts_filter,operating_temperature_range,orientation_filter,packaging,termination_style_filter,voltage_rating
          10061122131120HLF,10061122-131120HLF,0.30MM FLEX CONNECTORS,"0.30mm Flex Connector, YLL-D Series / High Retention Force Type, 13 Pos, Side Entry Surface Mount, ZIF Connector, 0.3mm",84,"Amphenol ICC is one of the leading manufacturers of FLEX CONNECTORS .  Contact us today for more details of 0.30MM FLEX CONNECTORS, part number 10061122-131120HLF.",10061122-131120HLF | FPC/FFC | Amphenol ICC,active,http://www.amphenol-icc.com/media/wysiwyg/files/pn-image/yll_d 10061122.jpg,https://cdn.amphenol-icc.com/media/wysiwyg/files/drawing/10061122.pdf,https://cdn.amphenol-icc.com/media/wysiwyg/files/documentation/datasheet/flex/flexconnectors_030mm.pdf,https://cdn.amphenol-icc.com/media/wysiwyg/files/3d/i10061122-131120hlf.zip,Yes,Yes,Yes,Yes,Japan,5000,TAP/RL,5000,Bottom,0.2A,90V AC for 1 minute,,,"Thermoplastic Resin, Natural",13,-55,Right Angle,Embossed Tape on Reel,Surface Mount,30V
        CSV
      end
  
      it 'processes sample CSV data' do
        Tempfile.open(['test_csv', '.csv']) do |file|
          file.write(csv_content)
          file.rewind 
    
          result = service.transform(file.path)
          expect(1).to eq(1)
        end
      end
    end

    #3
    describe '#transform' do
      let(:csv_content) do
        <<~CSV
          sku,display_pn,be_product_cat_name,short_description,lead_time,meta_description,meta_title,part_status,image,prod_drawing,datasheet,3d_model_iges,eu_rohs_y,china_rohs,reach,halogen_free,country_of_manufacture,package_qty,primary_pack_type,primary_pack_qty,contact_location_filter,current_rating,dielectric_withstanding_volt,material_insulator,material_shield,material_slider,number_of_contacts_filter,operating_temperature_range,orientation_filter,packaging,termination_style_filter,voltage_rating
          ,10061122-131120HLF,0.30MM FLEX CONNECTORS,"0.30mm Flex Connector, YLL-D Series / High Retention Force Type, 13 Pos, Side Entry Surface Mount, ZIF Connector, 0.3mm",84,"Amphenol ICC is one of the leading manufacturers of FLEX CONNECTORS .  Contact us today for more details of 0.30MM FLEX CONNECTORS, part number 10061122-131120HLF.",10061122-131120HLF | FPC/FFC | Amphenol ICC,active,http://www.amphenol-icc.com/media/wysiwyg/files/pn-image/yll_d 10061122.jpg,https://cdn.amphenol-icc.com/media/wysiwyg/files/drawing/10061122.pdf,https://cdn.amphenol-icc.com/media/wysiwyg/files/documentation/datasheet/flex/flexconnectors_030mm.pdf,https://cdn.amphenol-icc.com/media/wysiwyg/files/3d/i10061122-131120hlf.zip,Yes,Yes,Yes,Yes,Japan,5000,TAP/RL,5000,Bottom,0.2A,90V AC for 1 minute,,,"Thermoplastic Resin, Natural",13,-55,Right Angle,Embossed Tape on Reel,Surface Mount,30V
        CSV
      end

      it 'raises error when sku value in csv is missing' do
        Tempfile.open(['test_csv', '.csv']) do |file|
          file.write(csv_content)
          file.rewind 
    
          expect {service.transform(file.path)}.to raise_error(JSON::Schema::ValidationError)
        end
      end
    end

    #4
    let!(:service) { DataTransformService.new}
    
    describe '#transform' do
      let(:csv_content) do
        <<~CSV
          display_pn,be_product_cat_name,short_description,lead_time,meta_description,meta_title,part_status,image,prod_drawing,datasheet,3d_model_iges,eu_rohs_y,china_rohs,reach,halogen_free,country_of_manufacture,package_qty,primary_pack_type,primary_pack_qty,contact_location_filter,current_rating,dielectric_withstanding_volt,material_insulator,material_shield,material_slider,number_of_contacts_filter,operating_temperature_range,orientation_filter,packaging,termination_style_filter,voltage_rating
          10061122131120HLF,10061122-131120HLF,0.30MM FLEX CONNECTORS,"0.30mm Flex Connector, YLL-D Series / High Retention Force Type, 13 Pos, Side Entry Surface Mount, ZIF Connector, 0.3mm",84,"Amphenol ICC is one of the leading manufacturers of FLEX CONNECTORS .  Contact us today for more details of 0.30MM FLEX CONNECTORS, part number 10061122-131120HLF.",10061122-131120HLF | FPC/FFC | Amphenol ICC,active,http://www.amphenol-icc.com/media/wysiwyg/files/pn-image/yll_d 10061122.jpg,https://cdn.amphenol-icc.com/media/wysiwyg/files/drawing/10061122.pdf,https://cdn.amphenol-icc.com/media/wysiwyg/files/documentation/datasheet/flex/flexconnectors_030mm.pdf,https://cdn.amphenol-icc.com/media/wysiwyg/files/3d/i10061122-131120hlf.zip,Yes,Yes,Yes,Yes,Japan,5000,TAP/RL,5000,Bottom,0.2A,90V AC for 1 minute,,,"Thermoplastic Resin, Natural",13,-55,Right Angle,Embossed Tape on Reel,Surface Mount,30V
        CSV
      end

      it 'raises error when sku column in csv is missing' do
        Tempfile.open(['test_csv', '.csv']) do |file|
          file.write(csv_content)
          file.rewind 
    
          expect {service.transform(file.path)}.to raise_error(JSON::Schema::ValidationError)
        end
      end
    end

end