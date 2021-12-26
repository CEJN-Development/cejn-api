# == Schema Information
#
# Table name: article_authors
#
#  id         :bigint           not null, primary key
#  author_id  :integer          not null
#  article_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_article_authors_on_author_id_and_article_id  (author_id,article_id)
#
class ArticleAuthor < ActiveRecord::Base
  belongs_to :article
  belongs_to :author, class_name: 'Writer'
end
