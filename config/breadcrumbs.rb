crumb :root do
  link "Home", root_path
end

crumb :requests do
  link "申請一覧", requests_path
  parent :root
end

crumb :request do |request|
  link request.title, request_path(request)
  parent :requests
end

crumb :flows do
  link "承認フロー一覧", flows_path
  parent :root
end

crumb :audit_forms do
  link I18n.t('activerecord.models.audit_form'), audits_path
  parent :root
end
crumb :shops do
  link I18n.t('activerecord.models.shop'), shops_path
  parent :root
end
crumb :categories do
  link I18n.t('activerecord.models.category'), categories_path
  parent :root
end




crumb :flow do |flow|
  link flow.name, flow_path(flow)
  parent :flows
end

crumb :flow_condition_groups do
  link "承認フロー一覧", flow_condition_groups_path
  parent :root
end

crumb :flow_condition_group do |flow_condition_group|
  link flow_condition_group.flow.name, flow_condition_group_path(flow_condition_group)
  parent :flow_condition_groups
end




crumb :user do |user|
  link user.name, edit_user_registration_path(user)
  parent :root
end


# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
