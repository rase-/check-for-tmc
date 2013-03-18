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
    lines.last.split(" ").count.should == 4c
  end
end