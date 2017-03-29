require 'pathname'
require 'net/http'
require 'json'

BIN_DIR=Pathname.new("../camhd_motion_tracking/build-Release/bin").expand_path
FRAME_STATS= BIN_DIR.join('frame_stats')

CACHE_URL = "https://camhd-app-dev.appspot.com/v1/org/oceanobservatories/rawdata/files"

CONFIG_FILE = ENV['CONFIG_FILE'] || "#{`hostname`.chomp}.txt"

raise "Can't find #{CONFIG_FILE}" unless FileTest.exists? CONFIG_FILE


stride = 100



hostname = `hostname -s`.chomp

task :default => :test

task :test do
  sh "#{FRAME_STATS} --help "
end

task :run do
  paths = []
  File.open( CONFIG_FILE, 'r')  { |f|
    f.readlines.each { |line|

      path = line.chomp
      next if path.size == 0 or path =~ /^\s?\#/

      if path =~ /.mov$/
        paths << path
      else

        uri = CACHE_URL + path
        result = Net::HTTP.get( URI(uri) )

        j = JSON.parse( result )

        if j["Files"]
          j["Files"].each { |file|
            paths << j["Path"] + file if  file =~ /.mov$/
          }
        end
      end
    }

  }

  paths.uniq!

  datadir = "data/#{hostname}"
  mkdir_p datadir unless FileTest.directory? datadir
  chdir datadir do

    paths.each { |path|
      basename = Pathname.new(path).basename
      sh "#{FRAME_STATS} --out #{basename.sub_ext('.json')} --stride #{stride} #{path}"
    }
  end

end
