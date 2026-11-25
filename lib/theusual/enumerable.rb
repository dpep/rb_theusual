module Enumerable
  # whether any elements (or block results) repeat, stopping at the first
  def duplicates?
    seen = Set.new
    any? { |e| !seen.add?(block_given? ? yield(e) : e) }
  end
end
