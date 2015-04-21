#!/usr/bin/env ruby

module MPUtils

  VERSION = '0.0.1'
  FEES_QTR = 75
  PPS = 50

  require_relative './MPUtils/database.rb'
  require 'time'

  @database = Database.connect
  @database.query_options.merge!(:symbolize_keys => true)

  system('clear') || system('cls')
  puts "Welcome to MPUtils"
  # Display Menu

  def self.get_timestamps
    i = 0
    Dir['./Invoices/*'].each do |invoice|
      invnum=/(\d+).pdf$/.match(File.basename(invoice))
      invdate=Time.parse(`mdls -name kMDItemContentCreationDate -raw "#{invoice}"`).strftime("%Y-%m-%d")
      i += 1
      print "#{i}, InvNum:#{invnum}, InvDate: #{invdate}\n"
      # Update DB
     @database.query( "UPDATE Invoices SET InvDate = '#{invdate}' WHERE InvoiceNum = '#{invnum[1]}'" )
    end
  end

  def self.standard_bill
    query = "SELECT Invoices.id, Invoices.`FamilyID#`, Membership.id, Membership.`firstname`, Membership.`surname`
                  FROM Invoices
                  INNER JOIN Membership
                  ON Invoices.`FamilyID#` = Membership.`family_id`
                  LEFT OUTER JOIN Invoice_Details
                  On (Invoices.id = Invoice_Details.`Invoice_id`)
                  WHERE Invoice_Details.`Invoice_id` IS NULL;"

    invoice_no_detail = @database.query(query)
    invoice_no_detail.each do |rec|
      4.times do |loop|
        puts loop+=1
        #@database.query("INSERT INTO Invoice_Details"
        invoice_line_num +=1
      end
    end
  end

  # get_timestamps
  standard_bill

  @database.close if @database
end


