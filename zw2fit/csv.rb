require 'erb'

class Csv
  class InvalidCsvError < StandardError; end

  def initialize(name:, steps:)
    @name = name
    raise(InvalidCsvError, 'Missing name') unless name

    @steps = steps
    raise(InvalidCsvError, 'Missing steps') if Array(steps).empty?
  end

  def to_s
    header + workout
  end

  private

  def header
    ERB.new(File.read('zw2fit/csv/header.csv.erb')).result(binding)
  end

  def workout
    steps.each_with_index.map do |step, i|
      ERB.new(File.read('zw2fit/csv/step.csv.erb')).result(binding)
    end.join
  end

  attr_reader :name, :steps
end
