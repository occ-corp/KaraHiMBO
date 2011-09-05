GEM_ROOT = ENV["GEM_HOME"] || "/var/lib/gems/1.8"

desc "Generate `TAGS' file using ctags"
namespace :emacs do
  task(:tags) do
    command = "ctags-exuberant -a -e -f TAGS --tag-relative -R "
    File.delete("#{RAILS_ROOT}/TAGS") if File.exist?("#{RAILS_ROOT}/TAGS")
    
    system "#{command} #{app_dirs.join(" ")}" || raise("Failed to generate tags.")
  end

  task(:tags_all) do
    command = "ctags -a -e -f TAGS --tag-relative -R "
    File.delete("#{RAILS_ROOT}/TAGS") if File.exist?("#{RAILS_ROOT}/TAGS")
    
	app_dirs << "#{GEM_ROOT}/gems"
    system "#{command} #{app_dirs.join(" ")}" || raise("Failed to generate tags.")
  end
end

def app_dirs
  ["app", "lib", "vendor", "spec"]
end
