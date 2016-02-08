require "spec_helper"

module Execution
  def raw_conn
    ActiveRecord::Base.connection.instance_variable_get(:@connection)
  end

  def conn
    # ARが型をキャストしてくれないので生PGで
    conn = raw_conn
    conn.type_map_for_results = PG::BasicTypeMapForResults.new(conn)
    conn
  end

  def exec(sql)
    raw_conn.exec(sql)
  end

  def exec_select(sql)
    conn.exec(sql).to_a
  end
end
