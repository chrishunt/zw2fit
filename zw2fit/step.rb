class Step
  class InvalidStepError < StandardError; end

  def initialize(xml, ftp:)
    @xml = xml
    raise(InvalidStepError, 'Missing xml') unless xml

    @ftp = ftp.to_f
    raise(InvalidStepError, 'Missing ftp') unless ftp.positive?
  end

  def power
    (ratio * ftp).round
  end

  def percent
    (ratio * 100).round
  end

  def timestamp
    "#{(duration / 60.0).to_i}:#{'%02d' % (duration % 60).to_i}"
  end

  def duration
    xml['Duration'].to_f.round(1).tap do |duration|
      raise(InvalidStepError, 'Missing duration') if duration.zero?
    end
  end

  def ratio
    if xml.name == 'Ramp'
      low  = xml['PowerLow'].to_f
      high = xml['PowerHigh'].to_f

      raise(InvalidStepError, 'Missing power') if [low, high].any?(&:zero?)

      (low + high) / 2.0
    else
      xml['Power'].to_f.tap do |power|
        raise(InvalidStepError, 'Missing power') if power.zero?
      end
    end
  end

  private

  attr_reader :xml, :ftp
end
