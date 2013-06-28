describe "TypeScriptFilter" do
  TypeScriptFilter ||= Rake::Pipeline::Typescript::TypeScriptFilter
  MemoryFileWrapper ||= Rake::Pipeline::SpecHelpers::MemoryFileWrapper
  MemoryManifest ||= Rake::Pipeline::SpecHelpers::MemoryManifest

  let(:typescript_input) { <<-TYPESCRIPT }
class Student {
    fullname : string;
    middleInitial : string;
    constructor(public firstname, public middleinitial, public lastname) {
        this.middleInitial = middleinitial;
        this.fullname = firstname + " " + this.middleInitial + " " + lastname;
    }
}

interface Person {
    firstname: string;
    lastname: string;
}

function greeter(person : Person) {
    return "Hello, " + person.firstname + " " + person.lastname;
}

var user = new Student("Jane", "M.", "User");

alert(greeter(user));

  TYPESCRIPT

  let(:expected_typescript_output) { <<-HTML }
var Student = (function () {
    function Student(firstname, middleinitial, lastname) {
        this.firstname = firstname;
        this.middleinitial = middleinitial;
        this.lastname = lastname;
        this.middleInitial = middleinitial;
        this.fullname = firstname + " " + this.middleInitial + " " + lastname;
    }
    return Student;
})();

function greeter(person) {
    return "Hello, " + person.firstname + " " + person.lastname;
}

var user = new Student("Jane", "M.", "User");

alert(greeter(user));

  HTML

  def input_file(name, content)
    MemoryFileWrapper.new("/path/to/input", name, "UTF-8", content)
  end

  def output_file(name)
    MemoryFileWrapper.new("/path/to/output", name, "UTF-8")
  end

  def should_match(expected, output)
    "#{expected}\n".gsub(/\n+/, "\n").should == "#{output}\n".gsub(/\n+/, "\n")
  end

  def setup_filter(filter)
    filter.file_wrapper_class = MemoryFileWrapper
    filter.manifest = MemoryManifest.new
    filter.last_manifest = MemoryManifest.new
    filter.input_files = [input_file("input.typescript", typescript_input)]
    filter.output_root = "/path/to/output"
    filter.rake_application = Rake::Application.new
    filter
  end

  it "generates output" do
    filter = setup_filter TypeScriptFilter.new

    filter.output_files.should == [output_file("input.js")]

    tasks = filter.generate_rake_tasks
    tasks.each(&:invoke)

    file = MemoryFileWrapper.files["/path/to/output/input.js"]
    should_match file.body, expected_typescript_output
    file.encoding.should == "UTF-8"
  end

  describe "naming output files" do
    it "translates .ts extensions to .js by default" do
      filter = setup_filter TypeScriptFilter.new
      filter.output_files.first.path.should == "input.js"
    end

    it "accepts a block to customize output file names" do
      filter = setup_filter(TypeScriptFilter.new { |input| "octopus" })
      filter.output_files.first.path.should == "octopus"
    end
  end

  describe "invalid input" do
    let(:typescript_input) { <<-TYPESCRIPT }
y = function(param : badtype){
  return "This won't compile"
}
    TYPESCRIPT

    it "has a useful error message including the input file name" do
      filter = setup_filter TypeScriptFilter.new
      tasks = filter.generate_rake_tasks
      lambda {
        tasks.each(&:invoke)
      }.should raise_error(ExecJS::RuntimeError, /Error compiling input.typescript.+line 1/i)
    end
  end

end

