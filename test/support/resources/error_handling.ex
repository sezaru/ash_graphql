defmodule AshGraphql.Test.ErrorHandling do
  @moduledoc "Example resource with error handling module."

  use Ash.Resource,
    domain: AshGraphql.Test.Domain,
    data_layer: Ash.DataLayer.Ets,
    extensions: [AshGraphql.Resource]

  graphql do
    type :error_handling

    mutations do
      create :create_error_handling, :create
    end

    error_handler {ErrorHandler, :handle_error, []}
  end

  actions do
    default_accept(:*)
    defaults([:read, :update, :destroy, :create])
  end

  attributes do
    uuid_primary_key(:id)

    attribute :name, :string do
      allow_nil?(false)
      public?(true)
    end
  end

  identities do
    identity(:name, [:name], pre_check_with: AshGraphql.Test.Domain)
  end
end

defmodule ErrorHandler do
  @moduledoc false
  def handle_error(error, _context) do
    %{error | message: "replaced!"}
  end
end
