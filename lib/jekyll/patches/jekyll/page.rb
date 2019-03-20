module Jekyll
    class Page
        # The generated directory into which the page will be placed
        # upon generation. This is derived from the permalink or, if
        # permalink is absent, will be '/'
        #
        # Returns the String destination directory.
        def dir
          # Jekyll.logger.info "Lang-debug: ", url + "; Data: " + data.to_s
          if url.end_with?("/")
            url
          else
            url_dir = File.dirname(url)
            url_dir.end_with?("/") ? url_dir : "#{url_dir}/"
          end
        end     
    end
end