class ProblemsTopics < ActiveRecord::Migration
   def up
	create_table :problems_topics, :id => false do |t|
	  t.references :problem, :null => false
	  t.references :topic, :null => false
	end

	add_index :problems_topics, [:problem_id, :topic_id]
        add_index :problems_topicss, [:topic_id, :problem_id]
  end

  def down
	drop_table :problems_topics
  end
end
