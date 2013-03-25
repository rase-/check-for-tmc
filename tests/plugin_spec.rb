describe 'TMC C plugin' do 
  before(:each) do
    `make`
    `./tmc-check-example`
  end

  after(:each) do
    `make clean`
  end

  it "produces test output when running with tmc_test_runner" do
    File.exists?("tmc_test_output.xml")
  end

  it "produces a points file when running tests" do
    File.exists?("tmc_available_points.txt")
  end

  it "produces a point file with three rows" do
    f = File.open("tmc_available_points.txt")
    lines = f.readlines
    lines.count.should == 3
  end

  it "produces a point file with two lines giving points for tests" do
    f = File.open("tmc_available_points.txt")
    lines = f.readlines
    rows_with_test_function_points = lines.inject(0) { |rows, line| (line.include? "[test]") ? rows + 1 : rows }
    rows_with_test_function_points.should == 2
  end

  it "produces a point file with one line giving points to test suite" do
    f = File.open("tmc_available_points.txt")
    lines = f.readlines
    rows_with_test_suite_points = lines.inject(0) { |rows, line| (line.include? "[suite]") ? rows + 1 : rows }
    rows_with_test_suite_points.should == 1
  end

  it "produces a point file with point annotations separated by whitespace" do
    f = File.open("tmc_available_points.txt")
    lines = f.readlines
    lines.first.split(" ").count.should == 5
    lines[1].split(" ").count.should == 3
    lines.last.split(" ").count.should == 4
  end

  it "produces a memtest file containing one row, since only one memtest is registered" do
    f = File.open("tmc_memory_test_info.txt")
    lines = f.readlines
    f.close
    lines.count.should == 1
  end

  it "has one memtest for test with name test_foo, testing for memory leaks and maximum heapsize of 10" do
    f = File.open("tmc_memory_test_info.txt")
    lines = f.readlines
    f.close
    split_line = lines.first.split " "
    split_line.first.should == "test_foo"
    split_line[1].should == "1"
    split_line.last.should == "10"
  end
end