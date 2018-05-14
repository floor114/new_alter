module Application
  class Finder < Trailblazer::Finder
    features Sorting

    adapters ActiveRecord

    # TODO: Implement eager loading block
  end
end
