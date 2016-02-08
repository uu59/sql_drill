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

shared_context "SQL" do
  subject { exec(sql) }

  it "check" do
    skip if sql.empty?
    is_expected.to eq expected
  end
end
