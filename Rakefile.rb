

RELEASE   = "0.1.0"
COPYRIGHT = "copyright(c) 2023 kuwata-lab.com all rights reserved"
LICENSE   = "MIT License"


def edit_files(*filenames, verbose: false, &block)
  filenames.each do |filename|
    File.open(filename, 'r+', encoding: 'utf-8') do |f|
      s1 = f.read()
      s2 = yield s1, filename
      if s1 != s2
        f.rewind()
        f.truncate(0)
        f.write(s2)
      end
      if verbose
        indicator = s1 != s2 ? "(changed)" : "(not-changed)"
        puts "* #{indicator} #{filename}"
      end
    end
  end
end


desc "edit files"
task :edit do
  files = [
    "EmacsKicker.app/Contents/SharedSupport/bin/emacskicker",
    "README.md",
    "MIT-LICENSE",
  ]
  edit_files(*files, verbose: true) do |s, filename|
    s = s.gsub(/[\$]Release(: .*? )?[\$]/  , '$'"Release: #{RELEASE} "'$')
    s = s.gsub(/[\$]Copyright(: .*? )?[\$]/, '$'"Copyright: #{COPYRIGHT} "'$')
    s = s.gsub(/[\$]License(: .*? )?[\$]/  , '$'"License: #{LICENSE} "'$')
    if filename == "README.md"
      s = s.gsub(/\/v\d+\.\d+\.\d+\.zip/   , "/v#{RELEASE}.zip")
    end
    s
  end
end
