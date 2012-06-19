# -*- encoding : utf-8 -*-
module X9Logger
  module Config
    def out= file_path
      ensure_path_exists file_path
      @out = Logger.new file_path
      @out.datetime_format = "%Y-%m-%d %H:%M:%S"
      @out.formatter = proc do |severity, datetime, progname, msg|
        "#{datetime} [#{sprintf "%5s", severity}] #{$$}: #{msg}\n"
      end
    end

    def out
      @out ||= out=(STDOUT)
    end

    def err= file_path
      ensure_path_exists file_path
      @err = Logger.new file_path
      @err.datetime_format = "%Y-%m-%d %H:%M:%S"
      @err.formatter = proc do |severity, datetime, progname, msg|
        "\n#{datetime} [#{sprintf "%5s", severity}] #{$$}: #{msg}\n"
      end
    end

    def err
      @err ||= out
    end

    private
    def ensure_path_exists file_path
      FileUtils.mkdir_p(File.expand_path "..", file_path) if file_path.kind_of? String
    end
  end
end
