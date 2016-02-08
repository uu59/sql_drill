require "spec_helper"

module Execution
  def conn
    # ARが型をキャストしてくれないので生PGで
    conn = ActiveRecord::Base.connection.instance_variable_get(:@connection)
    conn.type_map_for_results = PG::BasicTypeMapForResults.new(conn)
    conn
  end

  def exec(sql)
    conn.exec(sql).to_a
  end
end

RSpec::Matchers.define :match_sql do |expected|
  # http://stackoverflow.com/a/32479025
  match do |actual|
    actual == expected
  end

  failure_message do |actual|
    pa = JSON.pretty_generate(actual).strip
    pe = JSON.pretty_generate(expected).strip

    reset = differ.color? ? "\x1b[0m" : ""
    message = ""
    message << "expected: #{expected}\n"
    message << "     got: #{actual}\n\n"
    message << "SQL:\n#{reset}#{sql.strip}\n\n"
    message << "Diff:#{reset}\n" + differ.diff(pa, pe).gsub(/^(?:\e\[0m\n?)*/, "").strip
    message
  end

  def differ
    RSpec::Support::Differ.new(
      :object_preparer => lambda { |object| RSpec::Matchers::Composable.surface_descriptions_in(object) },
      :color => RSpec::Matchers.configuration.color?
    )
  end
end

shared_context "SQL" do
  subject { exec(sql) }

  it "check" do
    skip if sql.empty?
    is_expected.to match_sql expected
  end
end
