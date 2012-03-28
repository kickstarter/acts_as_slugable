class String
  def to_slug(options = {})
    options[:length] ||= 50

    #normalize chars to ascii
    self.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n, '').to_s.downcase.
      #strip out common punctuation
      gsub(/[\'\"\#\$\,\.\!\?\%\@\(\)]+/, '').
      #replace ampersand chars with 'and'
      gsub(/&/, 'and').
      #replace non-word chars with dashes
      gsub(/[\W^-_]+/, '-').
      #remove double dashes
      gsub(/\-{2}/, '-').
      #removing leading dashes
      gsub(/^-/, '').
      #truncate to a a decent length
      slice(0...options[:length]).
      #remove trailing dashes and whitespace
      gsub(/[-\s]*$/, '')
  end
end
