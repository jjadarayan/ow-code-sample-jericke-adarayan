# ow-code-sample
Orbweaver Code Sample Project for Candidates 

# Goals 
* To see how you approach problem solving 
* To see how you write and test code 
* To see how you interpret requirements

# Setup 
This is a [Ruby on Rails](https://guides.rubyonrails.org/getting_started.html) project. These are the items required to get up and running. 

## Installing Ruby  
You will need to install Ruby version 2.7.4. This is done using a tool called [RVM](https://rvm.io) that separates this new Ruby install from from any other that might be on your system. 

### macOS or Linux
```bash
\curl -sSL https://get.rvm.io | bash -s stable
rvm install 2.7.4
```

### Windows
* Install cygwin or bash
* Run the commands from macOS or Linux section above  

For more info on RVM installation, check [here](https://rvm.io/rvm/install)


## Installing Ruby Dependencies
From the project directory, run the following command. 
```
bundle install
```

# Requirements 
This project is a small scale example of the kind of work we are frequently required to do. The goal is for you to write the code that will transform each non-header csv row into a JSON document. 

To complete this effort, the following items are required:

* Build a JSON Schema based on the structure of each CSV row in `spec/csv/sample-part-data.csv`
  * Columns `sku` through `part_status` should be at the top level.
  * Columns `image` through `3d_model_iges` should be part of an array with key `images`.
  * Columns `eu_rohs_y` through `voltage_rating` should be part of an array with key `attributes`. Each entry should be a key/value pair.
* Create a JSON document from each CSV row, validate it using the schema and save it to the file system.
* Write tests to show that your code works as you expect. 
  * Your approach to testing is as important to us as your approach to coding.

## Bonus points 
If you would like to go further than the example above, you can try the following items:

* Configure [ActiveRecord](https://guides.rubyonrails.org/getting_started.html#mvc-and-you) / SQLite to save each record to the database

# Coding
We have stubbed the first [RSpec](https://rspec.info) test for you in spec/lib/data_transform_service_spec.rb. When you have everything setup correctly, you can run

```
rspec
```

The last output from that command will look like 
```ruby
Finished in 0.02701 seconds (files took 1.54 seconds to load)
1 example, 0 failures
```

# Wrapping Up
When you have finished coding and wish to create the final set of JSON documents, you can run this Rake command
```
rake ow:transform_csv
```
