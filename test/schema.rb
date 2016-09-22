ActiveRecord::Schema.define(:version => 0) do
	create_table :pages, :force => true do |t|
		t.column "parent_id", :int
    t.column "draft", :boolean, :null => false, :default => false
    t.column "title", :string, :null => false
    t.column "slug", :string, :null => true
	end
end
