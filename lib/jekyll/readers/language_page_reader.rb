# Frozen-string-literal: true
# Encoding: utf-8

module Jekyll
  class LanguagePageReader < PageReader
    alias_method :read_orig, :read

    def read(files)
      read_orig(files).flat_map do |page|
        # Jekyll.logger.info "Lang-debug: ", "Name: " + page.name + " => " + page.dir
          
        lpages = []
        #TODO: this is a bit hacky. It would be better to directly have access to @dir instance variable
        path = page.url_placeholders[:path]
        lpage = LanguagePage.new(@site, @site.source, path, page.name)
        if lpage.languages
          for language in lpage.languages do
            if lpage.language == language
              lpages << lpage
            elsif lpage.language.nil?
              lpage.data['language'] = language
              lpages << lpage
            else
              lpage2 = LanguagePage.new(@site, @site.source, path, page.name)
              lpage2.data['language'] = language
              lpages << lpage2
            end
          end
        elsif lpage.language
          lpages << lpage
        else
          # no languages -> do not add extended Page
          lpages << page
        end
          
        if (lpage.language or lpage.languages) and lpage["permalink"].nil?
            # Jekyll.logger.info "Lang-debug: ", page.dir + page.name
            # page['language'] = 'en'
            lpages << page
        end
          
        # Jekyll.logger.info "Lang-debug: ", lpages.to_json
        lpages
      end
    end
  end
end
