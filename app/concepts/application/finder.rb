module Application
  class Finder < Trailblazer::Finder
    features Sorting

    adapters ActiveRecord
  end
end
