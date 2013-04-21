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
  watch(%r|^test/(.*)\/?test_(.*)\.rb|)
  watch(%r|^lib/(.*)([^/]+)\.rb|)     { |m| "test/#{m[1]}test_#{m[2]}.rb" }
  watch(%r|^test/minitest_helper\.rb|)    { "test" }

  # Rails 3.2
  watch(%r|^app/controllers/(.*)\.rb|) { |m| "test/controllers/test_#{m[1]}.rb" }
  watch(%r|^app/helpers/(.*)\.rb|)     { |m| "test/helpers/test_#{m[1]}.rb" }
  watch(%r|^app/models/(.*)\.rb|)      { |m| "test/unit/test_#{m[1]}.rb" }

  # Custom
  watch(%r|^test/acceptance/test_(.*)\.rb|)    { "test" }
end
