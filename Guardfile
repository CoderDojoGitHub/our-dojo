# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard_options = {
  cli: "--color -f Nc",
  all_after_pass: false,
  all_on_start: false,
  binstubs: true,
  keep_failed: false
}

guard "minitest", guard_options do
  # with Minitest::Unit
  watch(%r|^test/(.*)\/?(.*)_test\.rb|)
  watch(%r|^lib/(.*)([^/]+)\.rb|)     { |m| "test/#{m[1]}#{m[2]}_test.rb" }
  watch(%r|^test/minitest_helper\.rb|)    { "test" }

  # Rails 3.2
  watch(%r|^app/controllers/(.*)\.rb|) { |m| "test/controllers/#{m[1]}_test.rb" }
  watch(%r|^app/helpers/(.*)\.rb|)     { |m| "test/helpers/#{m[1]}_test.rb" }
  watch(%r|^app/models/(.*)\.rb|)      { |m| "test/models/#{m[1]}_test.rb" }

  # Custom
  watch(%r|^app/views/(.*)/(.*)\.html\.erb|) { |m| "test/acceptance/#{m[1]}/#{m[2]}_test.rb" }
  watch(%r|^app/controllers/(.*)_controller\.rb|) { |m| "test/acceptance/#{m[1]}" }
end
