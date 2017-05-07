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

class LocationTest < MassInviteTest
  def test_create_a_location_from_float
    location = Location.new(51.92893, -10.27699)
    assert_kind_of Location, location
    assert_equal location.lat, 51.92893
    assert_equal location.long, -10.27699
  end

  def test_create_a_location_from_string
    location = Location.new('51.92893', '-10.27699')
    assert_kind_of Location, location
    assert_equal location.lat, 51.92893
    assert_equal location.long, -10.27699
  end

  def test_create_a_location_with_invalid_string
    assert_raises ArgumentError do
      Location.new('551.92893', '-1550.27699')
    end
  end

  def test_lat_and_long_should_be_valid
    assert_raises ArgumentError do
      Location.new(251.92893, -10.27699)
    end
  end

  def test_distance_between_two_points
    l1 = Location.new(53.314858, -6.289984)
    l2 = Location.new(53.057425, -6.156493)
    assert_equal l1.distance_from(l2).round, 30
  end
end
