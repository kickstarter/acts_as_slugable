# Acts as slugable readme

Generates a URL slug based on a specific fields (e.g. title).

A url slug is a string derived from a specific field which can the be used in a URL.  For instance, a page with the title **My page** would have a URL slug of **my-page**.

The slug is generated on save and create actions.  If the field has an existing URL slug (like when editing an existing record) the URL slug is preserved.

URL slugs are unique within the specified scope (or all records if no scope is defined).  If the slug already exists within the scope, **-n** is added (e.g. **my-page-0**, **my-page-1**, etc...


## Installation

Add to your Gemfile:

    gem 'acts_as_slugable', :git => 'git@github.com:kickstarter/acts_as_slugable.git'


## Usage examples

In your target table, add a column to hold the URL slug.

### With scope
```
  class Page < ActiveRecord::Base
    acts_as_slugable :source_column => :title, :slug_column => :slug, :scope => :parent
  end
```  

### Without scope
```
  class Post < ActiveRecord::Base
    acts_as_slugable :source_column => :title, :slug_column => :slug
  end
```

###  A sample link

  ```link_to @page.title, :action => 'show', :slug => @page.slug```

### Example usage

  ```
  # app/models/page.rb
  class Page
    def to_param
      slug
    end
  end

  # config/routes.rb
  resources :pages

  # app/controllers/pages_controller.rb
  def index
    @page = Page.create(:name => "my page")
  end

  # app/views/pages/index.html.erb
  <%= url_for @page # generates "/pages/my-page" %>
```
## Testing

The unit tests for this plugin use an in-memory [sqlite3 database](http://www.sqlite.org/).

To execute the unit tests run the default rake task (<tt>rake</tt>). To execute the unit tests but preserve to debug log run **rake test**.

## Credits

Created by [Alex Dunae](http://dunae.ca/), 2006-07, though it takes a village to raise a plugin:

Thanks to [Andrew White](http://pixeltrix.co.uk/) for fixing a conflict with **acts_as_list**.

Thanks to [Philip Hallstrom](http://pjkh.com/) for pointing out some redundant code.
