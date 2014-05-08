require 'netlinx/project_package'


describe NetLinx::ProjectPackage do
  
  subject { NetLinx::ProjectPackage.new file: file_name }
  
  let(:file_name) { 'sample.src' }
  let(:pwd) { ENV['RAKE_DIR'] }
  
  let(:around_proc) { Proc.new { |test|
    Dir.chdir "#{pwd}/spec/data/#{dir}"
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
      
      around { |t| around_proc.call t }
      
      
      specify do
        # Delete extracted files.
        (Dir['*'] - Dir[file_name]).each { |f| FileUtils.rm_rf f }
        
        # Only the src file to unpack should exist.
        Dir['**/*'].count.should eq 1
        
        subject.unpack
        
        ['project.apw', 'project.axs', 'includes/include.axi'].each do |f|
          File.exists?(f).should eq true
        end
        
        # Delete extracted files.
        (Dir['*'] - Dir[file_name]).each { |f| FileUtils.rm_rf f }
      end
      
      specify "to a subdirectory" do
        # Delete extracted files.
        (Dir['*'] - Dir[file_name]).each { |f| FileUtils.rm_rf f }
        
        # Only the src file to unpack should exist.
        Dir['**/*'].count.should eq 1
        
        subject.unpack 'subdir'
        
        Dir.exists?('subdir').should eq true
        
        ['project.apw', 'project.axs', 'includes/include.axi'].each do |f|
          File.exists?("subdir/#{f}").should eq true
        end
        
        # Delete extracted files.
        (Dir['*'] - Dir[file_name]).each { |f| FileUtils.rm_rf f }
      end
      
    end
    
    describe "can copy and rename to .zip for easy browsing without extraction" do
      specify
    end
    
    describe "flattens the file tree when unpacking in classic mode" do
      specify
    end
    
  end
  
  
  # Glob syntax file used to exclude files from the package.
  describe ".srcignore" do
    # -----------------------------
    # TODO: Do this in a rake task?
    # -----------------------------
    
    let(:dir) { 'srcignore' }
    
    around { |t| around_proc.call t }
    
  
    it "bundles common project files" do
      # .apw, .axi, .axs, .ir, .jar, .kpd, .tkn, .tko, .tp4
      pending
    end
    
    it "can exclude files from the file search" do
      # .ai, .bmp, .eps, .jpg, .jpeg, .png, .psd, .src, .svg
      #
      # Just tack this onto a glob so specific file names can also
      # be excluded.
      pending
    end
  
  end
  
  
  describe "'Read This File' warning file" do
    
    let(:dir) { 'read_file_warning' }
    
    around { |t| around_proc.call t }
    
    
    it "is created in the package" do
      pending
    end
    
    it "is removed when unpacked with this utility" do
      pending
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