require 'netlinx/src'


describe NetLinx::SRC::Package do
  
  subject { NetLinx::SRC::Package.new file: file_name }
  
  let(:file_name) { 'sample.src' }
  let(:pwd) { ENV['RAKE_DIR'] }
  let(:test_data_path) { "#{pwd}/spec/data/#{dir}" }
  
  let(:around_proc) { Proc.new { |test|
    Dir.chdir test_data_path
    test.run
    Dir.chdir pwd
  } }
  
  
  describe ".src package" do
    
    describe "can be packed" do
      
      let(:dir) { 'src_package/pack' }
      
      around { |t| around_proc.call t }
      
      
      specify do
        File.delete file_name if File.exists? file_name
        File.exists?(file_name).should eq false
        
        files = Dir['**/*.*']
        
        # Pack files.
        subject.pack
        File.exists?(file_name).should eq true
        
        File.delete file_name
      end
      
    end
    
    
    describe "can be unpacked" do
      
      let(:dir) { 'src_package/unpack' }
      
      around { |test|
        Dir.chdir test_data_path
        # Delete extracted files.
        (Dir['*'] - Dir[file_name]).each { |f| FileUtils.rm_rf f }
        
        test.run
        
        (Dir['*'] - Dir[file_name]).each { |f| FileUtils.rm_rf f }
        Dir.chdir pwd
      }
      
      
      specify do
        # Only the src file to unpack should exist.
        Dir['**/*'].count.should eq 1
        
        subject.unpack
        
        ['project.apw', 'project.axs', 'includes/include.axi'].each do |f|
          File.exists?(f).should eq true
        end
      end
      
      specify "to a subdirectory" do
        # Only the src file to unpack should exist.
        Dir['**/*'].count.should eq 1
        
        subject.unpack 'subdir'
        
        Dir.exists?('subdir').should eq true
        
        ['project.apw', 'project.axs', 'includes/include.axi'].each do |f|
          File.exists?("subdir/#{f}").should eq true
        end
      end
      
      describe "in classic mode" do
        specify "flattens the file tree"
      end
      
    end
    
    describe "can copy and rename to .zip for easy browsing without extraction" do
      
      let(:dir) { 'src_package/to_zip' }
      let(:zip_file) { "#{file_name}.zip" }
      
      around { |t| around_proc.call t }
      
      
      specify do
        File.delete zip_file if File.exists? zip_file
        File.exists?(zip_file).should eq false
        
        subject.copy_to_zip
        
        File.exists?(zip_file).should eq true
        File.delete zip_file if File.exists? zip_file
      end
      
    end
    
  end
  
  
  # Glob syntax file used to exclude files from the package.
  describe ".srcignore" do
    
    let(:dir) { 'srcignore/exclusion' }
    
    around { |test|
      Dir.chdir test_data_path
      File.delete file_name if File.exists? file_name
      File.exists?(file_name).should eq false
      
      FileUtils.rm_rf 'extracted'
      Dir.exists?('extracted').should eq false
        
      test.run
      
      File.delete file_name if File.exists? file_name
      FileUtils.rm_rf 'extracted'
      Dir.chdir pwd
    }
    
    specify "file can be loaded" do
      subject.load_exclusions.should be_a Array
    end
    
  
    it "excludes specified files from the file search" do
      subject.pack
      subject.unpack 'extracted'
      
      extracted_files = Dir['extracted/**/*.*'].map { |f| f.gsub /extracted\//, '' }
      
      # Should not contain...
      extracted_files.join("\n")['.srcignore'].should eq nil
      
      extracted_files.join("\n")['.jpg'].should eq nil
      extracted_files.join("\n")['ignore_this_file.txt'].should eq nil
      extracted_files.join("\n")['ignore_this_file.axi'].should eq nil
      
      # Should contain...
      extracted_files.join("\n")['include_this_file.txt'].should_not eq nil
      extracted_files.join("\n")['include_this_file.axi'].should_not eq nil
    end
    
    
    describe "file generator" do
      
      let(:dir) { 'srcignore/generator' }
      
      let(:file_name) { '.srcignore' }
    
      around { |test|
        Dir.chdir test_data_path
        File.delete file_name if File.exists? file_name
        File.exists?(file_name).should eq false
        test.run
        File.delete file_name if File.exists? file_name
        Dir.chdir pwd
      }
      
      
      it "creates an ignore file" do
        subject.make_srcignore
        File.exists?(file_name).should eq true
      end
      
      it "raises an exception if an ignore file exists" do
        subject.make_srcignore
        File.exists?(file_name).should eq true
        
        expect {subject.make_srcignore}.to raise_error
        
        File.exists?(file_name).should eq true
      end
      
    end
  
  end
  
  
  # Warning message describing what to do if netlinx-src was not used for extraction.
  describe "extraction warning file" do
    
    let(:warning_file) { '_FILE_EXTRACTION_WARNING.txt' }
    
    
    specify { subject.make_warning_file.should be_a String }
    
    
    describe "is created in the package" do
      
      let(:dir) { 'warning_file/created' }
      
      around { |t| around_proc.call t }
      
      
      specify do
        subject.pack
        
        Zip::File.open file_name do |zip|
          zip.find_entry(warning_file).should_not be nil
        end
        
        File.delete file_name if File.exists? file_name
      end
      
    end
    
    
    describe "is not unpacked with this utility" do
      
      let(:dir) { 'warning_file/removed' }
      
      around { |test|
        Dir.chdir test_data_path
        
        # Delete extracted files.
        (Dir['*'] - Dir[file_name]).each { |f| FileUtils.rm_rf f }
          
        test.run
        
        (Dir['*'] - Dir[file_name]).each { |f| FileUtils.rm_rf f }
        Dir.chdir pwd
      }
      
      specify do
        subject.unpack
        
        File.exists?('project.axs').should eq true # Verify archive was unpacked.
        File.exists?(warning_file).should eq false # Warning file should not exist.
      end
      
    end
    
  end
  
  
  it "can read a .netlinx-package file for config info" do
    # Config file sould be in the project folder.
    # NO user-level config because those settings will be lost when the project
    # is transferred between computers. This could cause problems if a second
    # developer extracts and repacks the project.
    pending
  end
  
end