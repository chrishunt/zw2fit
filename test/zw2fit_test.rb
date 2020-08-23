require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

require './zw2fit'

describe Zw2fit do
  describe '#to_csv' do
    Dir['test/workouts/*.zwo'].each do |zwo_path|
      it "converts #{zwo_path} to csv" do
        csv_path = File.join(
          File.dirname(zwo_path),
          "#{File.basename(zwo_path, '.zwo')}.csv"
        )

        zwo = File.read(zwo_path)
        csv = File.read(csv_path)

        result = Zw2fit.new(zwo: zwo).to_csv(ftp: 245)

        assert_equal csv, result
      end
    end
  end
end
