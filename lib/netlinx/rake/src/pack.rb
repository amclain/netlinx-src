require 'rake'
require 'rake/tasklib'
require 'netlinx/src/package'
require 'netlinx/workspace'

module NetLinx
  module Rake
    
    # Generate a NetLinx .src source code package.
    class Pack < ::Rake::TaskLib
      
      attr_accessor :name
      
      
      def initialize name = :pack
        @name = name
        
        yield self if block_given?
        
        define
      end
      
      
      protected
      
      def define
        desc "Generate a NetLinx .src source code package."
        
        task(name) do
          workspace = NetLinx::Workspace.search
          file_name = 'package.src'  # Default name if workspace not found.
          
          if workspace
            # Create package with workspace name.
            file_name = File.basename(workspace.file, '.apw') + '.src'
          end
          
          package = NetLinx::SRC::Package.new file: file_name
          package.pack
        end
      end
      
    end
    
  end
end
