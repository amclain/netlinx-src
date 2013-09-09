require 'zip'

Zip::File.open 'test.zip', Zip::File::CREATE do |zip|
  Dir['**/*'].each do |file|
    next if File.extname(file) == '.zip'
    zip.add file, file
    puts file
  end
  
  zip.get_output_stream('note.txt') {|s| s << 'These are notes.'}
end