require "jobs/linters_job"

RSpec.describe LintersJob, "for shellcheck" do
  include LintersHelper

  context "when file contains violations" do
    it "reports violations" do
      expect_violations_in_file(
        config: "",
        content: content,
        filename: "foo/bar.sh",
        linter_name: "shellcheck",
        violations: [
          {
            line: 3,
            message: "Double quote to prevent globbing and word splitting.",
          },
        ],
      )
    end
  end

  # context "when custom configuraton is provided" do
  #   it "respects the custom configuration" do
  #     config = <<~EOS
  #       [flake8]
  #       max-line-length = 80
  #       ignore =
  #           # ignore unknown variables
  #           F821
  #     EOS
  #
  #     expect_violations_in_file(
  #       config: config,
  #       content: content,
  #       filename: "foo/bar.py",
  #       linter_name: "flake8",
  #       violations: [
  #         {
  #           line: 1,
  #           message: "'fibo.fib' imported but unused",
  #         },
  #       ],
  #     )
  #   end
  # end

  def content
    <<~EOS
      #!/bin/sh
      hello_world () {
        echo $1
      }
    EOS
  end
end
