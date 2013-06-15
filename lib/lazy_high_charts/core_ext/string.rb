class String

  def js_code true_or_false = true
    @_lazy_high_charts_js_code = true_or_false
    self
  end

  def js_code?
    @_lazy_high_charts_js_code || false
  end

end