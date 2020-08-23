require 'nokogiri'
require './zw2fit/step'
require './zw2fit/csv'

class Zw2fit
  class InvalidWorkoutError < StandardError; end

  attr_reader :zwo

  def initialize(zwo:)
    @zwo = zwo
  end

  def to_csv(ftp:)
    Csv.new(
      name: workout_name,
      steps: workout_steps(ftp: ftp)
    ).to_s
  end

  private

  def workout_name
    xml.xpath('//workout_file/name').text.tap do |name|
      raise(InvalidWorkoutError, 'Missing workout name') if name.to_s.empty?
    end
  end

  def workout_steps(ftp:)
    xml.xpath('//SteadyState | //Ramp').map do |step|
      Step.new(step, ftp: ftp)
    end.tap do |steps|
      raise(InvalidWorkoutError, 'Missing workout steps') if steps.empty?
    end
  end

  def xml
    Nokogiri.parse(zwo)
  rescue => e
    raise(InvalidWorkoutError, e)
  end
end
