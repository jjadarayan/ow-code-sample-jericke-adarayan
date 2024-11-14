require 'rails_helper'

RSpec.describe DataTransformService do

  let!(:csv_path) { 'spec/csv/sample-part-data.csv'}
  let!(:service) { DataTransformService.new}

  describe '#transform' do

    it 'should transform rows in the passed file from csv to JSON docs' do
      result = service.transform(csv_path)
      expect(result).to eql(25)

    end

  end

end