require 'nokogiri'
require 'open-uri'

class SimpleCrawlerAudio
  def initialize(url, path = nil)
    @url = url
    @path = path
  end

  def download
    process_download
  end

  private

  def source_elements
    html = Nokogiri::HTML( open @url )
    html.css('audio > source').map do |source|
      source['src']
    end
  end

  def process_download
    source_elements.each do |src|
      file_name = File.basename src

      path = if @path.nil?
        "./tmp/#{file_name}"
      else
        FileUtils.mkdir_p(@path)
        "#{@path}/#{file_name}"
      end

      File.open(path, 'wb') do |file|
        file.write(open(src).read)
      end
    end
  end
end
