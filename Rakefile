# frozen_string_literal: true

require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

desc 'Generate RBS files with matching directory structure'
task :typeprof do
  require 'fileutils'

  # Configuration
  target_directories = %w[lib]
  exclude_files = %w[test_helper.rb]

  target_directories.each do |target_dir|
    next unless Dir.exist?(target_dir)

    # Find all Ruby files in the target directory
    ruby_files = Dir.glob("#{target_dir}/**/*.rb")

    # Filter out excluded files
    ruby_files.reject! do |file|
      exclude_files.any? { |exclude| file.end_with?(exclude) }
    end

    ruby_files.each do |ruby_file|
      # Get relative path from target directory
      relative_path = ruby_file.sub(%r{^#{Regexp.escape(target_dir)}/}, '')

      # Create corresponding RBS path under sig/target_dir
      rbs_path = "sig/#{target_dir}/#{relative_path.sub(/\.rb$/, '.rbs')}"

      # Skip if RBS file already exists
      if File.exist?(rbs_path)
        puts "Skipping #{rbs_path} (already exists)"
        next
      end

      # Create directory if it doesn't exist
      FileUtils.mkdir_p(File.dirname(rbs_path))

      # Generate RBS for this specific file
      puts "Generating #{rbs_path} from #{ruby_file}"
      File.open(rbs_path, 'w') do |f|
        system('bundle', 'exec', 'typeprof', ruby_file, out: f)
      end
    end
  end
end

desc 'Run Steep type checking'
task :steep do
  system 'bundle exec steep check'
end

task default: :test
