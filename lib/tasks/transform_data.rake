
namespace :ow do

  desc 'Transform csv file to JSON docs'
  task :transform_csv => :environment do |task, args|
    start_time = Time.now
    WORKING_DIR = `pwd`.strip

    Rails.logger.info("Starting transform_csv")

    service = DataTransformService.new
    service.transform("#{WORKING_DIR}/spec/csv/sample-part-data.csv")

    end_time = Time.now
    Rails.logger.info("Completed transform_csv in #{end_time - start_time} seconds.")
  end
end