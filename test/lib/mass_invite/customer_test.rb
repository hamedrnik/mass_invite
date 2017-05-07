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

require_relative '../../test_helper'

class CustomerTest < MassInviteTest
  def setup
    @location = Location.new(53.1302756, -6.2397222)
  end

  def test_create_a_customer
    customer = Customer.new(12, 'Hamed R. Nik', @location)
    assert_kind_of Customer, customer
    assert_equal customer.user_id, 12
    assert_equal customer.name, 'Hamed R. Nik'
    assert_equal customer.location.lat, @location.lat
    assert_equal customer.location.long, @location.long
  end

  def test_create_from_json
    customer_line = { user_id: 14, name: 'Hamed R. Nik',
                      latitude: @location.lat, longitude: @location.long }
    customer = Customer.create_from_json_string(customer_line.to_json)
    assert_kind_of Customer, customer
    assert_equal customer.user_id, 14
    assert_equal customer.name, 'Hamed R. Nik'
    assert_equal customer.location.lat, @location.lat
    assert_equal customer.location.long, @location.long
  end

  def test_create_from_json_with_invalid_location
    customer_line = { user_id: 14, name: 'Hamed R. Nik',
                      latitude: 'something', longitude: @location.long }
    assert_raises ArgumentError do
      Customer.create_from_json_string(customer_line.to_json)
    end
  end

  def test_create_from_json_with_nil_location
    customer_line = { user_id: 14, name: 'Hamed R. Nik',
                      latitude: nil, longitude: @location.long }
    assert_raises ArgumentError do
      Customer.create_from_json_string(customer_line.to_json)
    end
  end

  def test_create_from_json_with_empty_location
    customer_line = { user_id: 14, name: 'Hamed R. Nik',
                      latitude: @location.lat, longitude: '' }
    assert_raises ArgumentError do
      Customer.create_from_json_string(customer_line.to_json)
    end
  end

  def test_create_from_json_with_no_location
    customer_line = { user_id: 14, name: 'Hamed R. Nik',
                      latitude: @location.lat }
    assert_raises ArgumentError do
      Customer.create_from_json_string(customer_line.to_json)
    end
  end

  def test_create_from_malformed_json_string
    customer_line = 'Malformed JSON String'
    assert_raises JSON::ParserError do
      Customer.create_from_json_string(customer_line)
    end
  end

  def test_create_from_file
    customers = Customer.create_from_file
    assert_kind_of Array, customers
    assert_equal customers.count, 32
  end

  def test_user_id_should_be_integer
    assert_raises ArgumentError do
      Customer.new('10', 'Richard', @location)
    end
  end

  def test_name_should_be_string
    assert_raises ArgumentError do
      Customer.new(34, 444, @location)
    end
  end

  def test_name_should_not_be_an_empty_string
    assert_raises ArgumentError do
      Customer.new(34, '', @location)
    end
  end
end
