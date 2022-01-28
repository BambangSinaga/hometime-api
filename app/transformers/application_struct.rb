module Types
  include Dry.Types()
end

class ApplicationStruct < Dry::Struct
  include Types
end