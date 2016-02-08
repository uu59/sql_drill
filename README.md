SQL練習帳

# 実行サンプル

## デフォルト

```console
$ bundle exec rspec -f d
basic
  test table
    初歩
      check (PENDING: No reason given)
    初歩2
      check (PENDING: No reason given)

Pending: (Failures listed here are expected and do not affect your suite's status)

  1) basic test table 初歩 check
     # No reason given
     # ./spec/support/execution.rb:45

  2) basic test table 初歩2 check
     # No reason given
     # ./spec/support/execution.rb:45

Finished in 0.03382 seconds (files took 0.45109 seconds to load)
2 examples, 0 failures, 2 pending
```

## 初歩1を間違えたとき

```console
$ bundle exec rspec -f d
basic
  test table
    初歩
      check (FAILED - 1)
    初歩2
      check (PENDING: No reason given)

Pending: (Failures listed here are expected and do not affect your suite's status)

  1) basic test table 初歩2 check
     # No reason given
     # ./spec/support/execution.rb:46

Failures:

  1) basic test table 初歩 check
     Failure/Error: is_expected.to match_sql expected

       expected: [{"num"=>2, "str"=>"a"}, {"num"=>3, "str"=>"b"}, {"num"=>4, "str"=>"c"}, {"num"=>5, "str"=>"d"}]
            got: [{"id"=>1, "str"=>"a", "num"=>2}, {"id"=>2, "str"=>"b", "num"=>3}, {"id"=>3, "str"=>"d", "num"=>5}, {"id"=>4, "str"=>"c", "num"=>4}]

       SQL:
       select * from test

       Diff:
       @@ -1,19 +1,23 @@
        [
          {
       -    "num": 2,
       -    "str": "a"
       +    "id": 1,
       +    "str": "a",
       +    "num": 2
          },
          {
       -    "num": 3,
       -    "str": "b"
       +    "id": 2,
       +    "str": "b",
       +    "num": 3
          },
          {
       -    "num": 4,
       -    "str": "c"
       +    "id": 3,
       +    "str": "d",
       +    "num": 5
          },
          {
       -    "num": 5,
       -    "str": "d"
       +    "id": 4,
       +    "str": "c",
       +    "num": 4
          }
        ]
     Shared Example Group: "SQL" called from ./spec/basic_spec.rb:21
     # ./spec/support/execution.rb:48:in `block (2 levels) in <top (required)>'
     # ./spec/spec_helper.rb:17:in `block (3 levels) in <top (required)>'
     # ./spec/spec_helper.rb:16:in `block (2 levels) in <top (required)>'

Finished in 0.06121 seconds (files took 0.45248 seconds to load)
2 examples, 1 failure, 1 pending

Failed examples:

rspec ./spec/basic_spec.rb:20 # basic test table 初歩 check
```
