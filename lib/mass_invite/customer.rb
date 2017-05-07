# This library can be pluggled into a bigger application and solve the problem
# with mass invitation for your users/customers.
# Copyright (C) 2017 Hamed Ramezanian Nik
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'json'

module MassInvite
  # Customer class
  class Customer
    attr_reader :user_id, :name
    attr_accessor :location

    def initialize(user_id, name, location)
      self.user_id = user_id
      self.name = name
      self.location = location
    end

    # user_id setter
    #
    # @param  [Integer] value User ID
    # @raise [ArgumentError] if the User ID is not an Integer type
    def user_id=(value)
      unless value.is_a?(Integer)
        raise ArgumentError, 'User ID should be an integer value.'
      end

      @user_id = value
    end

    # name setter
    #
    # @param  [String] value User name
    # @raise [ArgumentError] if the User name is not a String type or is empty
    def name=(value)
      unless value.is_a?(String)
        raise ArgumentError, 'Name should be a string value.'
      end

      raise ArgumentError, "Name can't be empty." if value.empty?

      @name = value
    end

    # Creates customer objects from a file
    #
    # @param [String, nil] path A full path to a file
    # @return [Array<Customer>] An array of customer objects
    # @raise [Errno::ENOENT] if the file doesn't exist
    # @raise [ArgumentError] if the file contains invalid customer lines
    def self.create_from_file(path = nil)
      default_path = File.expand_path('../../../data/customers', __FILE__)
      customers_file =
        if path
          File.open(path)
        else
          File.open(default_path)
        end

      customers_file.each_line.map do |line|
        create_from_json_string(line)
      end
    end

    # Creates a customer from json string
    #
    # @param [String] line A JSON-encoded customer object
    # @return [Customer] A customer object
    # @raise [ArgumentError] if the customer line is not a valid customer string
    def self.create_from_json_string(line)
      parsed_line = JSON.parse(line, symbolize_names: true)

      loc = Location.new(parsed_line[:latitude],
                         parsed_line[:longitude])
      Customer.new(parsed_line[:user_id], parsed_line[:name], loc)
    end
  end
end
