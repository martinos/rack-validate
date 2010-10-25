require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Rack::Validate do

  # Note: Both of these tests require an internet connection to run...
  # not sure how to properly mock out the validator without making them pointless.
  it "return 0 errors on valid html page when rack-validate params set to true" do
    valid_html = <<EOF
<!DOCTYPE html>
<html lang="en-ca">
  <head>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8">
    <title>HTML 5 Example</title>
  </head>
  <body>
    <p>This is a sample HTML 5 document.</p>
    <section>
	  <h1>Example of paragraphs</h1>
	  This is the <em>first</em> paragraph in this example.
	  <p>This is the second.</p>
	  <!-- This is not a paragraph. -->
	</section>
  </body>
</html>
EOF
    req = Rack::MockRequest.new(
      Rack::Validate.new(
        lambda{|env| [200, {'Content-Type' => 'text/html'}, valid_html ]}
    ))

    res = req.get("/?rack-validate=true")
    res.body.should match /There were 0 errors and 0 warnings/
  end
  
  it "return errors on invalid page when rack-validate params set to true" do
    invalid_html = <<EOF
<!DOCTYPE html>
<html lang="en-ca">
  <head>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8">
    <title>HTML 5 Example</title>
  </head>
  <body>
    <p>This is a sample HTML 5 document.</p>
    <div>
    <section>
	  <h1>Example of paragraphs</h1>
	  This is the <em>first</em> paragraph in this example.
	  <p>This is the second.</p>
	  <!-- This is not a paragraph. -->
	</section>
  </body>
</html>
EOF
    req = Rack::MockRequest.new(
      Rack::Validate.new(
        lambda{|env| [200, {'Content-Type' => 'text/html'}, invalid_html ]}
    ))

    res = req.get("/?rack-validate=true")

    res.body.should match /There were 1 errors and 0 warnings/
  end
  
  it "should not touch to plain text body" do
    plain_text = "Hello"
    req = Rack::MockRequest.new(
      Rack::Validate.new(
        lambda{|env| [200, {'Content-Type' => 'text/plain'}, plain_text ]}
    ))

    res = req.get("/?rack-validate=true")

    res.body.should == "Hello"
  end
end