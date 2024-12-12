module Api
  module V1
    class NamespaceController < ApplicationController
      before_action :authenticate_request

      private

      def authenticate_request
        api_key = request.headers['Authorization']
        if api_key != ENV['API_KEY']
          head :unauthorized
          return
        end
      end
    end
  end
end
