# from friends.nico

# frozen_string_literal: true

class NicoLink
  BASE_URI = URI.parse('https://nico.ms')

  VIDEO_TYPES = %w(sm so nm).freeze
  LIVE_TYPES  = %w(lv).freeze
  TEMPORAL_TYPES = VIDEO_TYPES + LIVE_TYPES

  VIDEO_RE = %r{#{VIDEO_TYPES.join('|')}}
  LIVE_RE  = %r{#{LIVE_TYPES.join('|')}}
  NON_TEMPORAL_TYPES = %w(co ch im mg bk td kn gm nc ar nw np mylist\/).freeze

  NICO_ID_RE = %r{(#{[].concat([TEMPORAL_TYPES, NON_TEMPORAL_TYPES]).join('|')})(\d+)}
  NICO_ID_RE_FULLSTR = %r{\A#{NICO_ID_RE}\z}

  DIC_WORD_RE = %r{(?<dic_word>[^\s\?]+)}

  TIME_RE = %r{\d{1,2}:[0-5]\d}
  TIME_RE_FULLSTR = %r{\A#{TIME_RE}\z}

  NICO_DOMAIN_RE = %r{(([a-z0-9\.]+\.)?nicovideo\.jp(\/watch|\/user\/\d+)?|nico\.ms)\/}

  PREFIX_RE = %r{(?<prefix>^|[^\/\)\w])}
  SUFFIX_RE = %r{(\?(?<query>[a-zA-Z0-9_&%=]*))?(#(?<time>#{TIME_RE}))?}

  NICODIC_LINK_RE = %r{(?<nico_domain>(https?:\/\/)?dic\.nicovideo\.jp/)(t\/)?(?<nico_link>a\/#{DIC_WORD_RE}#{SUFFIX_RE})}
  NICOMAIN_LINK_RE = %r{(#{PREFIX_RE}|(?<nico_domain>(https?:\/\/)?#{NICO_DOMAIN_RE}))(?<nico_link>(?<nico_id>#{NICO_ID_RE})#{SUFFIX_RE})}

  NICOLINK_RE = %r{(#{NICOMAIN_LINK_RE})|(#{NICODIC_LINK_RE})}

  def self.parse(text)
    build(NICOLINK_RE.match(text))
  end

  def self.build(matches)
    if matches[:dic_word]
      NicoLink::Dic.new(matches)
    else
      NicoLink.new(matches)
    end
  end

  attr_reader :nico_id, :type, :from_sec

  def initialize(match)
    @match = match
    query = Rack::Utils.parse_query(match[:query])
    process_nico_id(match[:nico_id])
    process_time(match[:time]) if match[:time]
    process_query_time(query['time']) if query['time']
  end

  def text
    [nico_id, time].compact.join('#')
  end

  def range
    [
      @match.char_begin(:nico_domain) || @match.char_begin(:nico_link),
      @match.char_end(:nico_link)
    ]
  end

  def url
    href = BASE_URI + @nico_id
    href.query = URI.encode_www_form(from: @from_sec) if time?
    href.normalize.to_s
  end

  def video?
    VIDEO_TYPES.include? @type
  end

  def time
    return unless @from_sec
    min = @from_sec / 60
    sec = @from_sec % 60

    "#{min}:#{sec}"
  end

  private

  def process_nico_id(nico_id)
    @nico_id = nico_id

    m = NICO_ID_RE_FULLSTR.match(@nico_id)
    @type = m[1] unless m.nil?
  end

  def process_time(time)
    time = time.to_s
    return unless temporal?
    return unless TIME_RE_FULLSTR.match(time)

    min, sec = time.split(':').map(&:to_i)
    sec += min * 60

    @from_sec = sec unless sec <= 0
  end

  def process_query_time(time)
    return unless temporal?
    time = time.to_i

    @from_sec = time unless time <= 0
  end

  def temporal?
    TEMPORAL_TYPES.include?(@type)
  end

  def time?
    !@from_sec.nil?
  end

  class Dic < NicoLink
    attr_accessor :word

    def initialize(match)
      @match = match
      @word = CGI.unescape(match[:dic_word]).scrub ''
    end

    def text
      # join with SIX-PER-EM SPACE
      [word, ':nicodic:'].join("\u2006")
    end

    def url
      "http://dic.nicovideo.jp/a/#{CGI.escape(word)}"
    end
  end
end
