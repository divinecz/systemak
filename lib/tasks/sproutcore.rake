namespace :sproutcore do
  desc "Build SproutCore application"
  task :build do
    Dir.chdir("sproutcore")
    system("sc-build device_hub --languages=en --clean --build=current --include-required")
    FileUtils.cp_r("tmp/build/static", "../public/static", :remove_destination => true)
  end
end