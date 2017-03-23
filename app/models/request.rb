class Request < ApplicationRecord
  extend Enumerize
  belongs_to :flow
  belongs_to :user
  belongs_to :category
  belongs_to :sub_category
  has_many :request_grants
  has_many :costs, class_name: 'RequestCost'

  has_many :initial_human_cost, class_name: 'RequestInitialHumanCost'
  has_many :monthly_human_cost, class_name: 'RequestMonthlyHumanCost'
  has_many :annual_human_cost,  class_name: 'RequestAnnualHumanCost'
  has_one :initial_money_cost, class_name: 'RequestInitialMoneyCost'
  has_many :monthly_money_cost, class_name: 'RequestMonthlyMoneyCost'
  has_many :annual_money_cost,  class_name: 'RequestAnnualMoneyCost'
  has_many :money_cost,  class_name: 'RequestMoneyCost'

  audited associated_with: :category
  has_associated_audits

  has_many :execution_evidences
  has_many :finishing_evidences
  scope :reviewable_by_role, ->(role) { joins(:request_grants).merge(RequestGrant.where(authenticatable_role: role).with_status('reviewing')) }
  scope :executable, ->(user) { where(status: :wait_for_execution).joins(flow: :executors).merge(FlowExecutor.by_user(user)) }
  scope :displayable_by_user, ->(user) { by_user(user).where.not(status: :finished) }
  scope :by_user, ->(user) { where(user: user) }
  enumerize :status, in: [:not_submitted, :flow_not_defined, :reviewing, :rejected, :executable, :executed, :finished, :wait_for_execution], scope: true
  accepts_nested_attributes_for :finishing_evidences, allow_destroy: true
  accepts_nested_attributes_for :execution_evidences, allow_destroy: true
  accepts_nested_attributes_for :costs, allow_destroy: true

  accepts_nested_attributes_for :initial_human_cost, allow_destroy: true
  accepts_nested_attributes_for :monthly_human_cost, allow_destroy: true
  accepts_nested_attributes_for :annual_human_cost,  allow_destroy: true
  accepts_nested_attributes_for :initial_money_cost, allow_destroy: true
  accepts_nested_attributes_for :monthly_money_cost, allow_destroy: true
  accepts_nested_attributes_for :annual_money_cost,  allow_destroy: true
  accepts_nested_attributes_for :money_cost,  allow_destroy: true

  def unsaved_initial_costs
    initial_human_cost.select{|t| t if  t.new_record? }
  end

  def associated_value(name)
    case 
    when name.in?(%i(initial_money_cost initial_human_cost monthly_human_cost annual_human_cost monthly_money_cost annual_money_cost)) then
      self.__send__(name).try(:cost_value).to_i
    when name.in?(%i(price)) then
      total_money_cost
    end
  end


  def next_request_grant
    request_grants.with_status(:not_judged).order(:position).first
  end

  def current_request_grant
    request_grants.with_status(:reviewing).order(:position).first
  end


  def reviewable?(user)
    reviewable_request_grant(user)
  end
  def reviewable_request_grant(user)
    request_grants.where(authenticatable_role: user.role).with_status('reviewing').first
  end
  private
    def total_money_cost
      initial_money_cost.try(:cost_value).to_i + monthly_money_cost.try(:cost_value).to_i + annual_money_cost.try(:cost_value).to_i
    end


end
