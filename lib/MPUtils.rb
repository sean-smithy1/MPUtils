#!/usr/bin/env ruby

module MPUtils

  VERSION = '0.0.1'
  FEES_QTR = 75

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
    invoice_line_num=0
    family_id = 0

    query = "SELECT Invoices.id as InvID, Invoices.`family_id`, Memberships.id as MemberID, Memberships.`firstname`, Memberships.`surname`
                  FROM Invoices
                  INNER JOIN Memberships
                  ON Invoices.`family_id` = Memberships.`family_id`
                  LEFT OUTER JOIN Invoice_Details
                  On (Invoices.id = Invoice_Details.`invoice_id`)
                  WHERE Invoice_Details.`invoice_id` IS NULL;"

    invoice_no_detail = @database.query(query)

    invoice_no_detail.each do |rec|
      if family_id != rec[:family_id]
        invoice_line_num = 1
      end
      4.times do |term|
#        puts "#{rec[:InvID]}, #{invoice_line_num}, #{rec[:MemberID]} Des: Term #{term+=1} 2014 - #{rec[:firstname]} #{rec[:surname]}, qty:1, $#{FEES_QTR}"
       @database.query("INSERT INTO Invoice_Details (invoice_id, line_no, member_id, description, qty, amount)
                                      VALUES (#{rec[:InvID]}, #{invoice_line_num}, #{rec[:MemberID]}, \"Term #{term+=1} 2014 - #{rec[:firstname]} #{rec[:surname]}\", 1, #{FEES_QTR});")
        puts "Added Invoice detail for Inv:#{rec[:InvID]}, Line:#{invoice_line_num}"
        invoice_line_num +=1
      end
    family_id=rec[:family_id]
    end
  end

  def import_bank_statement

  end

  # get_timestamps
  standard_bill

  @database.close if @database
end


