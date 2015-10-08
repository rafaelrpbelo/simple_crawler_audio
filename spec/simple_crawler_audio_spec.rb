require 'spec_helper'
require './lib/simple_crawler_audio'

RSpec.describe SimpleCrawlerAudio do
  context 'should be able to download' do
    subject { SimpleCrawlerAudio.new('./spec/fixtures/audio.html') }

    it 'when the source is into a audio tag' do
      expect{ subject.download }.to change{ File.exist?('./tmp/audio.mp3') }.to(true)
    end

    it 'should be the same checksum of the both files' do
      subject.download
      download_md5sum = Digest::MD5.hexdigest(File.read('./tmp/audio.mp3'))
      expect(download_md5sum).to eq "eebc1b05345cffe3cf7a80b15f6251f6"
    end

    it 'with a custom path' do
      out_path = './tmp/downloads'
      expect { SimpleCrawlerAudio.new('./spec/fixtures/audio.html', out_path).download }
      .to change { File.exist?(out_path << '/audio.mp3') }.to(true)
    end
  end
end
