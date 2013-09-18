require 'erb'
require 'benchmark'

module Evilspace
  class Middleware
    def initialize(app, folders = %w{app lib spec features test})
      @app = app
      @folders = folders.select {|f| File.exist?(f)}
      @extensions = %w{rb erb slim haml}
    end

    def call(env)
      bad_food = ""

      html_request = env['HTTP_ACCEPT'].to_s.include?('text/html')

      if html_request
        puts
        print "Evilspace::Middleware in %.1fms" % [100 * Benchmark.realtime {
          folders = @folders.join(' ')
          files = @extensions.map {|e| "-iname '*.#{e}'"}.join(' -or ')
          grep_command = "grep -n -E $'\t|[[:space:]]+$'"
          bad_food = `find #{folders} #{files} | xargs #{grep_command}`
        }]
      end

      if ! html_request || (bad_food.lines.count == 0)
        @app.call(env)
      else
        [
          500,
          { 'Content-Type' => 'text/html' },
          [ <<-HTML ]
            <html>
              <head>
                <style type='text/css'>
                  body { padding: 2em; }
                  pre em {
                    background-color: #fcc;
                    border-right: 1px dotted gray;
                  }
                </style>
              </head>
              <body>
                <h1>Evilspace Alert</h1>
                <h2>Looks like you have tabs in your code</h2>
                <img src="http://i.imgur.com/pVzVU.png" alt="Tabs, spaces, both" width="717" height="325">
                <h2>Or trailing spaces</h2>
                <img src="http://i.imgur.com/OKGrC.png" alt="Evil whitespace" width="484" height="167">
                <h2>The evil whitespace were found here:</h2>
                <pre>#{ERB::Util.html_escape(bad_food).gsub(/\t|[\t ]+$/, '<em>  </em>')}</pre>
                <h2>Please remove it and <a href="">reload the page</a></h2>
              </body>
            </html>
          HTML
        ]
      end
    end
  end
end
