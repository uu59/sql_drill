shared_context "Read" do
  subject { exec_select(sql) }

  it "check" do
    skip if sql.empty?
    is_expected.to match_sql expected
  end
end

shared_context "Modify" do
  subject { exec_select(result_sql) }

  before { exec(sql) }

  it "check" do
    skip if sql.empty?
    is_expected.to match_sql expected
  end
end
