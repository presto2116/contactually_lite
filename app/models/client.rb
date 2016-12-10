class Client < ActiveRecord::Base
  require 'csv'
  # CSV_MAP used to correct header of sample data.csv
  CSV_MAP = {
    'First Name'=> 'first_name',
    'Last Name' => 'last_name',
    'Email Address'=> 'email_address',
    'Phone Number'=> 'phone_number',
    'Company Name'=> 'company_name',
  }
  
  def self.import(file)
    #loop through each row
    CSV.foreach(file.path, headers: true) do |row|
      #change the attribute key to match database key
      client = CSV_MAP.each_with_object({}) do |(csv_key, attribute_key), result|
        result[attribute_key] = row[csv_key]
      end
      #and create a client 
      Client.create! client
    end
  end

end
