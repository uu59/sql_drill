RSpec::Matchers.define :match_sql do |expected|
  # http://stackoverflow.com/a/32479025
  match do |actual|
    actual == expected
  end

  failure_message do |actual|
    pa = JSON.pretty_generate(actual).strip
    pe = JSON.pretty_generate(expected).strip

    reset = differ.color? ? "\x1b[0m" : ""
    display_sql = sql.strip_heredoc.strip.lines.map{|l| "#{reset}#{l}"}.join

    message = ""
    message << "expected: #{expected}\n"
    message << "     got: #{actual}\n\n"
    message << "SQL:\n#{display_sql}\n\n"
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
