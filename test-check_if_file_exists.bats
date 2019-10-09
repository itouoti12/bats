#!/usr/bin/env bats

#setup 各テスト実行前に実行されるフック関数
#teardown 各テスト実行後に実行されるフック関数
# runでテスト対象のファイルを実行すると、以下の変数に結果が格納される
# $status コマンドの終了ステータスを格納する変数
# $output コマンドの出力内容を格納する変数
# $line 出力内容の 行ごとに格納する 配列変数



setup() {
  mkdir test_dir
  touch test_file
}

teardown() {
  rmdir test_dir
  rm test_file
}

@test "When no argument provided, it should fail with exit code 1 and print error message" {
  run ./check_if_file_exists.sh
  [ "$status" -eq 1 ]
  [ "${lines[0]}" = "You should specify a file name to check as an argument." ]
}

@test "When more than 1 arguments provided, it should fail with exit code 1 and print error message" {
  run ./check_if_file_exists.sh
  [ "$status" -eq 1 ]
  [ "${lines[0]}" = "You should specify a file name to check as an argument." ]
}

@test "When the provided file is kind of a directory, it should fail with exit code 2 and print error message" {
  run ./check_if_file_exists.sh test_dir
  [ "$status" -eq 2 ]
  [ "${lines[1]}" = "but it seems a directory." ]
}

@test "When the provided filename does not exist, it should fail with exit code 3 and print error message" {
  run ./check_if_file_exists.sh nonexistance
  [ "$status" -eq 3 ]
  [ "${lines[0]}" = "nonexistance does not exist." ]
}

@test "When the provided filename exist, it should end normally with exit code 0 and print message" {
  run ./check_if_file_exists.sh test_file
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "test_file exists." ]
}
