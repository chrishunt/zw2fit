require 'erb'

class Csv
  class InvalidCsvError < StandardError; end

  def initialize(name:, steps:, verbose: false)
    @verbose = verbose

    @name = name
    raise(InvalidCsvError, 'Missing name') unless name

    @steps = steps
    raise(InvalidCsvError, 'Missing steps') if Array(steps).empty?

    puts "#{name} has #{steps.count} workout steps" if verbose
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
      if verbose
        puts "Adding #{step.timestamp} @ #{step.percent}%/#{step.power}W"
      end

      ERB.new(File.read('zw2fit/csv/step.csv.erb')).result(binding)
    end.join
  end

  attr_reader :name, :steps, :verbose
end
