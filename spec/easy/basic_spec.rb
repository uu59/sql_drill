require "spec_helper"

describe "basic" do
  describe "test table" do
    before do
      ActiveRecord::Base.connection.execute <<-SQL
        DROP TABLE IF EXISTS test;
        CREATE TABLE test (
          id SERIAL NOT NULL,
          str VARCHAR NOT NULL DEFAULT '',
          num INTEGER NOT NULL DEFAULT 0
        );

        INSERT INTO test (str, num) VALUES
          ('a', 2), ('b', 3), ('d', 5), ('c', 4)
          ;
      SQL
    end

    context "初歩" do
      include_context "SQL"

      let(:expected) do
        [
          {"num" => 2, "str" => "a"},
          {"num" => 3, "str" => "b"},
          {"num" => 4, "str" => "c"},
          {"num" => 5, "str" => "d"},
        ]
      end

      let(:sql) { <<-SQL }
      SQL
    end

    context "初歩2" do
      include_context "SQL"

      let(:expected) do
        [
          {"num" => 5, "str" => "d"},
          {"num" => 4, "str" => "c"},
          {"num" => 3, "str" => "b"},
        ]
      end

      let(:sql) { <<-SQL }
      SQL
    end
  end
end
