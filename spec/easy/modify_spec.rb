require "spec_helper"

describe "更新系" do
  describe "test table" do
    before do
      ActiveRecord::Base.connection.execute <<-SQL
        DROP TABLE IF EXISTS test;
        CREATE TABLE test (
          id SERIAL NOT NULL,
          str VARCHAR NOT NULL DEFAULT '',
          num INTEGER NOT NULL DEFAULT 0
        );
      SQL
    end

    context "初歩" do
      include_context "Modify"

      let(:result_sql) { <<-SQL }
        SELECT num, str FROM test
      SQL

      let(:expected) do
        [
          {"num" => -99, "str" => "abc"}
        ]
      end

      let(:sql) { <<-SQL }
      SQL
    end

    context "初歩2" do
      include_context "Modify"

      let(:result_sql) { <<-SQL }
        SELECT count(*) AS cnt FROM test
      SQL

      let(:expected) do
        [
          {"cnt" => 2}
        ]
      end

      let(:sql) { <<-SQL }
      SQL
    end
  end
end
