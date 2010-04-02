require File.dirname(__FILE__) + '/test_helper'

require File.join(File.dirname(__FILE__), 'fixtures/page')

class ActsAsSlugableTest < ActiveSupport::TestCase
  def test_hooks_presence
    # after_validation callback hooks should exist
    assert Page.after_validation.include?(:create_slug)
    assert Page.after_validation.include?(:create_slug)
  end

  def test_create
    # create, with title
    pg = Page.create(:title => "New page")
    assert pg.valid?
    assert_equal "new-page", pg.url_slug

    # create, with title and url_slug
    pg = Page.create(:title => "Test overrride", :parent_id => nil, :url_slug => "something-different")
    assert pg.valid?
    assert_equal "something-different", pg.url_slug
  end

  def test_model_still_runs_validations
    # create, with nil title
    pg = Page.create(:title => nil)
    assert !pg.valid?
    assert pg.errors.on(:title)

    # create, with blank title
    pg = Page.create(:title => '')
    assert !pg.valid?
    assert pg.errors.on(:title)
  end

  def test_update
    pg = Page.create(:title => "Original page")
    assert pg.valid?
    assert_equal "original-page", pg.url_slug

    # update, with title
    pg.update_attribute(:title, "Updated title only")
    assert_equal "original-page", pg.url_slug

    # update, with title and nil slug
    pg.update_attributes(:title => "Updated title and slug to nil", :url_slug => nil)
    assert_equal "updated-title-and-slug-to-nil", pg.url_slug

    # update, with empty slug
    pg.update_attributes(:title => "Updated title and slug to empty", :url_slug => '')
    assert_equal "updated-title-and-slug-to-empty", pg.url_slug
  end

  def test_uniqueness
    # create two pages with the same title and
    # within the same scope - slugs should be unique
    t = "Unique title"

    pg1 = Page.create(:title => t, :parent_id => 1)
    assert pg1.valid?

    pg2 = Page.create(:title => t, :parent_id => 1)
    assert pg2.valid?

    assert_not_equal pg1.url_slug, pg2.url_slug
  end

  def test_scope
    # create two pages with the same title
    # but not in the same scope - slugs should be the same
    t = "Unique scoped title"

    pg1 = Page.create(:title => t, :parent_id => 1)
    assert pg1.valid?

    pg2 = Page.create(:title => t, :parent_id => 2)
    assert pg2.valid?

    assert_equal pg1.url_slug, pg2.url_slug
  end
end

class StringToSlugTest < ActiveSupport::TestCase
  def setup
    @allowable_characters = Regexp.new("^[A-Za-z0-9_-]+$")
  end

  def test_length
    assert_equal "aaa", "aaa".to_slug(:length => 3)
    assert_equal "bbb", "bbbb".to_slug(:length => 3)
  end

  def test_extended_characters
    assert_equal 'calcule-en-francaise', "calculé en française".to_slug
  end

  def test_length_with_utf8_characters_at_break_point
    assert_equal "aaah", "aaa’hhh".to_slug(:length => 4)
  end

  def test_converting_ampersands
    assert_equal "test-and-test-again", "Test & test again".to_slug
  end

  def test_converting_ampersands_in_long_strings
    assert_equal "aaa-and-b", "aaa & bbb".to_slug(:length => 9)
  end

  def test_sandwiched_punctuation
    assert_equal 'test', "!Test!".to_slug
  end

  def test_characters
    # should convert or replace all unusable characters
    check_for_allowable_characters "Title"
    check_for_allowable_characters "Title and some spaces"
    check_for_allowable_characters "Title-with-dashes"
    check_for_allowable_characters "Title-with'-$#)(*%symbols"
    check_for_allowable_characters "/urltitle/"
  end

  private
    def check_for_allowable_characters(str)
      assert_match @allowable_characters, str.to_slug
    end
end
