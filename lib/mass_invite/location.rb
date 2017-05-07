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

module MassInvite
  # Location class
  class Location
    RAD_PER_DEG = Math::PI / 180
    EARTH_RADIUS_IN_KM = 6371
    LAT_LONG_REGEX = /^(\+|\-|)(\d+(\.\d+)?)$/

    attr_reader :lat, :long

    def initialize(lat, long)
      self.lat = lat
      self.long = long
    end

    # It calculates distance from another location in Kilometer
    #
    # @param  [Location] location A Location object
    # @return [Float] the distance from the other location in Kilometer
    def distance_from(location)
      distance(location)
    end

    # Converts latitude in degrees to latitude in radians
    #
    # @return [Float] latitude in radians
    def lat_in_rad
      @lat * RAD_PER_DEG
    end

    # Converts longitude in degrees to longitude in radians
    #
    # @return [Float] longitude in radians
    def long_in_rad
      @long * RAD_PER_DEG
    end

    # latitude setter
    #
    # @param  [Float, String] value latitude in String or Float type
    # @raise [ArgumentError] if latitude is not valid
    def lat=(value)
      @lat = validate_lat(value)
    end

    # longitude setter
    #
    # @param  [Float, String] value longitude in String or Float type
    # @raise [ArgumentError] if longitude is not valid
    def long=(value)
      @long = validate_long(value)
    end

    private

    def distance(loc)
      # Delta, converted to rad
      dlat_rad = (loc.lat - @lat).abs * RAD_PER_DEG
      dlon_rad = (loc.long - @long).abs * RAD_PER_DEG

      a = Math.sin(dlat_rad / 2)**2 + Math.cos(lat_in_rad) *
                                      Math.cos(loc.lat_in_rad) *
                                      Math.sin(dlon_rad / 2)**2
      d = 2 * Math.asin(Math.sqrt(a))

      # Delta in km
      EARTH_RADIUS_IN_KM * d
    end

    # Validates latitude
    #
    # @param  [Float, String] value latitude in String or Float type
    # @return [Float] latitude in degrees
    # @raise [ArgumentError] if latitude is not valid
    def validate_lat(value)
      lat = case value
            when String
              unless value =~ LAT_LONG_REGEX
                raise ArgumentError, 'Latitude is not valid.'
              end

              value.to_f
            when Float
              value
            else
              raise ArgumentError, 'Latitude should be a float/string value.'
            end

      raise ArgumentError, 'Latitude is not valid.' if lat > 90.0 || lat < -90.0

      lat
    end

    # Validates longitude
    #
    # @param  [Float, String] value longitude in String or Float type
    # @return [Float] longitude in degrees
    # @raise [ArgumentError] if longitude is not valid
    def validate_long(value)
      long = case value
             when String
               unless value =~ LAT_LONG_REGEX
                 raise ArgumentError, 'Longitude is not valid.'
               end

               value.to_f
             when Float
               value
             else
               raise ArgumentError, 'Longitude should be a float/string value.'
             end

      if long > 180.0 || long < -180.0
        raise ArgumentError, 'Longitude is not valid.'
      end

      long
    end
  end
end
