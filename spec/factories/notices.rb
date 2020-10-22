FactoryBot.define do
  factory :notice do
    title { "MyString" }
    author { "MyString" }
    published_at { "MyString" }
    content { "MyString" }
    bbs_pk { 1 }
    post_pk { 1 }
    attachments { "" }
    board { nil }
  end
end
