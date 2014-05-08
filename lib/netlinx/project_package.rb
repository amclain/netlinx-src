require 'zip'

module NetLinx
  class ProjectPackage
    
    # Parameters:
    #
    #   Mode:
    #     :standard - Intelligently package all files pertaining to a
    #       NetLinx project.
    #
    #     :classic  - Emulates the AMX file packager, including only .axs
    #       and .axi files in the package. Also mimicks the same folder
    #       structure.
    #
    def initialize **kvargs
      @file                = kvargs.fetch :file, ''
      @mode                = kvargs.fetch :mode, :standard
      @excluded_extensions = kvargs.fetch :excluded_extensions,
        [
          'ai', 'bmp', 'eps', 'gz', 'jpg', 'jpeg', 'png', 'psd', 'src',
          'svg', 'tar', 'zip'
        ]
    end
    
    # Pack the project into a NetLinx .src package.
    def pack
      File.delete @file if File.exists? @file
      
      files = Dir['**/*'] - Dir[@file]
      
      Zip::File.open @file, Zip::File::CREATE do |zip|
        files.each { |file| zip.add file, file }
      end
    end
    
    # Unpack a NetLinx .src project package.
    # Unpacks to the given directory, if provided.
    def unpack dir = nil
      Zip::File.open @file do |zip|
        zip.each_entry do |e|
          path = dir.nil? ? e.name : "#{dir}/#{e.name}"
          e.extract path
        end
      end
    end
    
    # Copy the NetLinx .src file to .zip for easy browsing without unpacking.
    def copy_to_zip
      FileUtils.cp @file, "#{@file}.zip"
    end
    
    # Remove the .zip version of this NetLinx .src file if it exists.
    def remove_zip
      File.delete "#{@file}.zip" if File.exists? "#{@file}.zip"
    end
    
    # Create a standard .srcignore file in the current directory.
    # Raises exception if file exists.
    def make_srcignore
      raise IOError, "A .srcignore file already exists in this directory." \
        if File.exists? '.srcignore'
      
      string = <<-EOS
# --------------------------------------------------- #
#  Files to exclude from .SRC package (glob format).  #
# --------------------------------------------------- #

# AMX

*.src
*.tp4

# Graphics

*.ai
*.bmp
*.eps
*.jpg
*.jpeg
*.png
*.psd
*.svg

# Archives

*.gz
*.tar
*.zip

# Documentation

*.pdf

EOS
        
        File.write '.srcignore', string
    end
    
  end
end