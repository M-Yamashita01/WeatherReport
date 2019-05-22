class WeatherImageSearch
  def self.search_from_image_folder(image_no)
    file_name = image_no.to_s + '.gif'

    Dir.glob('app/assets/images/*.gif').each do |f|
      if File.basename(f).eql?(file_name)
        return f
      end
    end

    raise IOError, 'Not found weather image file.'
  end
end
