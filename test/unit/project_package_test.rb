require 'netlinx/project_package'
require 'test_helper'

describe NetLinx::ProjectPackage do
  
  before do
    @project_package = @object = NetLinx::ProjectPackage.new
  end
  
  after do 
    @project_package = @object = nil
  end
  
  it "bundles common project files" do
    # .apw, .axi, .axs, .ir, .jar, .kpd, .tkn, .tko, .tp4
    skip
  end
  
  it "can exclude files from the file search" do
    # .ai, .bmp, .eps, .jpg, .jpeg, .png, .psd, .src, .svg
    #
    # Just tack this onto a glob so specific file names can also
    # be excluded.
    skip
  end
  
  it "creates a 'Read This File' warning file in the package" do
    skip
  end
  
  it "removes the 'Read This File' warning file when unpacked with this utility" do
    skip
  end
  
  it "copies and renames a .src file to .zip for easy browsing without extraction" do
    skip
  end
  
  it "unpacks .src files" do
    skip
  end
  
  it "flattens the file tree when unpacking a .src file in classic mode" do
    skip
  end
  
  it "can read a .netlinx-package file for config info" do
    # Config file sould be in the project folder.
    # NO user-level config because those settings will be lost when the project
    # is transferred between computers. This could cause problems if a second
    # developer extracts and repacks the project.
    skip
  end
  
end