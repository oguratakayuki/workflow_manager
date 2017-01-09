module FlowDecorator
  def need_evidence_text
    self.need_evidence? ? '必須' : 'あれば'
  end
end
