#coding:utf-8
class BooksController < ApplicationController
	require 'rest_client'
	require "nokogiri"

	def login
		
	end

	def index
		if params[:idno].blank? || params[:psw].blank?
			flash[:errors] = "用户名或密码不能为空"
			redirect_to :back
		else
			xml_data = get_service_data(params[:idno],params[:psw])
			@books = xml_parse xml_data		
		end
	end

	private

	def get_service_data (idno,psw) 
	    xml_data = RestClient.post 'http://202.120.96.99:8055/libweb.asmx/QueryLoad', :idno => idno, :psw => psw  rescue nil
	end 

	def xml_parse(data)
		doc = Nokogiri::XML(data)
		books = []
		doc.xpath('//NewDataSet/Result').map do |i|
			book = {}
			book[:name] =  i.xpath('Name').inner_text
			book[:serial_number] =  i.xpath('SerialNumber').inner_text
			book[:title] =  i.xpath('Title').inner_text
			book[:author] =  i.xpath('Author').inner_text
			book[:publish] =  i.xpath('Publish').inner_text
			book[:pub_date] =  i.xpath('PubDate').inner_text
			book[:barcode] =  i.xpath('Barcode').inner_text
			book[:address] =  i.xpath('Address').inner_text
			book[:borrow_time] =  i.xpath('BorrowTime').inner_text
			book[:due_time] =  i.xpath('DueTime').inner_text
			book[:renews_counts] =  i.xpath('RenewsCounts').inner_text
			book[:exceed] =  i.xpath('Exceed').inner_text
			book[:renews] =  i.xpath('Renews').inner_text
			books << book
      		end
      		books
	end
end
