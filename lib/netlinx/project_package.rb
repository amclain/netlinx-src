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
    
    def pack
      File.delete @file if File.exists? @file
      
      files = Dir['**/*.*'] - Dir[@file]
      
      Zip::File.open @file, Zip::File::CREATE do |zip|
        files.each { |file| zip.add file, file }
      end
      
    end
    
    def unpack
    end
    
  end
end