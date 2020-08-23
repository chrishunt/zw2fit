require 'nokogiri'
require './zw2fit/step'
require './zw2fit/csv'

class Zw2fit
  class InvalidWorkoutError < StandardError; end

  def initialize(zwo:, verbose: false)
    @zwo = zwo
    @verbose = verbose
  end

  def to_csv(ftp:)
    puts "Generating CSV for #{workout_name}" if verbose

    Csv.new(
      name: workout_name,
      steps: workout_steps(ftp: ftp),
      verbose: verbose,
    ).to_s
  end

  private

  attr_reader :zwo, :verbose

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
