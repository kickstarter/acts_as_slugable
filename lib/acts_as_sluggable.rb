require 'active_record'

module ActsAsSluggable
  def self.defaults
    @defaults ||= {
      :source_column => 'name',
      :slug_column => 'slug',
      :scope => nil,
      :slug_length => 50,
      :when => proc{|r| true }
    }
  end

  # Generates a URL slug based on provided fields and adds <tt>after_validation</tt> callbacks.
  #
  #   class Page < ActiveRecord::Base
  #     acts_as_sluggable :source_column => :title, :slug_column => :slug, :scope => :parent
  #   end
  #
  # Configuration options:
  # * <tt>source_column</tt> - specifies the column name used to generate the URL slug
  # * <tt>slug_column</tt> - specifies the column name used to store the URL slug
  # * <tt>scope</tt> - as a string, specifies a literal SQL restriction. as a symbol, names a column
  #   that must not also match.
  # * <tt>slug_length</tt> - specifies a maximum length for slugs, before any unique suffix is added.
  # * <tt>when</tt> - a block that should return false until the object is ready for a slug. good for drafts.
  def acts_as_sluggable(options = {})
    configuration = ActsAsSluggable.defaults.merge(options)

    define_method(:acts_as_sluggable_config) do
      configuration
    end

    include ActsAsSluggable::InstanceMethods

    after_validation :set_slug
  end

  def self.slug(str, options = {})
    options[:length] ||= 50

    #normalize chars to ascii
    str.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/, '').to_s.downcase.
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
      #truncate to a decent length
      slice(0...options[:length]).
      #remove trailing dashes and whitespace
      gsub(/[-\s]*$/, '')
  end

  module InstanceMethods
    def slug_source
      acts_as_sluggable_config[:source_column]
    end

    def slug_column
      acts_as_sluggable_config[:slug_column]
    end

    def slug_length
      acts_as_sluggable_config[:slug_length]
    end

    def slug_scope
      if scope = acts_as_sluggable_config[:scope]
        scope = {scope => send(scope)} if scope.is_a? Symbol
        self.class.where(scope)
      else
        self.class
      end
    end

    private

    def set_slug
      return if self.errors.size > 0
      return if self[slug_source].blank?
      return if self[slug_column].to_s.present?
      return unless acts_as_sluggable_config[:when].call(self)

      self[slug_column] = generate_slug
    end

    def generate_slug
      slug = ActsAsSluggable.slug(self[slug_source], :length => slug_length)

      suffix = ""
      while slug_scope.where(slug_column => slug + suffix).first
        suffix = suffix.empty? ? "-0" : suffix.succ
      end

      slug + suffix
    end
  end
end

::ActiveRecord::Base.send :extend, ActsAsSluggable
