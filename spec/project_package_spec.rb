require 'netlinx/project_package'


describe NetLinx::ProjectPackage do
  
  subject { NetLinx::ProjectPackage.new file: file_name }
  
  let(:file_name) { 'sample.zip' }
  let(:pwd) { ENV['RAKE_DIR'] }
  
  let(:around_proc) { Proc.new { |test|
    Dir.chdir "#{pwd}/spec/data/#{dir}"
    test.run
    Dir.chdir pwd
  } }
  
  
  describe ".src package" do
    
    let(:dir) { 'src_package' }
    
    around { |t| around_proc.call t }
    
    
    it "can be packed" do
      subject.pack
    end
    
    it "can be unpacked"
    
    it "can copy and rename to .zip for easy browsing without extraction"
    
    it "flattens the file tree when unpacking in classic mode"
    
  end
  
  
  # Glob syntax file used to exclude files from the package.
  describe ".srcignore" do
    
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