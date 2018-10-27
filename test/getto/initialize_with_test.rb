require "test_helper"

require "getto/initialize_with"

module Getto::InitializeWithTest
  class FullParameters
    include Getto::InitializeWith

    initialize_with(
      :name,
      :params,
      repository: [:login_id_not_found?],
      expire: Integer,
    )
  end

  class MissingParameters
    include Getto::InitializeWith

    initialize_with :name, :params
  end

  class AnotherParameters
    include Getto::InitializeWith

    initialize_with :name, :params
  end

  class TypedParameters
    include Getto::InitializeWith

    initialize_with(
      expire: Integer,
    )
  end

  class RespondToParameters
    include Getto::InitializeWith

    initialize_with(
      repository: [:login_id_not_found?],
    )
  end

  class Repository
    def login_id_not_found?
    end
  end

  describe Getto::InitializeWith do
    describe "initialize" do
      it "accept full parameters" do
        repository = Repository.new

        demo = FullParameters.new(
          name:       :name,
          params:     { key: :value },
          repository: repository,
          expire:     10,
        )

        assert_equal demo.name,       :name
        assert_equal demo.params,     { key: :value }
        assert_equal demo.repository, repository
        assert_equal demo.expire,     10
      end

      it "will error with missing params" do
        assert_raises ArgumentError do
          MissingParameters.new(
            name: :name,
          )
        end
      end

      it "will error with another params" do
        assert_raises ArgumentError do
          AnotherParameters.new(
            name:    :name,
            params:  :params,
            unknown: :unknown,
          )
        end
      end

      it "will error with type mismatch params" do
        assert_raises ArgumentError do
          TypedParameters.new(
            expire: "10",
          )
        end
      end

      it "will error with not respond to params" do
        assert_raises ArgumentError do
          RespondToParameters.new(
            repository: nil,
          )
        end
      end
    end
  end
end
