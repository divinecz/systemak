class Fixnum
  def to_address
    "%06X" % self
  end
end