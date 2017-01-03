# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* TODO

申請時に提携フォーマットにないrequestは一度管理者に投げて管理者が必要な承認フローを作成して実行する

flowと紐づかないrequestを管理者のみflowを作成して紐づけられる機能を作る

request.category作成,category(, sub_category)_を決めるとjobが決まるよにする

request_flow = RequestFlow.generate_by_categries(request.categories)

request_approval_flow
  category_id
  sub_category_id
  job_id

->category_id,sub_category_idをもとにjob_idを取得する

終了ステータスのrequestを非表示に(displayable)

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
